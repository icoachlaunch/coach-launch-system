cd "C:\Users\Focus Account\Documents\Coach Launch Builder Prompts"
git add -A 2>&1 | Out-Null
git commit -m "Package Presentation Engine as 3 client deliverables (Guide + Slide Builder Skill + Slide Viewer Template); add skills/presentation-engine/SKILL.md; wire into dashboard + index" 2>&1 | Select-Object -Last 1
git push origin main 2>&1 | Select-Object -Last 2
git rm -q --ignore-unmatch -- "scripts\_push2.ps1" 2>&1 | Out-Null
Remove-Item -Force -ErrorAction SilentlyContinue "scripts\_push2.ps1"
