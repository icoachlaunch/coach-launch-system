# Agent profile photos

The Training Portal (`dashboard.html`) shows a photo for each agent from this folder.
If a photo is missing, the dashboard automatically falls back to the built-in illustration —
so it never looks broken.

## Expected files (square images work best)

| File          | Agent                         |
|---------------|-------------------------------|
| `maya.jpg`    | Social & Authority Agent      |
| `leo.jpg`     | Show-Up & Follow-Up Agent     |
| `sofia.jpg`   | Enrollment & Objection Agent  |
| `marcus.jpg`  | Ad Optimization Agent         |
| `priya.jpg`   | Metrics & Money-Model Agent   |
| `jack.jpg`    | List Reactivation Agent       |

## Two ways to add them

1. **Auto-generate (Kie.ai):** run `scripts/generate_agent_photos.ps1` (right-click → Run with
   PowerShell), paste your Kie.ai key, wait ~1–2 min. All six land here automatically.

2. **Manual:** drop in your own square headshots named exactly as above (`.jpg`). Refresh the dashboard.

Tip: square (1:1) images look best since the avatars are circular.
