cd "C:\Users\Focus Account\Documents\Coach Launch Builder Prompts"
git add -A 2>&1 | Out-Null
git commit -m "Rename to Sniper Presentation Slides (Step 4 Part 2 of The Sniper Close); package into /sniper-presentation-slides/ kit folder; rewire dashboard + index; retire standalone prompt" 2>&1 | Select-Object -Last 1
git push origin main 2>&1 | Select-Object -Last 2
Start-Sleep -Seconds 25
$base = "https://icoachlaunch.github.io/coach-launch-system/"
$paths = @("dashboard.html","sniper-presentation-slides/guide.html","sniper-presentation-slides/slide-viewer.html","sniper-presentation-slides/SKILL.md","index.html")
foreach ($p in $paths) {
  try { $r = Invoke-WebRequest -Uri ($base + $p) -Method Head -UseBasicParsing -TimeoutSec 25; Write-Output ($r.StatusCode.ToString() + "  " + $p) }
  catch { $c=$_.Exception.Response.StatusCode.value__; Write-Output ("ERR " + $c + "  " + $p) }
}
Remove-Item -Force -ErrorAction SilentlyContinue "scripts\_ship.ps1"
