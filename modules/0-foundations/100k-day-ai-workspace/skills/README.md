# skills/ — the delivered tools Claude runs from here

A **skill** is a folder with a `SKILL.md` — the instructions Claude follows to build something FROM
your assets, plus the support files it needs. You don't paste a skill into a chat the way you do a
builder prompt; you tell Claude what you want, and `CLAUDE.md` sends it to the right skill.

## What's here

| Skill | What it builds | It reads |
|---|---|---|
| `sniper-presentation-slides/` | Your slide deck, from your approved Sniper Presentation™ Script — one offline file you present from your laptop | the Script + your BRAND KIT block |
| `cash-flow-funnel-builder/` | Your event funnel pages, as one GHL AI Studio build prompt per page, in funnel order | Event Magnet™ · Money Model · Brand Profile · BRAND KIT block |
| `magic-formula-visual/` | The animated graphic of your Magic Formula™ — screenshot it for an ad, embed it on a page, drop it in a deck | Magic Formula™ · $Million Promise™ · BRAND KIT block |

Each folder carries what its skill needs to run — the slide mold library and viewer, the funnel phase
guides, the three graphic templates. Bigger reference material (the 28 funnel page templates, the
Brand Kit gallery) is linked from inside each skill by its live URL, so this folder stays light.

## How to use one

Say what you want — *"build my slides from my Sniper Presentation™ Script"*, *"build my Phase 2
funnel pages"*, *"make my Magic Formula™ graphic"*. Claude opens the matching `SKILL.md`, checks the
assets it needs are in `Reference/` and `Client Engine/`, and runs it. The output is saved in the
asset folder the skill names.

## Where the outputs go

- Slides → `Client Engine/4-sniper-close/sniper-presentation-slides/`
- Funnel build prompts → `Client Engine/5-cash-flow-engine/` (a folder per phase)
- Magic Formula™ graphic → `Client Engine/2-magic-formula/magic-formula-visual/`

## Updates

Skills improve over time. When a new version ships in Coach Launch Academy™, replace the whole
skill folder here with the new one — don't edit a `SKILL.md` by hand.
