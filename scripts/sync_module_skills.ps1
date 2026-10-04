# ─────────────────────────────────────────────────────────────────────────────
#  sync_module_skills.ps1
#
#  A delivered SKILL.md is its module's builder prompt with YAML frontmatter on
#  top. Two copies of the same text drift silently — magic-formula-visual's had
#  drifted 65 lines before anyone noticed, including a STEP 3 that still asked
#  clients for a hex code instead of their Brand Kit block.
#
#  This makes the prompt the single source of truth. The frontmatter is the only
#  thing that lives in SKILL.md; everything below it is regenerated.
#
#    powershell -File scripts/sync_module_skills.ps1           # check
#    powershell -File scripts/sync_module_skills.ps1 -Apply    # rewrite the stale ones
#    powershell -File scripts/sync_module_skills.ps1 -Apply -Only event-magnet
#
#  Pairing rule: a SKILL.md is paired with a sibling *-prompt.md in the same
#  folder. A SKILL.md with no sibling prompt is standalone and is left alone.
# ─────────────────────────────────────────────────────────────────────────────
[CmdletBinding()]
param(
  [switch]$Apply,
  [string]$Only
)

$ErrorActionPreference = 'Stop'
$enc  = [Text.UTF8Encoding]::new($false)   # UTF-8, no BOM
$root = Split-Path $PSScriptRoot -Parent

function Split-Frontmatter {
  # returns @{ Front = '...'; Body = '...' } or $null when there's no frontmatter
  param([string]$Text)
  if ($Text -notmatch '^\s*---\r?\n') { return $null }
  $norm = $Text -replace "`r`n", "`n"
  $end  = $norm.IndexOf("`n---", 3)
  if ($end -lt 0) { return $null }
  $closeEnd = $norm.IndexOf("`n", $end + 1)
  if ($closeEnd -lt 0) { return $null }
  @{ Front = $norm.Substring(0, $closeEnd + 1); Body = $norm.Substring($closeEnd + 1) }
}

$pairs = @()
Get-ChildItem -Path (Join-Path $root 'modules') -Recurse -Filter 'SKILL.md' -File | ForEach-Object {
  $dir    = $_.Directory
  $prompt = Get-ChildItem -Path $dir.FullName -Filter '*-prompt.md' -File | Select-Object -First 1
  if ($prompt) {
    $pairs += [pscustomobject]@{
      Module = $dir.Name
      Skill  = $_.FullName
      Prompt = $prompt.FullName
    }
  }
}

if ($Only) { $pairs = $pairs | Where-Object { $_.Module -like "*$Only*" } }

if (-not $pairs) { Write-Host 'no SKILL.md / *-prompt.md pairs found'; exit 0 }

$stale = @(); $ok = @(); $broken = @()

foreach ($p in $pairs) {
  $skillText  = [IO.File]::ReadAllText($p.Skill,  $enc)
  $promptText = [IO.File]::ReadAllText($p.Prompt, $enc)
  $split = Split-Frontmatter $skillText

  if (-not $split) { $broken += $p; continue }

  # a blank line between the frontmatter and the body is cosmetic — ignore leading/trailing newlines
  $bodyNorm   = ($split.Body   -replace "`r`n", "`n").Trim("`n")
  $promptNorm = ($promptText   -replace "`r`n", "`n").Trim("`n")

  if ($bodyNorm -ceq $promptNorm) { $ok += $p; continue }

  $stale += $p
  if ($Apply) {
    [IO.File]::WriteAllText($p.Skill, $split.Front + "`n" + $promptNorm + "`n", $enc)
  }
}

'{0,-18} {1}' -f 'pairs found', $pairs.Count
'{0,-18} {1}' -f 'in sync',     $ok.Count
'{0,-18} {1}  {2}' -f 'stale', $stale.Count, $(if ($stale) { '[' + (($stale.Module) -join ', ') + ']' } else { '' })
if ($broken) {
  '{0,-18} {1}  {2}' -f 'no frontmatter', $broken.Count, ('[' + (($broken.Module) -join ', ') + ']')
  '   a delivered SKILL.md needs YAML frontmatter (name + description) — fix by hand, then re-run'
}

if ($Apply -and $stale) {
  ''
  '{0,-18} {1}' -f 'rewritten', $stale.Count
  $bad = 0
  foreach ($p in $stale) {
    $t = [IO.File]::ReadAllText($p.Skill, $enc)
    $s = Split-Frontmatter $t
    $a = ($s.Body -replace "`r`n", "`n").Trim("`n")
    $b = (([IO.File]::ReadAllText($p.Prompt, $enc)) -replace "`r`n", "`n").Trim("`n")
    if ($a -cne $b) { $bad++; "   VERIFY FAILED: $($p.Module)" }
    $bytes = [IO.File]::ReadAllBytes($p.Skill)
    $nul = ($bytes | Where-Object { $_ -eq 0 }).Count
    $bom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    if ($nul) { $bad++; "   NUL BYTES: $($p.Module) ($nul)" }
    if ($bom) { $bad++; "   BOM: $($p.Module)" }
  }
  '{0,-18} {1} / {2}' -f 'verified == prompt', ($stale.Count - $bad), $stale.Count
  if ($bad) { exit 1 }
}

''
if ($stale -and -not $Apply) { 'Re-run with -Apply to rewrite them.'; exit 1 }
'OK'
