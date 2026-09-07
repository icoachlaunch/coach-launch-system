# sync_dashboard_prompts.ps1 - keep dashboard.html's embedded prompts equal to the .md files.
#
# THE INVARIANT: dashboard.html carries a copy of every builder prompt as a JSON string so
# the Download buttons work offline. That copy drifts silently the moment anyone edits a
# prompt on disk - the dashboard then hands clients a stale version with no error anywhere.
#
# USAGE
#   powershell -File scripts/sync_dashboard_prompts.ps1            # report drift only
#   powershell -File scripts/sync_dashboard_prompts.ps1 -Apply     # rewrite the stale ones
#
# WHY IT WALKS THE STRING INSTEAD OF USING A REGEX: prompt text contains escaped quotes,
# backslashes and newlines. A regex for "key": "...(.*?)" stops at the first escaped quote
# and silently truncates a prompt. This finds the opening quote and then walks forward
# honouring backslash escapes, which is the only reliable way to find the real end.
#
# ENCODING: dashboard.html is large and must stay UTF-8 with NO BOM. Always read and write
# through [IO.File] - Get-Content -Raw reads it as ANSI on this host and mangles every
# trade-mark sign.

[CmdletBinding()]
param([switch]$Apply)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$dashPath = Join-Path $root 'dashboard.html'
if (-not (Test-Path $dashPath)) { throw "dashboard.html not found at $dashPath" }

$utf8 = New-Object Text.UTF8Encoding($false)
$dash = [IO.File]::ReadAllText($dashPath)

# find the end of a JSON string that starts at $open (the index of its opening quote)
function Find-StringEnd([string]$s, [int]$open) {
  $i = $open + 1
  while ($i -lt $s.Length) {
    $c = $s[$i]
    if ($c -eq '\') { $i += 2; continue }
    if ($c -eq '"') { return $i }
    $i++
  }
  throw "Unterminated JSON string starting at $open"
}

# every embedded prompt key
$keys = @()
foreach ($m in [regex]::Matches($dash, '"([a-z0-9-]+-prompt)":\s*"')) {
  if ($keys -notcontains $m.Groups[1].Value) { $keys += $m.Groups[1].Value }
}
if ($keys.Count -eq 0) { throw 'No embedded prompts found in dashboard.html' }

$stale = @(); $missing = @(); $ok = 0
$edits = @()   # @{ start; end; json }

foreach ($key in $keys) {
  $md = Get-ChildItem -Path (Join-Path $root 'modules') -Recurse -Filter "$key.md" -File -ErrorAction SilentlyContinue |
        Select-Object -First 1
  if (-not $md) { $missing += $key; continue }

  $disk = [IO.File]::ReadAllText($md.FullName)

  $km = [regex]::Match($dash, '"' + [regex]::Escape($key) + '":\s*"')
  $open = $km.Index + $km.Length - 1
  $close = Find-StringEnd $dash $open
  $embeddedRaw = $dash.Substring($open, $close - $open + 1)
  $embedded = (ConvertFrom-Json ('{"v":' + $embeddedRaw + '}')).v

  if ($embedded -ceq $disk) { $ok++; continue }

  $stale += $key
  $json = ConvertTo-Json $disk -Compress    # includes the surrounding quotes
  $edits += @{ start = $open; end = $close; json = $json; key = $key }
}

Write-Output ("prompts embedded : " + $keys.Count)
Write-Output ("in sync          : $ok")
Write-Output ("stale            : " + $stale.Count + $(if ($stale.Count) { "  [" + ($stale -join ', ') + "]" } else { "" }))
if ($missing.Count) { Write-Output ("no .md on disk   : " + ($missing -join ', ')) }

if (-not $stale.Count) { Write-Output 'OK - nothing to do'; return }
if (-not $Apply) { Write-Output ''; Write-Output 'Re-run with -Apply to rewrite them.'; return }

# apply back-to-front so earlier indexes stay valid
foreach ($e in ($edits | Sort-Object { $_.start } -Descending)) {
  $dash = $dash.Substring(0, $e.start) + $e.json + $dash.Substring($e.end + 1)
}

# ---- verify before writing ----
$tmCount  = ([regex]::Matches($dash, [char]0x2122)).Count
$nulCount = ([regex]::Matches($dash, "`0")).Count
if ($nulCount -ne 0) { throw "Refusing to write: $nulCount NUL bytes in the result" }

[IO.File]::WriteAllText($dashPath, $dash, $utf8)

# ---- verify after writing ----
$after = [IO.File]::ReadAllText($dashPath)
$bytes = [IO.File]::ReadAllBytes($dashPath)
$hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
if ($hasBom) { throw 'Refusing: dashboard.html was written with a BOM' }

$reOk = 0
foreach ($e in $edits) {
  $md = Get-ChildItem -Path (Join-Path $root 'modules') -Recurse -Filter ($e.key + '.md') -File | Select-Object -First 1
  $km = [regex]::Match($after, '"' + [regex]::Escape($e.key) + '":\s*"')
  $open = $km.Index + $km.Length - 1
  $close = Find-StringEnd $after $open
  $val = (ConvertFrom-Json ('{"v":' + $after.Substring($open, $close - $open + 1) + '}')).v
  if ($val -ceq [IO.File]::ReadAllText($md.FullName)) { $reOk++ }
}

Write-Output ''
Write-Output ("rewritten        : " + $edits.Count)
Write-Output ("verified == disk : $reOk / " + $edits.Count)
Write-Output ("trade-mark signs : $tmCount")
Write-Output ("NUL bytes        : $nulCount  (expected 0)")
Write-Output ("BOM              : $hasBom  (expected False)")
if ($reOk -ne $edits.Count) { throw 'Verification FAILED - dashboard does not match disk' }
Write-Output 'OK'
