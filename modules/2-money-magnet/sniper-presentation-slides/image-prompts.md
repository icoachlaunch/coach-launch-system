# Slide Images — the prompt framework

A working guide to putting images on your slides: when to bother, what to ask for, and six
copy-paste prompt templates you fill in with your own words.

**You need zero artwork to build your deck.** Every one of the twenty molds works from words
alone, and the builder will never ask you for a photo. Everything here is optional. Use it when
an image earns its place, ignore it the rest of the time.

---

## 1. The one rule

**Text stays in HTML. The generator only ever makes the picture.**

Never ask an AI to put words inside an image. It misspells them, invents its own typography, and
drifts off-brand — and once the words are baked into a PNG you can't fix a typo without
regenerating the whole thing. Your headline is live text sitting *on top of* the picture, in your
theme's fonts, at your theme's sizes.

Every template below follows from that. You are prompting for **atmosphere, objects and
scenes** — never for a finished slide.

---

## 2. Any slide can take an image

Every mold carries an optional background layer. So a background isn't limited to a few "image
slides" — you can put one behind your value stack, your framework, your price, your close, any of
them. Just ask:

> "Put `mood-nightdesk.png` behind slide 23."

Two things happen automatically:

- **A veil is laid over the image** so your text stays readable. It adapts to the slide's surface —
  a light slide gets a pale wash so dark text still reads; a dark slide gets a dark wash; an accent
  slide tints the image in your brand colour.
- **If you don't supply an image, the layer is deleted.** It never renders as an empty grey box.

That's the flexibility. The templates below are organised by **what the image is doing**, not by
which slide it sits on — so once you know the job, you can put it anywhere.

⚠️ **Restraint is the whole skill here.** An image behind every slide is exhausting to sit through
and makes your deck harder to read, not easier. Three or four across a 35-slide deck is plenty.
If an image is only filling space, cut it.

---

## 3. What makes a prompt work

Four parts. Miss one and you get stock-photo mush.

| Part | What it does | Example |
|---|---|---|
| **Subject** | what is physically in frame | *an empty auditorium before the doors open* |
| **Treatment** | light, mood, depth, camera distance | *low key, deep shadows, one soft light source, wide shot* |
| **Palette** | your actual colours, named | *muted slate and warm amber* |
| **Avoid** | what you don't want, said out loud | *no text, no faces, no stock-photo posing* |

The **Avoid** line is the one people skip and the one that does the most work. Generators default
to bright, busy, smiling stock imagery unless you tell them not to.

### Your style suffix

Write this **once**, then paste it onto the end of every image prompt for the whole deck. It is the
single biggest difference between a deck that looks designed and one that looks like a scrapbook.

```
STYLE SUFFIX — write once, paste on every prompt:

photographic, shallow depth of field, soft directional light, muted [YOUR PALETTE],
cinematic colour grade, generous negative space.
Avoid: any text, letters, numbers, logos, watermarks, faces looking at camera,
cheesy stock-photo posing, clip art, busy backgrounds, collage, borders,
oversaturated colour.
```

Replace `[YOUR PALETTE]` with your real colours — *muted navy and gold*, *desaturated sage and
cream*, *slate with one electric cyan accent*. Keep it consistent and every image will feel like it
belongs to the same deck even when the subjects are completely different.

---

## 4. The templates

Copy the block, replace everything in `[SQUARE BRACKETS]`, paste your style suffix on the end,
and generate.

---

### TEMPLATE 1 — BACKGROUND
*Atmosphere behind text. The picture sets the temperature; the words do the work.*

**Reach for it when:** you want a slide to *feel* different — a story beat, a section change, a
moment you want the room to slow down for.

```
A [SCENE — e.g. an empty auditorium before the doors open / a single desk lamp
late at night / a coastal road at first light], viewed wide, nobody present.
Low key, deep shadows, one soft light source.
Uncluttered space through the [centre / left / lower] of the frame for text.

+ STYLE SUFFIX
```

**Fill it in like this:**
> *A quiet workshop bench at the end of a working day, tools set down, viewed wide, nobody present.
> Low key, deep shadows, one soft light source. Uncluttered space through the centre of the frame
> for text. photographic, shallow depth of field, soft directional light, muted oak and slate,
> cinematic colour grade, generous negative space. Avoid: any text, letters, numbers, logos,
> watermarks, faces looking at camera, cheesy stock-photo posing, clip art, busy backgrounds,
> collage, borders, oversaturated colour.*

**Notes**
- **"Nobody present" matters.** A face in frame competes with you. While you're telling a story the
  room should be looking at you, not at a stranger.
- Say **where** the empty space goes and match it to where your text sits.
- Ratio: **16:9**.

---

### TEMPLATE 2 — HERO
*The image is the slide. Text sits in a box over it.*

**Reach for it when:** the beat deserves the whole screen — your $Million Moment™, your send-off,
the one emotional peak in a section.

```
[SCENE FROM THE ACTUAL STORY — the room, the place, the object that was really there].
Wide shot, atmospheric, shot from a distance, nobody present.
The [left] third of the frame is darker and uncluttered.

+ STYLE SUFFIX
```

**Fill it in like this:**
> *A hotel function room set with rows of empty chairs before an event, warm window light from the
> right. Wide shot, atmospheric, shot from a distance, nobody present. The left third of the frame
> is darker and uncluttered. [+ suffix]*

**Notes**
- **Match the real story.** If it happened in a hotel function room, prompt a hotel function room.
  A generic "success" image tells the room you're being vague — and vagueness is the thing your
  story is supposed to cure.
- Say which third stays dark, and match it to the side your headline sits on.
- Ratio: **16:9**.

---

### TEMPLATE 3 — MAKE A POINT
*The image carries an idea. It argues alongside your words.*

**Reach for it when:** an abstract point lands harder as a picture — a contrast, a consequence, a
process, a before-and-after.

```
[A CONCRETE SCENE THAT SHOWS THE IDEA — not a symbol of it].
[Composition: single subject, centred / two halves, one lit and one dark /
a path leading away].
Plain uncluttered background so the subject reads instantly.

+ STYLE SUFFIX
```

**Fill it in like this** — for *"most coaches are spending before they earn"*:
> *An open wallet lying on a plain surface with a single note left in it, viewed from directly
> above, hard side light. Single subject, centred. Plain uncluttered background so the subject
> reads instantly. [+ suffix]*

**Notes**
- **Show the thing, don't symbolise it.** "A lightbulb for an idea" or "a chess piece for strategy"
  is visual filler your audience has seen a thousand times. A concrete object from *their* world
  lands; a metaphor from stock photography doesn't.
- One subject. If you need two ideas, that's two slides.
- Ratio: **3:4** beside text, **16:9** behind it.

---

### TEMPLATE 4 — OBJECT
*A thing, made tangible. Something they'd hold.*

**Reach for it when:** you're pointing at a deliverable, a resource, a tool — and you want it to
feel real rather than described.

```
[THE OBJECT — e.g. a printed workbook / a closed notebook and pen /
a stack of cards], resting on a plain surface.
[Vertical / square] composition, subject centred, clean empty space around it.
Soft even light, plain uncluttered background, no branding on the object.

+ STYLE SUFFIX
```

**Notes**
- **"No branding on the object"** is essential. Generators love inventing logos and cover text, and
  a fake logo on a fake workbook is the fastest way to look untrustworthy.
- If it's a real thing you actually own — your workbook, your calculator, your book —
  **photograph it instead.** A real photo of a real deliverable beats any generated one.
- Ratio: **3:4** or **1:1**.

---

### TEMPLATE 5 — TEXTURE
*Abstract. No subject at all.*

**Reach for it when:** you want visual warmth without making a claim. Section dividers, accent
slides, anywhere a literal image would over-promise.

```
An abstract [MATERIAL / SURFACE — e.g. brushed paper grain / soft fabric weave /
gradient light falling across a plain wall], extreme close up, no recognisable objects.
Very low contrast, even tone, almost flat.

+ STYLE SUFFIX
```

**Notes**
- The safest image there is: it can't misrepresent anything, because it depicts nothing.
- Keep contrast **low**. Texture is a whisper — if it's loud enough to notice, it's too loud.
- Ratio: **16:9**.

---

### TEMPLATE 6 — PEOPLE
*Read the warning before you use this one.*

⚠️ **Never generate a photo of yourself, and never generate a client.** A generated face on your
own intro slide loses the room the moment they meet you in person — and an invented "client" on a
proof slide is a fabricated testimonial, whatever the intention. Your founder photo should be a
real photograph of you. Your proof slides use real, named results only.

That leaves one legitimate use: **anonymous human presence**, where the point is the situation,
not the person.

```
[A PERSON IN A SITUATION — e.g. someone working alone late at a desk],
seen from behind or in silhouette, face not visible, mid-distance.
Nobody looking at camera. Natural unposed body language.

+ STYLE SUFFIX
```

**Notes**
- **Face not visible.** From behind, in silhouette, or cropped. The moment a face is recognisable
  the audience starts wondering who it is instead of listening to you.
- If you want a real person on a slide, use a real photo you have the right to use.

---

## 5. Picking a ratio

| Where it goes | Ratio |
|---|---|
| Behind a slide (any slide) | **16:9** |
| Full-bleed hero | **16:9** |
| Beside text, portrait | **3:4** |
| A founder portrait | **4:5** |
| An object or icon-like shot | **1:1** |

Get this right at generation time. Cropping a 1:1 into a 16:9 background throws away half the
picture, usually the half you wanted.

---

## 6. Making a set look like one deck

1. **Generate your hero first.** It's the image people look at longest. Get it right before
   anything else.
2. **Then match everything to it.** Reuse the exact same style suffix. If the hero came back
   cooler or warmer than you asked for, **update your suffix to describe what you actually got** —
   not what you originally wrote. Match reality, not intention.
3. **Reuse, don't multiply.** One background can serve every story beat in the deck. The room
   won't notice repetition; they will notice inconsistency.
4. **Dark slides need dark images.** The veil helps, but a bright image behind a dark slide fights
   it and the text loses.
5. **If the image has to be SEEN, put it on a dark or accent slide.** On a light slide the veil
   washes the picture almost away — deliberately, so your dark text stays readable. That is right for
   a background you only want as a faint texture, and wrong for an image that is carrying a point.
   Backgrounds can go anywhere; point-makers want a dark surface.
5. **Look at them full size before you commit.** An image that reads fine as a thumbnail can be a
   mess at 1600×900 on a projector.

---

## 7. Getting them into the deck

Tell the builder which image goes where:

> "Use `hero-stage.png` on slide 8, and put `mood-nightdesk.png` behind the story bits."

Two ways it can wire them in:

- **Inlined as base64** — the deck stays one self-contained file that works with no internet. Best
  for presenting from a laptop or handing the file to someone.
- **An absolute `https://` URL** — keeps the file small, but the deck needs a connection on the day.

**Default to base64.** Venue wifi is the single most common thing that goes wrong on event day,
and a missing background on your $Million Moment™ slide is not the moment to find that out.

---

## 8. Using this as you grow

This is a framework, not a fixed list. As your brand develops:

- **Evolve the suffix, not the templates.** Your palette and mood will shift. Update the suffix
  once and every future image follows. That one paragraph is your visual identity in text form —
  keep it in your brand notes alongside your fonts and colours.
- **Write your own templates.** If you keep needing an image the six don't cover, write a seventh
  in the same shape: subject, treatment, palette, avoid. Save it. The shape is the useful part.
- **Keep what worked.** When an image lands well, save the exact prompt that made it — not just the
  file. A prompt you can re-run is worth more than a picture you can't reproduce.
- **Re-skin instead of regenerating.** Changing your deck's *theme* changes its whole look without
  touching a single image. Try that before you regenerate anything.

---

## 9. Before you use one

- [ ] No text, letters or numbers baked into the image
- [ ] Nothing in it implies a claim you can't back up
- [ ] No recognisable face of a real person who hasn't agreed to be there
- [ ] It still reads with the veil on top, on the surface it's going on
- [ ] It's yours to use — generated, licensed, or your own camera
- [ ] It's actually earning its place

**If an image is only filling space, cut it.** A clean text slide in your brand beats a decorative
photo every single time. That's why the whole kit is built to need none.

---

## Tools

Any generator works — these prompts are deliberately tool-agnostic.

If you're running the builder inside Claude Code or Cowork, the **`kie-image-gen` skill** handles
generation, preview-and-approve, and downloading into your folder in one flow. Ask for it by name.

**Your kit already ships six ready-made backgrounds** in `images/` — three moods, two heroes and a
portrait object shot, all desaturated to work under any of the six themes. Use them as they are,
or as a reference for what to aim at. `images/placeholder-spec.json` holds the exact prompts that
produced them, which is a working example of everything above.
