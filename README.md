# Coach Launch — System Library

The single source of truth for Coach Launch builder prompts, companion guides, and the brand style system. Everything here is on-brand by default.

Brand: **Coach Launch** · System: **The $100K Day Formula™** + **The $100K Day Accelerator™**

---

## What's in here

```
coach-launch-system/
├── modules/                      Every module = its own folder (prompt + guide + extras), grouped by pillar
│   ├── 0-foundations/            Brand Profile · Visual Style · Brand Voice (built before the Formula)
│   ├── 1-offer-matrix/           Pillar 1 · Steps 1–3 — Million Story, Magic Formula, Red Diamond Offer (9 modules)
│   └── 2-money-magnet/           Pillar 2 · Step 4+ — sniper-close, sniper-presentation (+ bits/), sniper-presentation-slides
├── assets/
│   ├── coach-launch-guide.css    The locked stylesheet every guide links to
│   └── agents images/            Agent headshots used on the portal
├── scripts/                      apply_formula_map.py (stamps the 3-pillar/9-step map onto guides) + helpers
├── guides/                       Legacy demo pages only (million-story-guide, style-system)
├── dashboard.html                The Training Portal — the single entry point to every guide + prompt
├── PROGRESS.md                   Build log — read this FIRST; the source of truth for where the build is
└── SETUP-GITHUB.md               One-time GitHub setup steps
```

**Live portal:** <https://icoachlaunch.github.io/coach-launch-system/dashboard.html>

## The one rule

Never restyle a guide by hand. The look lives in **one** stylesheet (`assets/coach-launch-guide.css`). To build a new guide, copy an existing module guide, keep the CSS link exactly (`../../../assets/coach-launch-guide.css`), and fill in only the content. It's on-brand the moment it's created.

## Brand quick reference

| | |
|---|---|
| Primary color | Crimson Pink `#db0063` (the only accent) |
| Background | White `#ffffff` — light theme |
| Text | Charcoal `#26272b` / near-black `#111111` for headings |
| Display font | Montserrat (700 / 800) |
| Body font | Lato |
| Feel | Clean, bold, premium, high-contrast, zero clutter |

## Naming + layout

Each module is its own folder under its pillar:
`modules/<pillar>/<module>/<module>-guide.html` + `<module>-prompt.md` (plus any related files). The only grouping level is the pillar. Formula-step guides carry the shared CSS + the 3-pillar/9-step map (stamped by `scripts/apply_formula_map.py`).

## How to view

Open `dashboard.html` in a browser (works offline — prompts are embedded), or visit the live portal above.
