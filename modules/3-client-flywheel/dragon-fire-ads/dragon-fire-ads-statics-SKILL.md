---
name: cl-dragon-fire-ads-statics
description: "Dragon Fire Ads™ Statics — builds the static image ads for a business's ad pack: reads the slots from the Ad System Map and the copy from the ad pack, builds each image on the business's own Dragon Fire Ads™ Design canvas (its own canvas, never the Event Magnet™ one) around their Event Magnet™ tool in their Brand Kit (4:5, 9:16, 1:1; Motivate reminders, Attract carousels, Engage cards), generates supporting AI images (Nano Banana), builds a first set of 21 statics (7 concepts × dark, white and photo looks, every one carrying the $Million Promise™ and readable on a phone), renders PNGs for Ads Manager, and publishes the Ad Preview page — every ad in run order as it shows in the feed, with the promise-test switch. For Coach Launch or a client. Always asks Guided or Fast. Use whenever someone wants ad images, ad creatives, static ads, ad graphics, a carousel, reminder ad images, an ad preview or 'show me the ads' for a Dragon Fire Ads™ pack — even if they just say \"make the ad images\"."
---

# Dragon Fire Ads™ Statics

Coach Launch · The $100K Day Engine™ · Client Flywheel™ · Step 9 · Dragon Fire Ads™

The third skill of the ad system: **plan** (`cl-dragon-fire-ads-plan`) decides the slots, **copy**
(`cl-dragon-fire-ads`) writes each ad, **statics** (this skill) builds the images and shows the whole pack laid
out in sequence. Video scripts and the Descript edit follow.

## How this file is laid out

- `references/concepts.md` — the concepts (pain call-out · tool hero · proof · two roads · host · reminder ·
  carousel · quote/proof cards), sizes and safe zones, how boards are built on the canvas, the creative rules.
  Read it before building any board.
- `scripts/render_ads.py` — renders boards to PNG (swaps the live tool import for the exported tool PNG).
- `scripts/build_preview.py` — builds the Ad Preview page from the ad pack and the PNGs.

## 0 · First questions — one message

1. **Guided or Fast?** Always ask. Guided: one image at a time, shown and approved before the next (the
   operator's standing preference for visuals). Fast: build the pack's images, then show the preview page.
2. **Who and which pack?** The business, and the stage (Convert · Motivate · Attract · Engage).

## 1 · The rules

- **The ads have their own canvas.** Every business gets one Design canvas, "<Business> — Dragon Fire Ads",
  where all its ad packs are built and managed, one row per pack. Never put an ad board on the Event Magnet™
  canvas (that canvas keeps the tool pages and its own opt-in ad); if ads are found there from an older run,
  move them to the Dragon Fire Ads canvas and remove them from the Event Magnet™ one.
- **One business per canvas and page.** Their Brand Kit (the BRAND KIT block), their tool, their photos. Never
  Coach Launch branding, fonts or hand-drawn icons on a client's ads; never another client's anything. Coach
  Launch's own ads use its Kit and canvas.
- **Readable on a phone.** No text under 18 px on any image; headline 56 px or more; the button full width
  and 104 px tall. No small print at all — no lockup or names in the corner, no eyebrow labels, no sub-lines.
  If a line can't be 18 px, it goes in the primary text instead. `render_ads.py` reports anything under.
- **The $Million Promise™ is on every image**, in its own band (30 px) or as the headline. It's the default
  even while a page-headline test runs — the test lives in the copy and the page.
- **21 to choose from.** A pack's first build is 7 concepts × 3 looks (dark · white · photo), so there's
  real variety; later cycles build on the winners. Red = the old way, green = the new.
- **Faces stay clear.** No text, band, button or tool card ever sits on a face, and no frame crops a head.
  Every photo gets keep-clear boxes (its faces and subject) when it's made; `render_ads.py --keep-clear` lists
  any board that breaks it.
- **The system is on every ad.** The tool drives the curiosity, so it appears on all 21 — filling the visual,
  zoomed in, or as a card that **breaks the frame** (overhanging the photo's top or bottom corner, away from
  faces). It never covers words.
- **The result drives it; the system stays unnamed.** The core result of the $Million Promise™ leads at least the
  result-led and stats concepts. The signature system's name never appears on an image — the tool and the result
  do the hooking; the system is introduced inside the virtual event.
- **The images say what the ad says.** Each board's headline and sub come from its ad in the pack (the angle's
  lead hook cut to ≤ 12 words, the sub ≤ 20). Same promise as the copy and the page — the images never introduce
  a claim the pack doesn't make. Both ad sets of a promise test share the image (with the
  $Million Promise™ on it).
- **The tool is the scroll-stopper; the outcome is the message.** Sell the dream outcome, never the tool's mechanics.
- **Only Motivate images carry a date** — the virtual event's, in the audience's own dates where time zones split
  it. No price on the tool; "$27" or "Free" is fine on the button or pill.
- **Results are reported, never promised** — any figure on an image belongs to I / we / a named client, with
  "Results not typical. Individual results vary." on the image.
- **Copy rules:** never a bare "event" or "room"; no "the" before a tool or system name; Brand Voice; Australian
  spelling unless the business writes otherwise. No paper sizes on anything a client sees.
- **No fake UI, no before/after bodies, text light** (Meta policy, `cl-dragon-fire-ads` compliance check).
- **The client's documents are verified;** the only flag is `[MISSING CONTENT — …]` (a headshot, the tool export).
- **Read the canvas back before every publish.** The operator's hand edits win and become rules for the next boards.

## 2 · Inputs

| Input | Status | Gives |
|---|---|---|
| Ad System Map (`ad-system-map.md`) | Required | The slots, formats and the order they run |
| Ad pack (`ad-pack-<slug>.md`) | Required | Each ad's hook, headline, sub, creative concept, callouts, promise test |
| Dragon Fire Ads™ canvas link | After the first run | The business's ad canvas (in `CONTEXT.md`); none yet → this skill creates it |
| Event Magnet™ canvas link | Optional | Where to re-export the tool from; never built on |
| Exported tool PNG (`<tool>.png`, from `cl-event-magnet-visual`) | Required | Uploaded to the ad canvas as an asset; the hero of every board |
| BRAND KIT block | Required | Kit + overrides (set exactly as `cl-event-magnet-visual` Step 3 does) |
| Headshot / host photos | For host, quote and video poster | Real photos only; `cl-image-gen` (Nano Banana) for a generated host shot only with the operator's approval |
| Logo | Optional | The preview page's ad avatar |
| Kie.ai key (`Reference/api-keys/kie.env.claude`) | For the AI images | Read on the operator's computer, passed only as an environment variable (see `cl-image-gen`) |

Usual places: `Client Engine/Client Flywheel/dragon-fire-ads/` (map, pack), `Client Engine/Offer Matrix/event-magnet-visuals/`
(tool exports and canvas link), `Reference/` (Visual Style Guide, logo, photos).

## 3 · The workflow

**Stage 1 · Read and list (checkpoint).** Read the map and the pack. List the images this pack needs — one row per
slot: slot, concept, size(s), headline on the image. Read `references/concepts.md` §1, then the
business's Dragon Fire Ads canvas (`project/canvas.json`) — or, on a first run, create it: Design type, title
"<Business> — Dragon Fire Ads", the business's design system installed, the tool PNG and photos uploaded as
assets (`asset: true`), the canvas link and asset ids written to `CONTEXT.md`.

**Stage 1b · The AI images.** Read `references/concepts.md` §2b. List the scenes the seven concepts need
(frustration and joy pairs, the empty and the full virtual room, the host live and celebrating), generate them
with `scripts/gen_images.py`, download them on the operator's computer, stage, resize and upload them to the
ad canvas as assets. The host is generated only from their real photo and with the operator's OK. Guided: show
the images and wait for a yes. Then look at each image on a gridded contact sheet and write
`keep-clear.json` beside them: `{asset id: [[x, y, w, h, "label"], …]}` as fractions of the image — each face
(forehead to chin, the top of the head when it may be cropped) and the subject that carries the meaning (the
full or empty virtual room). `assets/example-keep-clear.json` shows the shape.

**Stage 2 · Build the boards.** For each image, start from an existing board on the ad canvas (or the Event
Magnet Panels `ad-4x5.dc.html` template): copy its `<head>`, `<helmet>` and logic `<script>` verbatim, write the
new body. The tool and photos are `<img src="/_blob/<id>">` assets. Build the 21 (concepts.md §2–§4;
`assets/example-build-21.py` is a worked generator). Name boards `Ad-<SLOT>-<concept>-<look>.dc.html`
(`Ad-CVx-…` for the two concepts that fit any slot), one row per concept and one column per look under a
`<Stage> pack · <Campaign>` title note, read the canvas back, publish. Guided: one concept (its three looks),
show it, wait; Fast: all 21.

**Stage 3 · Render the PNGs.** Fonts first (Google Fonts may be blocked in the sandbox):
`npm i @fontsource/<family>` for each Kit face, then copy `files/<family>-latin-<weight>-normal.woff2` to a folder
as `<Family Name>-<weight>.woff2`. Then:

```
python3 scripts/render_ads.py project/Ad-*.dc.html --out pngs/ --fonts fonts/ \
    --blob <tool asset id>=<tool>.png --blob <photo asset id>=<photo>.jpg --keep-clear keep-clear.json
```

Every board is checked (listed under its line): text under 18 px or off the board, the tool on words, and —
with `--keep-clear <images>.json` — any face covered or cropped. Then look at the PNGs
on a contact sheet and fix anything clipped, overlapping, white-spaced or off-brand before going on.

**Stage 4 · The Ad Preview page.**

```
python3 scripts/build_preview.py ad-pack-<slug>.md --out <slug>-ad-preview.html \
    --img A1=pngs/Ad-CV1-pain-dark.png,pngs/Ad-CV1-pain-white.png,pngs/Ad-CV1-pain-photo.png … \
    --extra "Promise-led=<its 3 PNGs>" --extra "Stats=<its 3 PNGs>" --brand "<Business>" --logo <logo.png> \
    --title "<Name> Ad Preview" --stage <Stage>
```

Publish it with the Artifact tool (one self-contained page; images are embedded). It shows every ad in run order as
a feed card with a Dark · White · Photo switch for its looks, the 👉 link lines in the text shown as tappable
links (a missing URL shows in red), the extra concepts as a gallery after the ads, — primary text with "See more", the image (or a video poster with a play mark), the headline bar and
button — with notes beside each (hooks with map rows, concept, score, the video script) and the promise switch
for a test. Republish the same file path after changes so the link stays the same.

### Deliver

1. Save the PNGs to `Client Engine/Client Flywheel/dragon-fire-ads/creatives/<stage>/` (file names = board names) and
   the preview HTML beside the pack.
2. Update the Ad System Map's status column for the slots built (`creative`) and the business's `CONTEXT.md`.
3. In the chat: the Dragon Fire Ads canvas and the preview page cards, one line on what was built, and the missing content (photos, the tool
   export, page links). Export routes: PNGs are ready for Ads Manager; the ad canvas exports any board again.

## 4 · Boundaries

- Builds images and the preview. Copy changes go back to `cl-dragon-fire-ads`; slots to `cl-dragon-fire-ads-plan`;
  the tool itself to `cl-event-magnet-visual`; video to the video skills.
- Never generates a likeness of a real person without the operator's approval, and never invents results, prices
  or dates for an image.
