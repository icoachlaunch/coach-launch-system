# The Brand Kit

**One look, everywhere.** Pick a theme once, here, and every visual thing you build runs
on it — slides, funnel pages, ads, social posts, guides. You never pick a colour twice.

Open **`brand-kit.html`** in a browser to see the six looks side by side on real work.

---

## The three layers

Everything is built from three files stacked in this order. That order matters.

```html
<link rel="stylesheet" href="tokens/sovereign.css">   <!-- 1. the look   -->
<link rel="stylesheet" href="blocks.css">             <!-- 2. the pieces -->
<link rel="stylesheet" href="surfaces/page.css">      <!-- 3. the medium -->
```

| Layer | File | Owns | Changes when |
|---|---|---|---|
| **1 · Theme** | `tokens/<name>.css` | Colour, fonts, corners, shadows | You pick a different look |
| **2 · Blocks** | `blocks.css` | Buttons, cards, lists, quotes, prices | Almost never |
| **3 · Surface** | `surfaces/<medium>.css` | Layout and base size for one medium | You build a different *kind* of thing |

The whole point: **only Layer 1 knows what colour your brand is.** Layers 2 and 3 contain no
hex codes and no font names. Swap the one file on line 1 and everything below re-skins itself.

---

## The six themes

| Theme | Feels like | Hero | Type |
|---|---|---|---|
| **Crimson** | Confident, modern, high-energy | `#db0063` | Montserrat / Lato |
| **Ink** | Editorial, considered, premium | `#9e2b25` | Playfair Display / Inter |
| **Ember** | Warm, approachable, friendly | `#d2582f` | Poppins / Karla |
| **Sovereign** | Restrained, high-ticket, classic | `#b8912f` | Cormorant Garamond / Lato |
| **Voltage** | Dark, technical, performance | `#21d4fd` | Space Grotesk / IBM Plex Sans |
| **Meadow** | Calm, natural, wellness | `#1fa85c` | Outfit / Inter |

Pick the one that fits your business, not the one you personally like best. Your Visual Style
Guide (Foundation 2) walks you through choosing.

---

## The three surfaces

Every theme defines three grounds. Put `data-surface` on `<html>`, a section, or any wrapper,
and everything inside re-reads its colours automatically.

```html
<section>                       <!-- light: the default        -->
<section data-surface="D">      <!-- dark band                 -->
<section data-surface="A">      <!-- your brand colour         -->
```

Use the accent surface sparingly — it is the loudest thing you have. On a page, one or two
bands. On a deck, only the genuine peaks.

---

## The four media

| Surface file | For | Base size |
|---|---|---|
| `surfaces/page.css` | Funnel pages, sales pages, long-form guides | Responsive `rem` |
| `surfaces/slide.css` | 16:9 presentation slides | `cqw` — scales with the slide |
| `surfaces/social.css` | Square, portrait, story and ad canvases | `cqw` — exports at full size |

Social ships four shapes: `--square` (1:1), `--portrait` (4:5), `--story` (9:16) and
`--wide` (1.91:1). Story canvases carry safe-area padding, because the platform draws its
own controls over the top and bottom bands.

---

## Building a page

```html
<link rel="stylesheet" href="tokens/crimson.css">
<link rel="stylesheet" href="blocks.css">
<link rel="stylesheet" href="surfaces/page.css">

<section class="cl-section cl-hero">
  <div class="cl-container">
    <p class="cl-eyebrow">Free live masterclass</p>
    <h1 class="cl-h1">The <span class="cl-mark">one shift</span> that fills your calendar</h1>
    <p class="cl-lede">Ninety minutes, and no pitch until the end.</p>
    <a class="cl-btn" href="#">Save my seat</a>
  </div>
</section>
```

That page is now Crimson. Change line 1 to `tokens/meadow.css` and it is Meadow — same markup,
same words, different brand. Nothing else moves.

---

## The blocks

| Block | Class |
|---|---|
| Eyebrow / kicker | `.cl-eyebrow` |
| Headings | `.cl-h1` `.cl-h2` `.cl-h3` |
| Lede and body | `.cl-lede` `.cl-body` `.cl-meta` |
| Highlighter | `.cl-mark` · accent text `.cl-hl` |
| Buttons | `.cl-btn` · `.cl-btn--ghost` · `.cl-btn--block` |
| Cards | `.cl-card` · `--raised` · `--feature` |
| Callout | `.cl-callout` |
| Badges | `.cl-badge` · `.cl-badge--quiet` |
| Lists | `.cl-list--tick` · `--cross` · `--num` |
| Before / after | `.cl-compare` |
| Stat | `.cl-stat` |
| Testimonial | `.cl-quote` |
| Price | `.cl-price` · value stack `.cl-stack` |
| Photo behind text | `.cl-bg` (auto-veiled per surface) |
| Countdown timer | `.cl-countdown` |
| Announcement bar | `.cl-announce` |
| Image placeholder | `.cl-imgslot` · `--wide` · `--tall` |
| Order bump | `.cl-bump` |
| FAQ accordion | `.cl-faq` (`<details>`, no JavaScript) |

### Paper — a card that keeps its own ground

Most blocks follow the surface they sit on. Sometimes you want the opposite: a light slab
floating on a dark band, the way the Magic Formula™ Monolith works. That's what the
`--paper` family is for — `--paper`, `--paper-ink`, `--paper-soft`, `--paper-line`. They are
deliberately **not** redefined by `data-surface`, so they stay put whatever ground they land on.

Voltage is the exception that proves it: being dark-first, its paper is dark too. A dark-native
brand shouldn't suddenly sprout white cards.

---

## Rules that keep it congruent

1. **Never type a hex code outside a theme file.** If you need a colour that isn't a token,
   the system is missing a token — add it to all six themes, not to one page.
2. **One theme per client, everywhere.** Not one for slides and another for the funnel.
3. **The accent surface is a peak, not a decoration.**
4. **Type sizes come from the scale.** `--fs--1` through `--fs-4`. Don't set `font-size` in px.
5. **Restraint with images.** Any block can sit over a photo via `.cl-bg`, and the veil keeps
   text readable. That doesn't mean every block should.

---

## Accessibility

Every theme is contrast-checked. All six pass WCAG AA for body text on light, dark and accent
surfaces, and for their call-to-action buttons — except one documented ceiling:

> **Ember's accent surface tops out at 4.06:1.** Its orange is mid-luminance, so no text colour
> can do better. Headlines and buttons are fine there; body copy and captions are not. Put
> those on the light or dark surface. This is written at the top of `tokens/ember.css`.

`--ink-on-brand` exists because of this. White on gold, cyan or green is unreadable, so
Sovereign, Voltage and Meadow put **dark** text on their brand colour. Never assume white.
