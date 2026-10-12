<#
  Publish the Cash Flow Engine(TM) funnel demo pages to GitHub Pages.

  The pages are BUILT elsewhere (the funnel builder's scripts/build_demo.py) and handed over as one zip
  whose paths start at the repo root:
      modules/2-money-magnet/cash-flow-engine/funnel-examples.html
      modules/2-money-magnet/cash-flow-engine/Funnel-templates/PHASE-*/*.html
      modules/2-money-magnet/cash-flow-engine/Funnel-templates/assets/examples/*.jpg
      (optional) PROGRESS.md, CLAUDE.md          - only if .base matches the current HEAD
      .base                                      - the commit the zip was built against

  Usage:
      powershell -ExecutionPolicy Bypass -File scripts\publish_funnel_demo.ps1 -Zip "<path to zip>"
      [-Message "commit message"]  [-Repo "<path to local clone>"]

  What it does: pulls, replaces Funnel-templates/ wholesale (so removed pages disappear),
  copies the gallery and any doc files, commits, pushes. Live a minute or two later at
  https://icoachlaunch.github.io/coach-launch-system/modules/2-money-magnet/cash-flow-engine/funnel-examples.html
#>
param(
  [Parameter(Mandatory = $true)][string]$Zip,
  [string]$Repo = '',
  [string]$Message = "Cash Flow Engine funnel demo: update pages"
)
$ErrorActionPreference = 'Stop'
if (-not $Repo) { $Repo = Split-Path -Parent $PSScriptRoot }   # Windows PowerShell 5.1 can't use $PSScriptRoot in param defaults
if (-not (Test-Path $Zip)) { throw "Zip not found: $Zip" }

git -C $Repo pull --ff-only
if ($LASTEXITCODE -ne 0) { throw "git pull failed - sort out local changes first." }
$head = (git -C $Repo rev-parse HEAD).Trim()

$tmp = Join-Path ([IO.Path]::GetTempPath()) ("cfe-demo-" + [guid]::NewGuid().ToString('N'))
Expand-Archive -Path $Zip -DestinationPath $tmp -Force
try {
  $mod = 'modules\2-money-magnet\cash-flow-engine'
  $srcTpl = Join-Path $tmp "$mod\Funnel-templates"
  if (-not (Test-Path $srcTpl)) { throw "Zip has no $mod\Funnel-templates - wrong zip?" }

  # doc files ride along only if nobody has changed the repo since the zip was built
  $base = ''
  if (Test-Path (Join-Path $tmp '.base')) { $base = (Get-Content (Join-Path $tmp '.base') -Raw).Trim() }
  $docs = @('PROGRESS.md', 'CLAUDE.md') | Where-Object { Test-Path (Join-Path $tmp $_) }
  if ($docs.Count -gt 0 -and $base -ne $head) {
    throw "The repo moved on since this zip was built ($base -> $head). Pages are fine, but the doc edits would overwrite newer work. Rebuild the zip from the current repo."
  }

  $dstTpl = Join-Path $Repo "$mod\Funnel-templates"
  if (Test-Path $dstTpl) { Remove-Item $dstTpl -Recurse -Force }
  Copy-Item $srcTpl $dstTpl -Recurse
  Copy-Item (Join-Path $tmp "$mod\funnel-examples.html") (Join-Path $Repo "$mod\funnel-examples.html") -Force
  foreach ($d in $docs) { Copy-Item (Join-Path $tmp $d) (Join-Path $Repo $d) -Force }
  foreach ($f in Get-ChildItem (Join-Path $tmp 'scripts') -File -ErrorAction SilentlyContinue) {
    Copy-Item $f.FullName (Join-Path $Repo "scripts\$($f.Name)") -Force
  }
} finally { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }

git -C $Repo add -A -- "modules/2-money-magnet/cash-flow-engine" scripts PROGRESS.md CLAUDE.md
$staged = git -C $Repo diff --cached --name-only
if (-not $staged) { Write-Host "Nothing changed - already up to date."; exit 0 }
if (-not (git -C $Repo config user.email)) {
  # a fresh clone has no author; reuse the identity of the repo's own history
  $who = (git -C $Repo log -1 --format='%an|%ae').Trim().Split('|')
  git -C $Repo config user.name $who[0]; git -C $Repo config user.email $who[1]
}
git -C $Repo commit -q -m $Message
if ($LASTEXITCODE -ne 0) { throw "git commit failed." }
git -C $Repo push -q
if ($LASTEXITCODE -ne 0) { throw "git push failed." }
$sha = (git -C $Repo rev-parse --short HEAD).Trim()
Write-Host "Pushed $sha ($(@($staged).Count) files)."
Write-Host "Gallery: https://icoachlaunch.github.io/coach-launch-system/modules/2-money-magnet/cash-flow-engine/funnel-examples.html"
