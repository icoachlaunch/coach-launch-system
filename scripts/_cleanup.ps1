$b = "C:\Users\Focus Account\Documents\Coach Launch Builder Prompts"
$targets = @(
  "$b\assets\deck-samples\_preview_system9.png",
  "$b\assets\deck-samples\founder_raw.png",
  "$b\scripts\_fetch_deck_imgs.ps1",
  "$b\scripts\_fetch_founder.ps1",
  "$b\scripts\_fetch_founder2.ps1"
)
foreach ($t in $targets) { Remove-Item -Force -ErrorAction SilentlyContinue $t }
Write-Output "cleaned"
