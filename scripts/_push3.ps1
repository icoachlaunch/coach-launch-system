cd "C:\Users\Focus Account\Documents\Coach Launch Builder Prompts"
git add -A 2>&1 | Out-Null
git commit -m "Add .nojekyll so GitHub Pages serves raw files (SKILL.md, underscore files) without Jekyll processing" 2>&1 | Select-Object -Last 1
git push origin main 2>&1 | Select-Object -Last 2
git rm -q --ignore-unmatch -- "scripts\_push3.ps1" 2>&1 | Out-Null
Remove-Item -Force -ErrorAction SilentlyContinue "scripts\_push3.ps1"
