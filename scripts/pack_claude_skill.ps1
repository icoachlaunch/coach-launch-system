# ─────────────────────────────────────────────────────────────────────────────
#  pack_claude_skill.ps1
#
#  Packages a module's builder prompt as a claude.ai custom-skill zip, for
#  Matthew to upload (Settings -> Capabilities -> Skills). Nothing skill-shaped
#  lives in the repo: the prompt is the source, the frontmatter lives below,
#  and the zip lands in dist/ (gitignored).
#
#    powershell -File scripts/pack_claude_skill.ps1 -Module event-magnet
#
#  Output: dist/<skill-name>.zip containing <skill-name>/SKILL.md
#  (claude.ai expects a folder with SKILL.md at its root inside the zip).
# ─────────────────────────────────────────────────────────────────────────────
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Module
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$enc  = [Text.UTF8Encoding]::new($false)
$root = Split-Path $PSScriptRoot -Parent

# ---- frontmatter per module — the only thing that isn't in the prompt -------
$skills = @{
  'event-magnet' = @{
    name = 'event-magnet-builder'
    description = @'
  The Event Magnet™ Builder — turns ONE hot step of a coach's Magic Formula™ into the spec for a
  free, visual tool that pulls the right people toward their event, strategy session, membership or
  application. Scores all nine steps so the client chooses from the whole board, builds the tool
  panel by panel (the AI does the naming and structure, the client answers two questions), then
  writes the event content that positions it in the room — the pain it solves, the walk-away, the
  live teach, the curiosity gap into the full system, and the host lines. Outputs ONE markdown
  document in two parts: PART A, a buildable panel spec for whoever makes the visual, and PART B,
  the content that goes into the masterclass. Use whenever someone wants to build an Event Magnet™,
  a lead tool, a scorecard, audit, cheat sheet, checklist, worksheet, planner or one-page canvas to
  fill an event. It writes the spec and the positioning, never the finished artwork.
'@
  }
}

if (-not $skills.ContainsKey($Module)) {
  throw "No frontmatter defined for module '$Module'. Add an entry to `$skills in this script."
}
$meta = $skills[$Module]

# ---- locate the prompt -------------------------------------------------------
$prompt = Get-ChildItem -Path (Join-Path $root 'modules') -Recurse -Filter "$Module-prompt.md" -File |
          Select-Object -First 1
if (-not $prompt) { throw "Prompt not found: $Module-prompt.md under modules/" }

$body = ([IO.File]::ReadAllText($prompt.FullName, $enc) -replace "`r`n", "`n").Trim("`n")
$front = "---`nname: $($meta.name)`ndescription: >`n$($meta.description.TrimEnd())`n---`n`n"
$skillText = $front + $body + "`n"

# ---- write the zip -----------------------------------------------------------
$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force -Path $dist | Out-Null
$zipPath = Join-Path $dist "$($meta.name).zip"
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

$fs  = [IO.File]::Open($zipPath, [IO.FileMode]::CreateNew)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
$entry  = $zip.CreateEntry("$($meta.name)/SKILL.md", [System.IO.Compression.CompressionLevel]::Optimal)
$stream = $entry.Open()
$bytes  = $enc.GetBytes($skillText)
$stream.Write($bytes, 0, $bytes.Length)
$stream.Close()
$zip.Dispose(); $fs.Close()

# ---- verify by reading it back -----------------------------------------------
$check = [IO.Compression.ZipFile]::OpenRead($zipPath)
$e = $check.GetEntry("$($meta.name)/SKILL.md")
if (-not $e) { $check.Dispose(); throw 'VERIFY FAILED: SKILL.md entry missing from zip' }
$sr = New-Object IO.StreamReader($e.Open(), $enc)
$back = $sr.ReadToEnd(); $sr.Close(); $check.Dispose()

$ok = ($back -ceq $skillText)
$nul = ($enc.GetBytes($back) | Where-Object { $_ -eq 0 }).Count
$bom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)

'{0,-16} {1}' -f 'source',   $prompt.FullName.Substring($root.Length + 1)
'{0,-16} {1}' -f 'skill',    $meta.name
'{0,-16} {1}' -f 'zip',      $zipPath.Substring($root.Length + 1)
'{0,-16} {1} KB' -f 'size',  [math]::Round((Get-Item $zipPath).Length / 1KB, 1)
'{0,-16} {1} lines' -f 'SKILL.md', ($skillText -split "`n").Count
'{0,-16} {1}' -f 'round-trip ==', $ok
'{0,-16} {1}  (expected 0)' -f 'NUL bytes', $nul
'{0,-16} {1}  (expected False)' -f 'BOM', $bom
if (-not $ok -or $nul -or $bom) { exit 1 }
''
'OK — upload dist/' + $meta.name + '.zip at claude.ai -> Settings -> Capabilities -> Skills'
