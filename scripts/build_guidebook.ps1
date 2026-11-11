<#
  build_guidebook.ps1 - embeds each chapter's builder prompt into its guidebook page.

  Every guidebook/*.html page carries one block per downloadable file (prompt, skill, library...):
    <script type="application/json" class="embed" data-key="prompt" data-file="x-prompt.md" data-src="../modules/.../x-prompt.md">"..."</script>
  Buttons on the page point at a block with data-copy="key" / data-download="key".
  This script reads each file at data-src (relative to the page), JSON-encodes it
  (with < > & escaped, so it can never close the script tag) and writes it in.
  The .md in modules/ stays the single source of truth.

  Usage:
    powershell -ExecutionPolicy Bypass -File scripts\build_guidebook.ps1          (check only: lists pages that are out of date)
    powershell -ExecutionPolicy Bypass -File scripts\build_guidebook.ps1 -Apply   (re-embeds every out-of-date page)

  Pure ASCII on purpose. Files are read and written as UTF-8 without a BOM.
#>
param([switch]$Apply)

$ErrorActionPreference = 'Stop'
$root  = Split-Path -Parent $PSScriptRoot
$guide = Join-Path $root 'guidebook'
$utf8  = New-Object System.Text.UTF8Encoding($false)

function ConvertTo-JsonString([string]$s) {
  $sb = New-Object System.Text.StringBuilder ($s.Length + 1024)
  [void]$sb.Append('"')
  foreach ($c in $s.ToCharArray()) {
    $n = [int]$c
    switch ($c) {
      '"'  { [void]$sb.Append('\"'); continue }
      '\'  { [void]$sb.Append('\\'); continue }
      "`n" { [void]$sb.Append('\n'); continue }
      "`r" { [void]$sb.Append('\r'); continue }
      "`t" { [void]$sb.Append('\t'); continue }
      default {
        # 60 '<', 62 '>', 38 '&' are written as unicode escapes so embedded text can never close the script tag
        if ($n -lt 32 -or $n -eq 60 -or $n -eq 62 -or $n -eq 38 -or $n -eq 0x2028 -or $n -eq 0x2029) { [void]$sb.Append(('\u{0:x4}' -f $n)) }
        else { [void]$sb.Append($c) }
      }
    }
  }
  [void]$sb.Append('"')
  return $sb.ToString()
}

$rx = New-Object System.Text.RegularExpressions.Regex ('(<script type="application/json" class="embed"[^>]*data-src="([^"]+)"[^>]*>)(.*?)(</script>)', [System.Text.RegularExpressions.RegexOptions]::Singleline)
$stale = 0; $ok = 0; $missing = 0

Get-ChildItem -Path $guide -Filter *.html | ForEach-Object {
  $page = $_.FullName; $name = $_.Name; $dir = $_.DirectoryName
  $html = [IO.File]::ReadAllText($page, $utf8)
  $ms = $rx.Matches($html)
  if ($ms.Count -eq 0) { return }
  $changed = $false
  # Work from the last block to the first so earlier offsets stay valid.
  for ($i = $ms.Count - 1; $i -ge 0; $i--) {
    $m = $ms[$i]; $rel = $m.Groups[2].Value
    $src = [IO.Path]::GetFullPath((Join-Path $dir $rel))
    if (-not (Test-Path $src)) { Write-Host ("MISSING  {0}  ->  {1}" -f $name, $rel); $missing++; continue }
    $json = ConvertTo-JsonString ([IO.File]::ReadAllText($src, $utf8))
    if ($m.Groups[3].Value -ceq $json) { Write-Host ("ok       {0}  {1}" -f $name, $rel); $ok++; continue }
    $stale++
    if ($Apply) {
      $html = $html.Substring(0, $m.Groups[3].Index) + $json + $html.Substring($m.Groups[3].Index + $m.Groups[3].Length)
      $changed = $true
      Write-Host ("EMBEDDED {0}  {1}  ({2:N0} chars)" -f $name, $rel, $json.Length)
    } else {
      Write-Host ("STALE    {0}  {1}  (run with -Apply)" -f $name, $rel)
    }
  }
  if ($changed) { [IO.File]::WriteAllText($page, $html, $utf8) }
}

Write-Host ("`n{0} up to date, {1} {2}, {3} missing source" -f $ok, $stale, $(if ($Apply) { 'embedded' } else { 'out of date' }), $missing)
if ($missing -gt 0) { exit 1 }
