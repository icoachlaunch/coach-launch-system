# Kie.ai headshot filler generator (host + avatars). Reads key from $env:KIE_KEY (not stored here).
param([string]$OutDir)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$key = $env:KIE_KEY
if (-not $key) { Write-Error "KIE_KEY env var not set"; exit 1 }
if (-not $OutDir) { Write-Error "Pass -OutDir"; exit 1 }
if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }

$style = "professional headshot, photorealistic, high quality, friendly genuine smile, looking at camera, plain soft neutral studio background, no text, no watermark"

$specs = @(
  @{ name="host";    prompt="A warm, confident business coach, waist-up professional portrait" },
  @{ name="avatar1"; prompt="A smiling middle-aged man in smart-casual attire" },
  @{ name="avatar2"; prompt="A smiling professional woman in smart-casual attire" },
  @{ name="avatar3"; prompt="A smiling young man of South Asian descent in a collared shirt" },
  @{ name="avatar4"; prompt="A smiling professional woman of Black ethnicity in smart-casual attire" }
)

$headers = @{ "Authorization" = "Bearer $key"; "Content-Type" = "application/json" }
$got = 0
foreach ($s in $specs) {
  $full = "$($s.prompt), $style"
  $body = @{ model="google/nano-banana"; input=@{ prompt=$full; aspect_ratio="1:1" } } | ConvertTo-Json -Depth 6
  Write-Host "[$($s.name)] submitting..."
  try { $sub = Invoke-RestMethod -Uri "https://api.kie.ai/api/v1/jobs/createTask" -Method Post -Headers $headers -Body $body } catch { Write-Host "  submit FAILED: $($_.Exception.Message)"; continue }
  $tid = $sub.data.taskId
  if (-not $tid) { Write-Host "  no taskId (code $($sub.code) $($sub.msg))"; continue }
  $url = $null
  for ($i=0; $i -lt 60; $i++) {
    Start-Sleep -Seconds 3
    try { $rec = Invoke-RestMethod -Uri "https://api.kie.ai/api/v1/jobs/recordInfo?taskId=$tid" -Method Get -Headers $headers } catch { continue }
    if ($rec.data.state -eq "success") { $url = ($rec.data.resultJson | ConvertFrom-Json).resultUrls[0]; break }
    if ($rec.data.state -eq "fail") { Write-Host "  FAILED: $($rec.data.failMsg)"; break }
  }
  if (-not $url) { Write-Host "  [$($s.name)] no url (timeout/fail)"; continue }
  $out = Join-Path $OutDir "$($s.name).jpg"
  try { Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing; $kb=[math]::Round((Get-Item $out).Length/1KB); Write-Host "  [$($s.name)] downloaded ${kb}KB"; $got++ } catch { Write-Host "  [$($s.name)] download FAILED: $($_.Exception.Message)" }
}
Write-Host "DONE. Got $got/$($specs.Count) images."
