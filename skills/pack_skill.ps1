$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root  = "C:\Users\Focus Account\Documents\Coach Launch Builder Prompts"
$src   = Join-Path $root "skills\kie-image-gen"
$pyc   = Join-Path $src "scripts\__pycache__"
if (Test-Path $pyc) { Remove-Item -Recurse -Force $pyc }

$skill = Join-Path $root "kie-image-gen.skill"
if (Test-Path $skill) { Remove-Item -Force $skill }

# Files to include, with explicit forward-slash entry names (zip-spec compliant).
$files = @(
  @{ path = (Join-Path $src "SKILL.md");                     entry = "kie-image-gen/SKILL.md" },
  @{ path = (Join-Path $src "scripts\generate.py");          entry = "kie-image-gen/scripts/generate.py" },
  @{ path = (Join-Path $src "scripts\download_images.ps1");  entry = "kie-image-gen/scripts/download_images.ps1" },
  @{ path = (Join-Path $src "scripts\spec.example.json");    entry = "kie-image-gen/scripts/spec.example.json" }
)

$fs = [System.IO.File]::Open($skill, [System.IO.FileMode]::Create)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
foreach ($f in $files) {
  $entry = $zip.CreateEntry($f.entry, [System.IO.Compression.CompressionLevel]::Optimal)
  $es = $entry.Open()
  $bytes = [System.IO.File]::ReadAllBytes($f.path)
  $es.Write($bytes, 0, $bytes.Length)
  $es.Close()
  Write-Host ("  added {0}  ({1} bytes)" -f $f.entry, $bytes.Length)
}
$zip.Dispose(); $fs.Close()
Write-Host "Built: $skill"
