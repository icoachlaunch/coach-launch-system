# Your Brand Kit — one look, installed once

This folder is the **one global place your design lives.** Every slide, funnel page, ad and post you
build reads its colours, fonts, corners and buttons from here — so you pick a look once and never
pick a colour again.

## What's in it

```
brand-kit/
├── tokens/        ← YOUR Kit goes here. Exactly ONE file. (empty until you choose)
├── blocks.css     the building blocks — buttons, cards, lists, quotes, prices. No colour in here.
└── surfaces/      page.css · slide.css · social.css — layout for each medium. No colour in here.
```

Only the file in `tokens/` knows what colour your brand is. The other two layers read from it.

## Installing your Kit (once, from your Visual Style Guide)

1. Run **the Visual Style Guide Builder** (Coach Launch Academy™). Its Step 2 walks you through the
   six Kits — Crimson · Ink · Ember · Sovereign · Voltage · Meadow — and you pick ONE for your business.
   See them on real work first:
   https://icoachlaunch.github.io/coach-launch-system/modules/0-foundations/visual-style/brand-kit/brand-kit.html
2. Save that Kit's token file into `tokens/`, keeping its filename (for example `tokens/sovereign.css`):
   https://icoachlaunch.github.io/coach-launch-system/modules/0-foundations/visual-style/brand-kit/tokens/<your-kit>.css
3. Your finished `Reference/visual-style-guide.md` ends with the **BRAND KIT block** — three lines
   naming your Kit, its file, and any overrides (your own hero colour or fonts, if you kept them).
   That block is what every builder asks for. Paste it when they do.

## The rules

- **One Kit installed at a time.** `tokens/` holds one file. Never two.
- **Never type a colour code anywhere except your Kit.** The moment one page gets a hand-picked
  colour, it starts drifting from the rest.
- **Changing your Kit later?** Re-run the Visual Style Guide Builder's Kit step, delete the old file
  from `tokens/`, save the new one, and replace the BRAND KIT block in your guide. Then rebuild
  anything you made on the old Kit. Replace — never add.
