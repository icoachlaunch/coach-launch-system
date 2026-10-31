# Client Engine™ — every asset you build, in its place

This is where your business system lives once it's built. Three folders — one per pillar of
The $100K Day Engine™ — and inside each, one folder per asset. Open any folder's `README.md` to see
exactly what goes in it, which builder makes it, what it needs first, what it feeds, and where its
memory lives.

## The map

```
Client Engine/
├── Offer Matrix/        Pillar 1 · Steps 1–3 · everything offer-related
│   ├── million-promise/               Step 1 · your one-line marketing promise
│   ├── golden-avatar/                 Step 1 · your deep buyer profile(s)
│   ├── million-moment/                Step 1 · your system-discovery story
│   ├── magic-formula/                 Step 2 · your 3-phase, 9-step system
│   ├── magic-formula-visual/          Step 2 · the animated graphic of it (a skill)
│   ├── score-card/                    Step 2 · the SCORE™ Card — your master content source
│   ├── money-model/                   Step 3 · offer economics, your phase, your close
│   ├── enrollment-doc/                Step 3 · the long-form offer / sales letter
│   ├── event-magnet/                  Step 3 · the free lead magnet on your hot step
│   └── cash-flow-max/                 Step 3 · the VIP upsell + order bumps
├── Money Magnet/        Pillar 2 · Steps 4–6 · making the money
│   ├── pass-instrument/               Step 4 · the PASS™ Instrument (The Strategy Close) + sessions/
│   ├── sniper-presentation/           Step 4 · the Sniper Presentation™ Script
│   ├── sniper-presentation-slides/    Step 4 · the deck built from it (a skill)
│   ├── cash-flow-engine/              Step 5 · the funnel, built in GHL AI Studio (a skill) — a folder per phase
│   ├── authority-detonator/           Step 5 · the show-up video scripts (you record them)
│   └── genie-x-converter/             Step 6 · back-end follow-up (in development)
└── Client Flywheel/     Pillar 3 · Steps 7–9 · traffic and marketing
    ├── goliath-content/               Step 7 · the Goliath Content™ Map — your 210-title content plan
    ├── program-modules/               Step 7 · the nine Program Modules — one per Magic Formula™ step
    ├── pixie-dust-social/             Step 8 · organic social system (in development)
    └── dragon-fire-ads/               Step 9 · paid traffic system (in development)
```

Inside every asset folder, three files do three jobs: **`README.md`** says what goes here (it ships
with the kit and never changes), **`<asset>.md`** is the asset itself, and **`NOTES.md`** is its
memory — Claude makes that one the first time it saves here.

The folders are named after the asset and nothing else — no numbers, no step codes — so the workspace
can grow without anything being renamed. **The build order lives in each pillar's README**, and Claude
follows it. You never have to sort folders.

## How it works

1. **Build in order.** Each asset feeds the next — the folder README says what it needs first. If
   something's missing, Claude says so and why, offers to do it first, and lets you push ahead if you
   want to — unless the builder itself has a gate, which it honours.
2. **The builder is in Coach Launch Academy™**, not here. Download it from your Training Portal,
   paste it into a fresh chat, answer one question at a time.
3. **Save the finished asset in its folder** under the filename the README names. One canonical
   file per asset. Update it over time — bump the version, add a revision-history row. Never a
   `-v2` or `-FINAL`.
4. **Claude writes the memory** — the folder's `NOTES.md`, then the status line in `CONTEXT.md` — after
   every save, so the next session starts already knowing what's built and why it is the way it is.

## Bringing in work you already have

Many coaches already have some of this — a promise in a Google Doc, an avatar in a PDF, a pricing page.

1. Upload whatever you have (any format) and tell Claude what it is.
2. Claude reads it, identifies which asset it is (and confirms if unsure), and turns it into the
   canonical `.md` with the standard frontmatter and Revision History — version 1, status `draft`.
3. It's saved in the right folder under the canonical filename, and the folder's `NOTES.md` records
   where it came from.
4. **The `.md` is the source of truth from then on** — not the uploaded original.

## Memory — the `NOTES.md` beside every asset

`CONTEXT.md` holds one line per asset: its status. Everything else worth remembering about an asset
lives next to it, in its own folder, in `NOTES.md` — so the memory grows as you build without any one
file getting heavy, and Claude only reads it when it's working on that asset. Claude reads the notes
before touching the asset and adds to them after every save. It never goes in the asset file itself
(that file is what the builders downstream read) and never in `CONTEXT.md` (that file stays short).

```
# Notes — [Asset Name]

> Working memory for this asset. Read before touching it; add to after every save. Not loaded otherwise.

## Decisions (and why)
- [date] — [what was decided] — because [why]

## Rejected (so we don't go round again)
- [date] — [what was tried or offered] — [why it was passed on]

## Open
- [what's still unresolved, who decides, by when]

## Log
- [date] — [what happened this session, in a line]
```

Four headings, one line per entry, newest at the bottom. A decision goes in **Decisions**; an option
you turned down goes in **Rejected**; a question nobody has answered yet goes in **Open**; and every
session that touches the asset gets a line in the **Log**, even when the file didn't change. When an
Open item gets settled, move it up to Decisions. Working in Claude Projects (no file writing)? Claude
outputs the updated `NOTES.md` with the asset, and you save both.

## Adding your own

This is a working system. It grows as your business does, and not everything you build will have a
Coach Launch builder behind it. When you add something of your own:

- **An asset** — a book, a podcast, a case-study library, a workshop outline — gets **its own folder
  in the pillar it serves**: `Offer Matrix/` if it shapes your offer or message, `Money Magnet/` if
  it sells or converts, `Client Flywheel/` if it brings traffic or builds an audience. Name the
  folder after the asset, lowercase with hyphens (`podcast/`, `case-studies/`). Claude writes its
  README in the same shape as the others (what goes here · how it gets built · needs first · feeds ·
  memory · file shape), saves the asset in it as one canonical file, starts its `NOTES.md`, and adds a
  row to `CONTEXT.md`. Never inside another asset's folder, never loose in the pillar folder.
- **Business information** — certifications, team bios, policies, a guarantee — is not an asset.
  It goes in `Reference/` as a new document beside the five (the README there says how). Reference
  is the truth about your business; Client Engine™ is what's built from it.
- **A new Coach Launch builder** ships with its own folder in the next kit update. Drop it into its
  pillar. Nothing else moves — and nothing of yours is ever overwritten, because the kit never ships
  a `NOTES.md`.
- **Not sure which pillar?** Ask what the thing is for — shaping the offer, making the sale, or
  finding people — and place it once. Three pillars hold everything; there is never a fourth.

## Every asset file starts like this

```
---
asset: [Asset Name]
version: 1
last_updated: [date]
status: draft | complete
phase: [n/a | Launch | Execute | Growth | Mastery]
---

## Revision History
| Version | Date | Changes |
|---------|------|---------|
| 1 | [date] | Initial build |
```

Revise = same file, bump the version, add a row. The Revision History says *what* changed; the
folder's `NOTES.md` says *why*.

**The Money Model (Step 3) sets the path.** It decides which $100K Day Accelerator™ phase you're in —
Launch, Execute, Growth or Mastery (the Accelerator runs all four over 112 days) — and your close
(**the Three Closes**: The Strategy Close · The Membership Close · The Deposit Close). That path shapes
your event format, your pricing and which downstream assets matter most. Once the Money Model is
complete, Claude records the phase and close in `CONTEXT.md` and in each new asset's `phase:` field.
Until then it's `n/a`.
