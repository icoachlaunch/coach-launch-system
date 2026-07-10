# Coach Launch — System Library

The single source of truth for Coach Launch builder prompts, companion guides, and the brand style system. Everything here is on-brand by default and ready to reference from other platforms.

Brand: **Coach Launch** · System: **The $100K Day Formula™** + **The $100K Day Accelerator™**

---

## What's in here

```
coach-launch-system/
├── style-guide/                  ★ CORE — the locked brand standard
│   ├── visual-style-guide.html   How every doc LOOKS (colors, type, logo, components)
│   ├── voice-guide.html          Brand Voice — how you SOUND when selling & connecting
│   ├── teaching-voice-guide.html Teaching Voice — how you SOUND in guides & prompts
│   └── README.md
├── assets/                       Shared design system — do not fork per guide
│   ├── coach-launch-guide.css    The locked stylesheet every guide links to
│   ├── logo-icon.svg             Icon mark (white on crimson) — dark contexts
│   └── logo-icon-light.svg       Icon mark (crimson on light) — light contexts
├── templates/
│   └── guide-template.html       Copy this to start any new companion guide
├── guides/
│   └── million-story-guide.html   Worked example (Step 1)
├── prompts/
│   └── million-promise-prompt.md   Builder prompt · Part 1 of 3 (the $Million Promise)
├── index.html                    Library home page — links to everything
└── SETUP-GITHUB.md               One-time GitHub setup steps
```

## The one rule

Never restyle a guide by hand. The look lives in **one** stylesheet (`assets/coach-launch-guide.css`). To build a new guide, copy `templates/guide-template.html`, keep the CSS link exactly, and fill in only the content. It's on-brand the moment it's created.

## Brand quick reference

| | |
|---|---|
| Primary color | Crimson Pink `#db0063` (the only accent) |
| Background | White `#ffffff` — light theme (approved override of the Style Guide's dark default) |
| Text | Charcoal `#26272b` / near-black `#111111` for headings |
| Display font | Montserrat (700 / 800) |
| Body font | Lato |
| Feel | Clean, bold, premium, high-contrast, zero clutter |

Full spec: open `style-guide/visual-style-guide.html` in a browser.

## Naming convention

Guides: `step-0N-[short-name]-guide.html` · Prompts: `step-0N-[short-name]-prompt.md`

## How to view

Open any `.html` file in a browser, or serve the folder locally:

```bash
cd coach-launch-system
python3 -m http.server 8000    # then visit http://localhost:8000
```
