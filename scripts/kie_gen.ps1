# Kie.ai filler-image generator (reads key from $env:KIE_KEY — key is NOT stored here)
param([string]$OutDir)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$key = $env:KIE_KEY
if (-not $key) { Write-Error "KIE_KEY env var not set"; exit 1 }
if (-not $OutDir) { Write-Error "Pass -OutDir"; exit 1 }
if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }

$style = "professional, high-quality photorealistic, clean modern marketing style, no text, no watermark, no logos"

$specs = @(
  @{ name="hero";          ar="16:9"; prompt="A sleek laptop and desktop monitor on a clean desk displaying colorful business dashboards and growth charts, dark navy studio background with subtle green accent lighting, premium product hero shot" },
  @{ name="qualification"; ar="9:16"; prompt="A confident business coach speaking on stage at a live business event, holding a microphone, dramatic stage lighting with blue and green tones, audience blurred in the foreground, vertical portrait composition" },
  @{ name="step1";         ar="16:9"; prompt="A happy professional working at a laptop in a bright modern home office, warm natural window light, positive and focused, lifestyle photo" },
  @{ name="step2";         ar="16:9"; prompt="A business professional presenting a marketing system on a glass whiteboard covered in diagrams and arrows, modern office, confident and engaging" },
  @{ name="step3";         ar="16:9"; prompt="A small group of entrepreneurs collaborating and celebrating around a laptop in a bright coworking space, high energy and optimistic" },
  @{ name="before";        ar="4:3";  prompt="A stressed frustrated entrepreneur sitting at a laptop with a hand on the forehead in a dim cluttered home office, muted desaturated colors, conveying overwhelm and doubt" },
  @{ name="after";         ar="4:3";  prompt="A happy confident entrepreneur celebrating at a laptop with arms raised in a bright airy modern office, vibrant optimistic colors, sense of success" },
  @{ name="valuestack";    ar="16:9"; prompt="A premium digital course bundle product mockup: a laptop plus floating documents, templates and a workbook arranged neatly, dark navy background with green accent glow, clean e-commerce product shot" }
)

$headers = @{ "Authorization" = "Bearer $key"; "Content-Type" = "application/json" }
$results = @{}

foreach ($s in $specs) {
  $full = "$($s.prompt), $style"
  $body = @{ model="google/nano-banana"; input=@{ prompt=$full; aspect_ratio=$s.ar } } | ConvertTo-Json -Depth 6
  Write-Host "[$($s.name)] submitting ($($s.ar))..."
  try {
    $sub = Invoke-RestMethod -Uri "https://api.kie.ai/api/v1/jobs/createTask" -Method Post -Headers $headers -Body $body
  } catch { Write-Host "  submit FAILED: $($_.Exception.Message)"; continue }
  $tid = $sub.data.taskId
  if (-not $tid) { Write-Host "  no taskId (code $($sub.code) $($sub.msg))"; continue }
  $url = $null
  for ($i=0; $i -lt 60; $i++) {
    Start-Sleep -Seconds 3
    try { $rec = Invoke-RestMethod -Uri "https://api.kie.ai/api/v1/jobs/recordInfo?taskId=$tid" -Method Get -Headers $headers } catch { continue }
    $state = $rec.data.state
    if ($state -eq "success") { $url = ($rec.data.resultJson | ConvertFrom-Json).resultUrls[0]; break }
    if ($state -eq "fail") { Write-Host "  FAILED: $($rec.data.failMsg)"; break }
  }
  if (-not $url) { Write-Host "  [$($s.name)] no url (timeout/fail)"; continue }
  $out = Join-Path $OutDir "$($s.name).jpg"
  try {
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    $kb = [math]::Round((Get-Item $out).Length/1KB)
    Write-Host "  [$($s.name)] downloaded ${kb}KB -> $out"
    $results[$s.name] = $out
  } catch { Write-Host "  [$($s.name)] download FAILED: $($_.Exception.Message)" }
}
Write-Host "DONE. Got $($results.Count)/$($specs.Count) images."
