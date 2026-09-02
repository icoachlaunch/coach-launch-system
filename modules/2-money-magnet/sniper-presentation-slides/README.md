# Sniper Presentation™ Slides — Step 4 · Part 3 (The Sniper Close™)

Turn your **Sniper Presentation™ Script** (built in Part 2, The Sniper Close™) into an
on-brand HTML slide deck you present from your own laptop. No PowerPoint, no designer.

## What's in this kit
1. **guide.html** — the companion guide (what it is, the kit, the copy rule, the full plan table, presenter view, setup, images, tips).
2. **SKILL.md** — the builder skill (the "brain"). Install at `.claude/skills/sniper-presentation-slides/SKILL.md`, or paste into any chat.
3. **coach-launch-molds.html** — the **mold library** (structure): twenty designed slide molds, each a complete standalone 16:9 document stamped with a `data-type` and `data-slot` markers. Open it in a browser to see every mold in light, dark, and accent. The builder clones from here and never writes markup of its own.
4. **coach-launch-themes.html** — the **theme library** (skin): six themes — Crimson, Ink, Ember, Sovereign, Voltage, Meadow — each rendered on three real slides so the client picks by eye.
5. **slide-viewer.html** — the Slide Viewer: a single-file, offline deck player (← → move · F fullscreen · S speaker notes · P pop-out Presenter View · T timer). Ships with a **full 35-slide sample deck** built from the molds: placeholder copy only, and every slide's presenter notes explain the beat it sits on, so the sample doubles as a walkthrough of the plan table. Press **P** to read them.
6. **image-prompts.md** — the **prompt framework**: six copy-paste templates organised by what the image *does* — background, hero, make-a-point, object, texture, people — each with bracketed inputs you fill in yourself. Plus the four-part formula, the style suffix that makes a set look like one deck, ratios, and the base64-vs-URL rule. Tool-agnostic. Images are always optional, and **every mold can take a background**, so you're not limited to a few "image slides."
7. **images/** — **fourteen ready-to-use placeholders**, deliberately desaturated so they sit under any of the six themes. No faces, no text, no logos:
   - **Backgrounds (atmosphere)** — `mood-auditorium` · `mood-nightdesk` · `mood-firstlight` (16:9)
   - **Heroes (full-bleed)** — `hero-stage` · `hero-room`, left third dark for the headline box (16:9)
   - **Point-makers** — images that carry an idea rather than set a mood: `point-cables` (overwhelm) · `point-empty-chairs` (the event that didn't fill) · `point-two-paths` (the fork) · `point-worn-steps` (effort over time) · `point-ledger` (the numbers) · `point-locked-gate` (the barrier, and what's past it)
   - **Slide 1** — `founder-placeholder` (deliberately anonymous: from behind, in silhouette — replace it with a real photograph of yourself) and `system-placeholder` (a neutral 3×3 stand-in for your Magic Formula™ visual)
   - **JPEG, not PNG.** These are photographs; JPEG at quality 82 took the set from ~9 MB to a few hundred KB with no visible loss. Do the same with anything you generate — a deck that inlines PNGs gets very large very fast.
   - **Eleven of them are already used in the sample deck**, so you can see every kind working before you make your own. That is more than a real deck should carry — three or four is plenty.
   - `placeholder-spec.json` — the spec that produced the first six; edit and re-run to regenerate or add more.

   `hero.png`, `system.png` and `system9.svg` are leftovers from the V1 sample. They're generic (no personal content) but have Coach Launch crimson baked in, so they only sit well under the `crimson` theme — prefer the six placeholders above, which are desaturated to work under all six.

## The two layers
A **mold** is structure: which boxes are on the slide, and which `data-slot` each fills.
A **theme** is skin: colour, type, corner treatment — a set of CSS custom properties.
They meet at the `CL-THEME-TOKENS` block, the only thing a theme swap rewrites. So twenty molds ×
six themes is not 120 files — it's 20 molds and 6 token sets, and "rebuild it in Sovereign" is a
couple of minutes with no word re-approved.

## How to use
1. Finish and **approve** your Sniper Presentation™ Script in Step 4 · Part 2. The builder reads its stamp (`status: approved`, format, close, VIP hour) and refuses to build from an unapproved Script or one still carrying `[VERIFY BEFORE DELIVERING]` markers.
2. Open a chat with the SKILL installed (or pasted) and say: **"Build my slides from my Sniper Presentation™ Script."**
3. It gates the Script, confirms your brand, shows you the full build plan, then builds one phase per turn into `slide-viewer.html`.
4. Double-click `slide-viewer.html` to present.

## The one rule
**This tool never writes or changes copy.** Every word on every slide comes from the approved Script.
Its only formatting freedom is where a line breaks. When copy overruns a mold's capacity it stops,
shows the overflow, and the user fixes it *in the Script*.

## Maintaining the libraries
`coach-launch-molds.html` and `coach-launch-themes.html` are **built files — do not edit them
directly.** Every mold must be a complete standalone document (the Viewer renders each in its own
sandboxed iframe), so the token block and fonts link repeat in all twenty. Edit the `.src.html`
files instead — the molds source carries one copy behind `/*CLBASE*/` and `<!--CLFONTS-->`, and the
themes source is where **every theme, including the default, is defined once** — then regenerate:

```
powershell -File scripts/build_slide_kit.ps1
```

The script stamps the default theme into every mold, builds the theme gallery's live previews, checks
every theme declares the full token contract, and verifies the result (20 molds, 0 markers left, 0 NUL
bytes). **Adding a theme** = one more `<script type="text/plain" data-theme="…" data-fonts="…">` block
in the themes source, then re-run — nothing else changes.
