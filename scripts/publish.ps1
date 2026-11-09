<#
  publish.ps1 -- publish the Coach Launch Training Portal from Google Drive to GitHub Pages.

  Direction is ONE WAY:  Google Drive (edit here)  ->  local clone (git lives here)  ->  GitHub (live portal)

      Drive : G:\Shared drives\CLIENT ENGINE\product-development\cl-engine-builder-prompts   (no .git)
      Clone : C:\Users\Focus Account\coach-launch-system                                    (never edit)
      Live  : https://icoachlaunch.github.io/coach-launch-system/

  Git never lives on Drive: Drive for desktop corrupts .git folders. Publishing is MANUAL on purpose:
  the portal is public, so nothing goes live until Matthew says "publish".

  Usage (from the Drive folder):
      powershell -ExecutionPolicy Bypass -File scripts\publish.ps1
          Dry run (the default). Shows exactly what would go live. Commits nothing.
      powershell -ExecutionPolicy Bypass -File scripts\publish.ps1 -Go -Message "what changed"
          Commits and pushes. Live a minute or two later.
      powershell -ExecutionPolicy Bypass -File scripts\publish.ps1 -FromGitHub
          Brings changes someone pushed straight to GitHub (e.g. publish_funnel_demo.ps1) into Drive.
          Stops and lists any file changed in BOTH places - those are merged by hand.

  Internal docs never go live: PROGRESS.md, PROGRESS-archive.md, CHANGELOG.md, CLAUDE.md (root) and every
  NOTES.md / NOTES-*.md are stripped from the clone before each publish, and -FromGitHub never touches them.

  The last commit Drive was synced with is kept in <clone>.publish-base. Every run first checks
  GitHub hasn't moved past it; if it has, run -FromGitHub before publishing, or the push would undo
  those changes.
#>
param(
  [switch]$Go,
  [string]$Message = '',
  [switch]$FromGitHub,
  [string]$Clone = 'C:\Users\Focus Account\coach-launch-system'
)
$ErrorActionPreference = 'Stop'
$Source   = Split-Path -Parent $PSScriptRoot
$BaseFile = "$Clone.publish-base"
$Live     = 'https://icoachlaunch.github.io/coach-launch-system/'

# Internal docs - kept on Drive (and the private client-engine backup), NEVER published.
# Root files by name, plus every NOTES.md / NOTES-*.md anywhere in the tree. (Matthew, 2026-11-09)
$PrivateRoot = @('PROGRESS.md', 'PROGRESS-archive.md', 'CHANGELOG.md', 'CLAUDE.md')
function IsPrivate([string]$rel) {
  $r = $rel -replace '\\', '/'
  if ($PrivateRoot -contains $r) { return $true }
  $leaf = ($r -split '/')[-1]
  return ($leaf -eq 'NOTES.md' -or $leaf -like 'NOTES-*.md')
}

# --- git -------------------------------------------------------------------
$git = (Get-Command git.exe -ErrorAction SilentlyContinue).Source
if (-not $git) {
  foreach ($p in @("$env:ProgramFiles\Git\cmd\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe")) {
    if (Test-Path $p) { $git = $p; break }
  }
}
if (-not $git) { throw 'git.exe not found.' }

# Every call runs in the clone with core.autocrlf=true - the same line-ending rule the repo was
# always committed with - so Windows line endings on Drive never show up as changes.
function Git { & $git -C $Clone -c core.autocrlf=true @args; if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed" } }
function GitOut { $o = & $git -C $Clone -c core.autocrlf=true @args; if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed" }; return $o }

# Does the Drive file still match the version GitHub had at $rev? (raw bytes or after line-ending rules)
function SameAsRev([string]$rel, [string]$rev) {
  $file = Join-Path $Source $rel
  if (-not (Test-Path -LiteralPath $file)) { return $false }
  $blob = (& $git -C $Clone rev-parse "${rev}:$rel" 2>$null)
  if ($LASTEXITCODE -ne 0 -or -not $blob) { return $false }
  $raw  = (& $git -C $Clone hash-object --no-filters -- "$file").Trim()
  $norm = (& $git -C $Clone -c core.autocrlf=true hash-object --path "$rel" -- "$file").Trim()
  return ($raw -eq $blob.Trim() -or $norm -eq $blob.Trim())
}

# Back to exactly what GitHub has. Uses the clone's OWN line-ending setting (no autocrlf override),
# so the files on disk are byte-for-byte the committed ones and other tools that pull here
# (e.g. publish_funnel_demo.ps1) find a clean clone.
function ResetClone {
  & $git -C $Clone checkout -q main;          if ($LASTEXITCODE -ne 0) { throw 'git checkout failed' }
  & $git -C $Clone reset -q --hard origin/main; if ($LASTEXITCODE -ne 0) { throw 'git reset failed' }
  & $git -C $Clone clean -fdq;                if ($LASTEXITCODE -ne 0) { throw 'git clean failed' }
}

# --- checks ----------------------------------------------------------------
if (-not (Test-Path (Join-Path $Clone '.git'))) { throw "No git clone at $Clone." }
if (-not (Test-Path $BaseFile)) { throw "Missing $BaseFile (the last commit Drive was synced with)." }
if (Test-Path (Join-Path $Source '.git')) {
  Write-Warning "There is still a .git folder on Drive ($Source\.git). It isn't used - delete it when you're ready."
}
$base = (Get-Content $BaseFile -Raw).Trim()

Git fetch -q origin
$remote = (GitOut rev-parse origin/main).Trim()

# --- 1. has GitHub moved past Drive? ---------------------------------------
if ($remote -ne $base) {
  $changes = @(GitOut diff --name-status --no-renames $base $remote)
  Write-Host ''
  Write-Host "GitHub has $($changes.Count) file change(s) that were made outside Drive:" -ForegroundColor Yellow
  $changes | ForEach-Object { Write-Host "   $_" }
  if (-not $FromGitHub) {
    Write-Host ''
    Write-Host 'Bring them into Drive first:  powershell -ExecutionPolicy Bypass -File scripts\publish.ps1 -FromGitHub' -ForegroundColor Yellow
    exit 1
  }
  ResetClone
  $conflicts = @()
  $plan = @()
  foreach ($line in $changes) {
    $st, $rel = $line -split "`t", 2
    if (IsPrivate $rel) { continue }   # internal docs live on Drive only - never taken from GitHub
    $drive = Join-Path $Source $rel
    $driveExists = Test-Path -LiteralPath $drive
    if ($st -eq 'A') {
      if ($driveExists -and -not (SameAsRev $rel $remote)) { $conflicts += $rel } else { $plan += ,@('copy', $rel) }
    } elseif ($st -eq 'D') {
      if ($driveExists -and -not (SameAsRev $rel $base)) { $conflicts += $rel } elseif ($driveExists) { $plan += ,@('delete', $rel) }
    } else {
      if ($driveExists -and -not (SameAsRev $rel $base) -and -not (SameAsRev $rel $remote)) { $conflicts += $rel } else { $plan += ,@('copy', $rel) }
    }
  }
  if ($conflicts.Count -gt 0) {
    Write-Host ''
    Write-Host 'Changed in BOTH places - merge these by hand, then run -FromGitHub again:' -ForegroundColor Red
    $conflicts | ForEach-Object { Write-Host "   $_" }
    exit 1
  }
  foreach ($step in $plan) {
    $drive = Join-Path $Source $step[1]
    if ($step[0] -eq 'copy') {
      New-Item -ItemType Directory -Force -Path (Split-Path -Parent $drive) | Out-Null
      Copy-Item -LiteralPath (Join-Path $Clone $step[1]) -Destination $drive -Force
    } else {
      Remove-Item -LiteralPath $drive -Force
    }
  }
  Set-Content -Path $BaseFile -Value $remote -Encoding ASCII
  Write-Host ''
  Write-Host "Brought $($plan.Count) change(s) into Drive. Drive is now in step with GitHub ($($remote.Substring(0,7)))." -ForegroundColor Green
  exit 0
}

# --- 2. stage Drive in the clone --------------------------------------------
ResetClone
$rc = & robocopy $Source $Clone /MIR /COPY:DT /XD .git /XF desktop.ini *.lnk *.gdoc *.gsheet *.gslides /R:2 /W:5 /NP /NFL /NDL /NJH /NJS
if ($LASTEXITCODE -ge 8) { throw "robocopy failed (exit $LASTEXITCODE): $($rc -join ' ')" }
# Strip the internal docs, so they never go live (and come off the live site if they were there).
foreach ($p in $PrivateRoot) { $f = Join-Path $Clone $p; if (Test-Path -LiteralPath $f) { Remove-Item -LiteralPath $f -Force } }
Get-ChildItem -Path $Clone -Recurse -File -Force -Include 'NOTES.md', 'NOTES-*.md' |
  Where-Object { $_.FullName -notmatch '\\\.git\\' } | Remove-Item -Force
& $git -C $Clone -c core.autocrlf=true -c core.safecrlf=false add -A 2>$null
if ($LASTEXITCODE -ne 0) { throw 'git add failed' }
$status = @(GitOut status --short)

if ($status.Count -eq 0) {
  Write-Host 'Nothing to publish - Drive and the live portal match.' -ForegroundColor Green
  exit 0
}

Write-Host ''
Write-Host "$($status.Count) file(s) would go live:" -ForegroundColor Cyan
$status | ForEach-Object { Write-Host "   $_" }
Write-Host ''

if (-not $Go) {
  ResetClone
  Write-Host 'DRY RUN - nothing committed, nothing live.' -ForegroundColor Yellow
  Write-Host 'To publish:  powershell -ExecutionPolicy Bypass -File scripts\publish.ps1 -Go -Message "what changed"'
  exit 0
}

# --- 3. publish --------------------------------------------------------------
if (-not $Message) { ResetClone; throw 'Add -Message "what changed" to publish.' }
Git commit -q -m $Message
Git push -q origin main
$head = (GitOut rev-parse HEAD).Trim()
Set-Content -Path $BaseFile -Value $head -Encoding ASCII
Write-Host "Published $($head.Substring(0,7)). Live in a minute or two at $Live" -ForegroundColor Green
