# build_workspace_kit.ps1 - assemble the client STARTER KIT zip from its sources.
#
# The kit that clients download (modules/0-foundations/100k-day-client-engine-ai-kit.zip, which
# unzips to the folder "$100K Day Client Engine AI Kit" - Matthew's name, 2026-09-09) is BUILT,
# never hand-edited. The hosted filename stays URL-safe; the dashboard link's download attribute
# hands the client the display name. It went stale twice when it was a hand-made zip (it shipped "$24M" and a
# retired close name for a month). This script is the only way it gets made.
#
# SOURCES (single source of truth for each part):
#   modules/0-foundations/100k-day-ai-workspace/       the hand-written kit: root docs, READMEs, stubs
#   modules/0-foundations/visual-style/brand-kit/       blocks.css + surfaces/  -> Reference/brand-kit/
#   modules/2-money-magnet/sniper-presentation-slides/  SKILL + molds + themes + viewer + image prompts
#   modules/2-money-magnet/cash-flow-engine/            SKILL + phase guides + gallery (templates by live URL)
#   modules/1-offer-matrix/magic-formula-visual/        SKILL + 3 templates + style gallery
#
# WHAT IT DOES: stages a copy, rewrites the relative links that would break outside the repo to
# their live GitHub Pages URLs, verifies the kit (no stale paths, no stale canon, stubs still
# empty, ONE token slot and it is empty), then zips with forward-slash entry names (.NET, not
# Compress-Archive, which writes backslash paths that break on Mac/Linux unzip).
#
# USAGE:  powershell -File scripts/build_workspace_kit.ps1
# This script is ASCII-only on purpose: PowerShell 5.1 reads a BOM-less .ps1 as ANSI.

[CmdletBinding()]
param([switch]$KeepStage)

$ErrorActionPreference = 'Stop'
$root  = Split-Path -Parent $PSScriptRoot
$src   = Join-Path $root 'modules\0-foundations\100k-day-ai-workspace'
$kit   = Join-Path $root 'modules\0-foundations\visual-style\brand-kit'
$zip   = Join-Path $root 'modules\0-foundations\100k-day-client-engine-ai-kit.zip'
$kitFolder = '$100K Day Client Engine AI Kit'   # single-quoted: the $ is literal
$live  = 'https://icoachlaunch.github.io/coach-launch-system/'
$stage = Join-Path ([IO.Path]::GetTempPath()) ('cl-kit-' + [guid]::NewGuid().ToString('N').Substring(0,8))
$top   = Join-Path $stage $kitFolder
$utf8  = New-Object Text.UTF8Encoding($false)
$TM    = [string][char]0x2122

function Copy-Text($from, $to, $rewrites) {
  $t = [IO.File]::ReadAllText($from, [Text.Encoding]::UTF8)
  foreach ($r in $rewrites) {
    # RULE-SHAPE ASSERTION. PowerShell flattens @(@('a','b')) to two plain strings; $r[0] is then the
    # CHARACTER 'h' and String.Replace(char,char) rewrites every 'h' in the file. It happened here: the
    # style gallery shipped as '<link rel="stylesreet" rref=...>'. Wrap a single rule as @( ,@('a','b') ).
    if (-not ($r -is [array]) -or $r.Count -ne 2 -or -not ($r[0] -is [string]) -or $r[0].Length -lt 4) {
      throw "Copy-Text: malformed rewrite rule for $from (each rule must be a 2-string array)"
    }
    $n = ([regex]::Matches($t, [regex]::Escape($r[0]))).Count
    if ($n -lt 1) { throw "Copy-Text: anchor not found in $from : $($r[0])" }
    $t = $t.Replace($r[0], $r[1])
  }
  if ($t -notmatch [regex]::Escape($live)) { throw "Copy-Text: $from was rewritten but carries no live URL - rewrite did not land" }
  $dir = Split-Path -Parent $to
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
  [IO.File]::WriteAllText($to, $t, $utf8)
}
function Copy-Raw($from, $to) {
  $dir = Split-Path -Parent $to
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
  Copy-Item -LiteralPath $from -Destination $to -Force
}

# ---- 1. the hand-written kit (everything except the portal-side setup guide) ------------------
New-Item -ItemType Directory -Path $top | Out-Null
Get-ChildItem -LiteralPath $src -Recurse -File | Where-Object { $_.Name -ne 'workspace-guide.html' } | ForEach-Object {
  $rel = $_.FullName.Substring($src.Length + 1)
  Copy-Raw $_.FullName (Join-Path $top $rel)
}

# ---- 2. the Brand Kit layers that carry no colour (the token slot ships EMPTY) -----------------
Copy-Raw (Join-Path $kit 'blocks.css') (Join-Path $top 'Reference\brand-kit\blocks.css')
Get-ChildItem -LiteralPath (Join-Path $kit 'surfaces') -File | ForEach-Object {
  Copy-Raw $_.FullName (Join-Path $top ('Reference\brand-kit\surfaces\' + $_.Name))
}

# ---- 3. the three delivered skills, light files only, links made absolute ---------------------
$cssLive = $live + 'assets/coach-launch-guide.css'

$s1 = Join-Path $root 'modules\2-money-magnet\sniper-presentation-slides'
$d1 = Join-Path $top 'skills\sniper-presentation-slides'
foreach ($f in 'SKILL.md','README.md','image-prompts.md','coach-launch-molds.html','coach-launch-themes.html','slide-viewer.html') {
  Copy-Raw (Join-Path $s1 $f) (Join-Path $d1 $f)
}

$s2 = Join-Path $root 'modules\2-money-magnet\cash-flow-engine'
$d2 = Join-Path $top 'skills\cash-flow-funnel-builder'
Copy-Raw (Join-Path $s2 'SKILL.md') (Join-Path $d2 'SKILL.md')
$tplLive = $live + 'modules/2-money-magnet/cash-flow-engine/Funnel-templates/'
# the four phase guides link ONLY the shared CSS (their page links go to the gallery, same folder);
# the gallery carries its own styling and links ONLY the templates. Copy-Text asserts every anchor
# exists, so each set gets exactly the rule its content contains - one rule each, hence the ,@() wrap.
$guideRules = @( ,@('href="../../../assets/coach-launch-guide.css"', ('href="' + $cssLive + '"')) )
foreach ($f in 'phase-1-launch-guide.html','phase-2-execute-guide.html','phase-3-growth-guide.html','phase-4-mastery-guide.html') {
  Copy-Text (Join-Path $s2 $f) (Join-Path $d2 $f) $guideRules
}
$galleryRules = @( ,@('href="Funnel-templates/', ('href="' + $tplLive)) )
Copy-Text (Join-Path $s2 'funnel-examples.html') (Join-Path $d2 'funnel-examples.html') $galleryRules

$s3 = Join-Path $root 'modules\1-offer-matrix\magic-formula-visual'
$d3 = Join-Path $top 'skills\magic-formula-visual'
Copy-Raw (Join-Path $s3 'SKILL.md') (Join-Path $d3 'SKILL.md')
Get-ChildItem -LiteralPath (Join-Path $s3 'templates') -File | ForEach-Object {
  Copy-Raw $_.FullName (Join-Path $d3 ('templates\' + $_.Name))
}
# ONE rule -> the leading comma keeps it a 1-element array of a 2-string array (see Copy-Text)
$stylesRules = @( ,@('href="../../0-foundations/visual-style/brand-kit/tokens/crimson.css"', ('href="' + $live + 'modules/0-foundations/visual-style/brand-kit/tokens/crimson.css"')) )
Copy-Text (Join-Path $s3 'magic-formula-visual-styles.html') (Join-Path $d3 'magic-formula-visual-styles.html') $stylesRules

# ---- 4. verify -----------------------------------------------------------------------------------
$files = Get-ChildItem -LiteralPath $top -Recurse -File
$fail = @()
$textFiles = $files | Where-Object { $_.Extension -in '.md','.html','.css','.txt','.json' }
foreach ($f in $textFiles) {
  $t = [IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
  $rel = $f.FullName.Substring($top.Length + 1)
  if ($rel -notlike 'skills\*') {
    # case-sensitive: the old folder was 'Foundations/'; live URLs legitimately contain '0-foundations/'
    if ($t -cmatch 'Foundations/')           { $fail += "$rel : stale 'Foundations/' path (the folder is Reference/ now)" }
    if ($t -match 'Client Engine/[1-9]-')     { $fail += "$rel : stale step-folder path (Client Engine holds the three pillar folders now)" }
    if ($t -match 'pass-sessions/')          { $fail += "$rel : stale pass-sessions/ (sessions live in 4a-pass-instrument/sessions/)" }
    if ($t -match 'PROJECT-INSTRUCTIONS')    { $fail += "$rel : mentions PROJECT-INSTRUCTIONS" }
    # legacy terms: ignore the paragraph that LISTS them as banned (it wraps over several lines),
    # and the house tool 'Money Model Builder'
    $tt = ([regex]::Split($t, '\r?\n[ \t]*\r?\n') | Where-Object { $_ -notmatch '(?i)legacy' }) -join "`n`n"
    if ($tt -match 'Fletcher|Customer Engine|(?<!Money )Model Builder|Product Roadmap|\bMDM\b') { $fail += "$rel : legacy term" }
  }
  if ($t -match '\$24M\b' -or $t -match '\$24 Million') { $fail += "$rel : stale founder figure" }
  if ($f.Extension -eq '.html' -and $t -match 'href="\.\./') { $fail += "$rel : relative ../ href would break outside the repo" }
  if ($f.Extension -eq '.html' -and ($t -notmatch '(?i)<html' -or $t -notmatch '(?i)</html>' -or $t -notmatch '(?i)<link rel="stylesheet"|<style')) { $fail += "$rel : not a whole HTML document - structure damaged?" }
  if ($t.IndexOf([char]0) -ge 0)           { $fail += "$rel : NUL bytes" }
  if ($t -match '\$''\\n''')                { $fail += "$rel : leftover shell newline marker" }
  if ($t -match [string][char]0x00E2)        { $fail += "$rel : mojibake (U+00E2)" }
}
foreach ($stub in 'business-brand-profile','brand-voice','visual-style-guide','products-and-pricing','competitive-landscape') {
  $p = Join-Path $top ('Reference\' + $stub + '.md')
  if (-not (Test-Path $p)) { $fail += "Reference/$stub.md missing"; continue }
  if ((Get-Content -LiteralPath $p -Raw -Encoding UTF8) -notmatch 'status: empty') { $fail += "Reference/$stub.md is not an empty stub" }
}
$tok = Get-ChildItem -LiteralPath (Join-Path $top 'Reference\brand-kit\tokens') -File
if (($tok | Where-Object { $_.Extension -eq '.css' }).Count -ne 0) { $fail += "tokens/ must ship EMPTY (one Kit is installed by the client)" }
foreach ($must in 'README.md','CLAUDE.md','CONTEXT.md','PROGRESS.md','Reference\brand-kit\README.md','Reference\brand-kit\tokens\README.md','Client Engine\README.md','Client Engine\Offer Matrix\README.md','Client Engine\Money Magnet\README.md','Client Engine\Client Flywheel\README.md','skills\README.md',
                  'skills\sniper-presentation-slides\SKILL.md','skills\cash-flow-funnel-builder\SKILL.md','skills\magic-formula-visual\SKILL.md') {
  if (-not (Test-Path (Join-Path $top $must))) { $fail += "missing: $must" }
}
$readmes = Get-ChildItem -LiteralPath (Join-Path $top 'Client Engine') -Recurse -Directory | Where-Object { -not (Test-Path (Join-Path $_.FullName 'README.md')) }
foreach ($d in $readmes) { $fail += ('Client Engine folder without README: ' + $d.FullName.Substring($top.Length + 1)) }
$pillars = ((Get-ChildItem -LiteralPath (Join-Path $top 'Client Engine') -Directory | Select-Object -ExpandProperty Name | Sort-Object) -join '|')
if ($pillars -ne 'Client Flywheel|Money Magnet|Offer Matrix') { $fail += "Client Engine must hold exactly the three pillar folders (got: $pillars)" }
if ($fail.Count -gt 0) { $fail | ForEach-Object { Write-Host ("FAIL  " + $_) -ForegroundColor Red }; throw "kit verification failed ($($fail.Count))" }

# ---- 5. zip (forward-slash entries, UTF-8 names) -----------------------------------------------
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
if (Test-Path $zip) { Remove-Item -LiteralPath $zip -Force }
$archive = [IO.Compression.ZipFile]::Open($zip, [IO.Compression.ZipArchiveMode]::Create)
try {
  foreach ($f in ($files | Sort-Object FullName)) {
    $entry = $kitFolder + '/' + $f.FullName.Substring($top.Length + 1).Replace('\', '/')
    [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($archive, $f.FullName, $entry, [IO.Compression.CompressionLevel]::Optimal) | Out-Null
  }
} finally { $archive.Dispose() }

# ---- 6. report -----------------------------------------------------------------------------------
$tmCount = 0
foreach ($f in $textFiles) { $tmCount += ([regex]::Matches([IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8), $TM)).Count }
"kit built : $zip"
"files     : $($files.Count)   size on disk: {0:N0} KB   zip: {1:N0} KB   trade-marks: $tmCount" -f (($files | Measure-Object Length -Sum).Sum / 1KB), ((Get-Item $zip).Length / 1KB)
"folders   :"
Get-ChildItem -LiteralPath $top -Recurse -Directory | ForEach-Object { '  ' + $_.FullName.Substring($top.Length + 1).Replace('\','/') + '/' }
if (-not $KeepStage) { Remove-Item -LiteralPath $stage -Recurse -Force } else { "stage kept: $stage" }
