# Slide Images — the prompt pack

**You need zero artwork to build your deck.** Every one of the twenty molds works from words
alone, and the builder will never ask you for a photo. This file is for when you *want* images.

Four molds take one. Everything else — frameworks, comparisons, the value stack, proof, the
close — stays as text, because an image behind a table makes the table harder to read.

---

## The rule that matters most

**Text stays in HTML. The generator only ever makes the picture.**

Never ask an AI to put words inside an image. It misspells them, it invents its own typography,
and it goes off-brand — and once the words are baked into a JPEG you can't fix a typo without
regenerating. Your headline is live text sitting *on top of* the picture, in your theme's fonts.

Everything below follows from that: you are prompting for **backgrounds and atmosphere**, never
for a finished slide.

---

## Where images go

| Mold | Slot | Ratio | What it wants |
|---|---|---|---|
| `02-intro-split` | `photo` | **4:5** | Your founder portrait — a real photo of you, not generated |
| `02-intro-split` | `magnet` | **16:10** | Your Event Magnet™ visual — the real asset, not generated |
| `07-story-bit` | `bg` | **16:9** | Mood. Heavily darkened. One line of text sits over it |
| `08-image-hero` | `bg` | **16:9** | Mood, with a dark gradient down the left for the headline box |
| `09-image-points` | `image` | **3:4** | A side image beside three numbered points |

⚠️ **Two of these should never be generated.** Your founder photo should be *you* — a generated
face on your own intro slide is the fastest way to lose a room that later meets you. And your
Event Magnet™ is a real asset built in Step 3; put the real thing on the slide.

That leaves the three atmospheric slots. Those are what this pack is for.

---

## The formula

Every prompt has four parts. Miss one and you get stock-photo mush.

1. **Subject** — what is physically in frame
2. **Treatment** — the light, the mood, the depth of field
3. **Palette** — name your theme's actual colours
4. **Avoid** — say what you don't want, explicitly

Then append the **same style suffix to every prompt in the deck**. That one habit is the
difference between a deck that looks designed and a deck that looks like a scrapbook.

```
STYLE SUFFIX (write once, paste on every prompt):
photographic, shallow depth of field, soft directional light, muted [YOUR PALETTE],
generous negative space in the [left/centre], cinematic colour grade.
Avoid: any text, letters, numbers, logos, watermarks, faces looking at camera,
cheesy stock-photo posing, clip art, busy backgrounds, collage, borders.
```

---

## Recipes

### `07-story-bit` — the change of pace

One line of text over a dark image. The picture carries the feeling; the line carries the point.

```
A quiet [SCENE THAT MATCHES YOUR STORY — e.g. an empty auditorium before doors open /
a single desk lamp at night / a coastal road at first light], viewed wide,
nobody facing camera. Low key, deep shadows, one soft light source.
Muted [YOUR PALETTE]. Lots of empty space in the middle third for text.
+ STYLE SUFFIX
```

**Why "nobody facing camera":** a face in frame competes with you. During a story, the room
should be looking at you, not at a stranger.

### `08-image-hero` — the full-bleed moment

Your $Million Moment™ and your send-off. A headline box sits on the **left**, so the image
needs room there.

```
[SCENE FROM YOUR ACTUAL STORY — the room, the place, the object that was there].
Wide shot, atmospheric, shot from a distance. The left third of the frame is
darker and uncluttered. Muted [YOUR PALETTE], one warm highlight.
+ STYLE SUFFIX
```

**Match the story.** If your $Million Moment™ happened in a hotel function room, prompt a hotel
function room. A generic "success" image tells the room you're being vague.

### `09-image-points` — the side image

Portrait orientation, sits beside three numbered points.

```
[OBJECT OR SCENE RELATED TO THE THREE POINTS], vertical composition,
centred subject with clean space above and below. Soft even light.
Muted [YOUR PALETTE], plain uncluttered background.
+ STYLE SUFFIX
```

---

## Making them look like one deck

1. **Generate your hero image first.** The `08-image-hero` background is the one people look at
   longest. Get it right before anything else.
2. **Then match everything to it.** Reuse its exact style suffix. If the hero came out cooler or
   warmer than you expected, update the suffix to match *what you got*, not what you asked for.
3. **Two or three images is plenty.** Story-bit backgrounds can repeat across the deck — the room
   won't notice, and a consistent look beats a varied one.
4. **Dark molds need dark images.** `07-story-bit` and `08-image-hero` both lay a dark gradient
   over the picture. A bright image fights it and the text stops being readable.

---

## Getting them into the deck

Ask the builder to place them, and tell it which slot each file belongs to:

> "Use `hero-stage.jpg` as the background on slide 8, and `mood-dark.jpg` on the story bits."

Two ways it can wire them in:

- **Inlined as base64** — the deck stays one self-contained file that works offline. Best for a
  deck you present from a laptop or hand to someone. Costs file size.
- **An absolute `https://` URL** — keeps the file small, but the deck needs internet on the day.

**Default to base64.** Venue wifi is the single most common thing that goes wrong on event day,
and a missing background on your $Million Moment™ slide is not the moment to discover it.

---

## Tools

Any image generator works — this is a prompt pack, not a product recommendation. The prompts
above are written to be tool-agnostic.

If you're running the builder inside Claude Code or Cowork, the **`kie-image-gen` skill** handles
Kie.ai generation, preview-and-approve, and downloading into your folder in one flow. Ask for it
by name.

Whatever you use: **generate, look at them full-size, and only then put them in the deck.** An
image that looks fine as a thumbnail can be a mess at 1600×900 on a projector.

---

## A last check before you use one

- [ ] No text, letters or numbers baked into the image
- [ ] Nothing in it implies a claim you can't back up
- [ ] It's not a photo of a real person who hasn't agreed to be on your slide
- [ ] It still reads with the dark overlay on top
- [ ] It's yours to use — generated, licensed, or your own camera

If an image is doing nothing except filling space, **cut it.** A clean text slide in your brand
beats a decorative photo every time. That's why the whole kit is built to need none.
