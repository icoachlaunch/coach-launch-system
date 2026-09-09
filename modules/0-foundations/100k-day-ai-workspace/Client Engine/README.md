# Client Engine™ — every asset you build, in its place

This is where your business system lives once it's built. Three folders — one per pillar of
The $100K Day Engine™ — and inside each, one folder per asset. Open any folder's `README.md` to see
exactly what goes in it, which builder makes it, what it needs first, and what it feeds.

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
│   └── genie-x-converter/             Step 6 · back-end follow-up (in development)
└── Client Flywheel/     Pillar 3 · Steps 7–9 · traffic and marketing
    ├── goliath-content/               Step 7 · authority content engine (in development)
    ├── pixie-dust-social/             Step 8 · organic social system (in development)
    └── dragon-fire-ads/               Step 9 · paid traffic system (in development)
```

The folders are named after the asset and nothing else — no numbers, no step codes — so the
workspace can grow without anything being renamed. **The build order lives in each pillar's README
and in `CLAUDE.md`'s roadmap**, and Claude follows it. You never have to sort folders.

## How it works

1. **Build in order.** Each asset feeds the next — the folder README says what it needs first.
2. **The builder is in Coach Launch Academy™**, not here. Download it from your Training Portal,
   paste it into a fresh chat, answer one question at a time.
3. **Save the finished asset in its folder** under the filename the README names. One canonical
   file per asset. Update it over time — bump the version, add a revision-history row. Never a
   `-v2` or `-FINAL`.
4. **Claude updates `CONTEXT.md` and `PROGRESS.md`** after every save, so the next session starts
   already knowing what's built.

## Adding your own

This is a working system. It grows as your business does, and not everything you build will have a
Coach Launch builder behind it. When you add something of your own:

- **An asset** — a book, a podcast, a case-study library, a workshop outline — gets **its own folder
  in the pillar it serves**: `Offer Matrix/` if it shapes your offer or message, `Money Magnet/` if
  it sells or converts, `Client Flywheel/` if it brings traffic or builds an audience. Name the
  folder after the asset, lowercase with hyphens (`podcast/`, `case-studies/`). Claude writes its
  README in the same shape as the others and saves the asset in it as one canonical file. Never
  inside another asset's folder, never loose in the pillar folder.
- **Business information** — certifications, team bios, policies, a guarantee — is not an asset.
  It goes in `Reference/` as a new document beside the five (the README there says how). Reference
  is the truth about your business; Client Engine™ is what's built from it.
- **A new Coach Launch builder** ships with its own folder in the next kit update. Drop it into its
  pillar. Nothing else moves.
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

The `phase:` field is set once your Money Model (Step 3) decides which $100K Day Accelerator™ phase
you're in — Launch, Execute, Growth or Mastery. Until then it's `n/a`.
