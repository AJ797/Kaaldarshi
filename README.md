# Kaaldarshi — public site

Public site for **Kaaldarshi (OPC) Private Limited** (referred to as *Kaaldarshi*
everywhere in copy). Incorporation pending; name reserved.

Kaaldarshi (कालदर्शी, "one who sees time") is an information company. The site's
job is to say that — systems that **infer rather than report** — and to present
the two arms as current instances of that question, not as the boundary of the
company.

| Route          | What it is                                   |
| -------------- | -------------------------------------------- |
| `/`            | Kaaldarshi: the thesis, the arms, the entity |
| `/udant`       | Arm 01 — institutional intelligence tooling  |
| `/k-research`  | Arm 02 — the research arm, on a paper ground |
| `/thanks`      | Access-request confirmation                  |
| `/404`         | Not found                                    |

## Positioning rules that are load-bearing

Two things on the home page are easy to break during a redesign:

1. **The domain list stays flat.** Corridor, codebase, market, terrain — four
   items, identical type size, identical treatment, no icons, numbered 01–04.
   Geopolitics sits third of four and carries no more weight than a codebase. If
   one item ever gets featured, the positioning collapses into "intelligence
   plus some other stuff."
2. **Arms, not verticals.** The arms section is headed in the present tense
   ("where the question is being asked right now"). Nothing should imply the
   list of two is the full extent of the company.

## Design

Direction in one line: **instrument, not dashboard** — ink ground, hairline
structure, a single signal colour reserved for state, and no decorative
"intelligence platform" imagery. Full comps and the design system live on the
project's Design canvas.

- **Ground is fixed by brand, not by `prefers-color-scheme`.** Ink everywhere,
  except K Research, which inverts to paper because it is a journal. Pages opt
  in with `ground="paper"`, which re-points the same token names.
- **Signal `#CC4A2B` means state** — live, open, crossed, falsified, active.
  Never decoration, never a second brand colour. At 4.3:1 it is for marks and
  rules only; small signal text steps up to `#E57350` (6.5:1).
- **Steel `#7E9AAE` is data geometry only** and carries no brand meaning.

### The mark

`src/components/Mark.astro` holds the Kaaldarshi mark as a single even-odd
path, traced from the supplied raster with marching squares plus
Douglas-Peucker simplification — 14 subpaths, 341 points, 3.4KB, crisp from
20px to full bleed. It takes `currentColor`, so it recolours with the ground.
`public/favicon.svg` and `public/og.svg` are generated from the same path.

**The artwork is never animated internally.** Its ring, spokes and triangle
share hole boundaries and cannot be separated without distorting it. Motion
belongs to `MarkBezel.astro`, which turns a ring of measuring ticks around the
static mark, driven by scroll position rather than a timer — so the movement
reports where you are on the page instead of just being busy.

### Material and motion

- **Film grain and a vignette** sit over the ground (`public/noise.png`, 13KB,
  tiled). On a dark site this is the difference between a flat page and a
  surface with a material.
- **Scale contrast carries the hierarchy**: display type runs to 124px against
  10px mono labels, roughly a 12x ratio.
- **Section indices run vertically** down the gutter with a hairline dropping
  from them, and the Standard section drops the rail entirely. Without that
  variation every section reads as the same slide.
- **Motion is transform and opacity only**, nothing travels more than 18px,
  and `prefers-reduced-motion: reduce` zeroes every duration and delay and
  stops the ticker.
- Scroll position publishes to a `--scroll` custom property **through the
  CSSOM**, which CSP does not gate — unlike a `style` attribute, which
  `style-src 'self'` would block.
- The ticker carries only true statements. No invented telemetry, no counters.

### There is no scroll-snap

It was built, measured and removed. Every section here is taller than the
viewport, and `scroll-snap-align: start` on a section taller than the scrollport
pins the page at the section start — a measured `scrollBy(0, 1500)` moved
**0px**. The rule was that the wheel always wins, so snap lost. Scroll
pagination is carried by the fixed rail (`ScrollRail.astro`) plus smooth anchor
scrolling. Do not reintroduce snap without re-measuring.

## Stack

- **Astro**, static output, zero client JS except one small bundled module
- **Netlify** hosting; build config and headers in `netlify.toml`
- No analytics, no embedded widgets, no trackers, no third-party requests

### Fonts

Self-hosted `woff2` in `public/fonts/`, sourced from the `@fontsource` packages
in `dependencies`. No font CDN, so there is no third-party request and no CSP
origin to allowlist.

Devanagari is load-bearing (कालदर्शी, प्रत्यक्ष, अनुमान). The full Noto Sans
Devanagari face is 121 KB for about sixteen glyphs, so it ships subset to 17 KB:

```bash
bash tools/subset-devanagari.sh
```

**If you add new Devanagari copy, add its characters to
`tools/devanagari-glyphs.txt` and re-run that script** — otherwise the new text
falls back to a system font. Requires `pip install fonttools brotli`.

## Local development

```bash
npm install
```

```bash
npm run dev
```

```bash
npm run build
```

## Security baseline

Enforced in `netlify.toml`:

- `Content-Security-Policy` with `default-src 'none'`, **no** `unsafe-inline`
  on `script-src` or `style-src`, and **no `data:` anywhere** — every
  directive resolves to `'self'`. Keep it that way: if something needs a
  `data:` URI, ship it as a file instead.
- `frame-ancestors 'none'` plus legacy `X-Frame-Options: DENY`
- HSTS with `includeSubDomains; preload`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy` denying every powerful feature
- `Cross-Origin-Opener-Policy` / `Cross-Origin-Resource-Policy: same-origin`
- `X-Content-Type-Options: nosniff`

The build is written to satisfy that CSP rather than the other way round:

- `build.inlineStylesheets: 'never'` and `vite.build.assetsInlineLimit: 0`, so
  no `<style>` block and no `data:` URI is ever emitted.
- **No `style=""` attributes anywhere.** `style-src 'self'` blocks inline style
  attributes too, so design-time geometry (reading-strip fills, baseline ticks)
  resolves to utility classes in `global.css`. Add a step there before using it.
- `public/js/boot.js` is external and parser-blocking. Its only job is to add a
  `js` class before first paint, so progressive-enhancement states can hide
  themselves without an inline-script hash and without ever hiding content from
  a no-JS visitor.

Verify after a build — both counts must be zero:

```bash
grep -o 'style="[^"]*"' dist/*.html | wc -l
```

```bash
grep -h -c '<style' dist/*.html
```

```bash
grep -o 'data:' dist/*.html dist/_astro/*.css | wc -l
```

Other rules:

- No secrets in the repository. `.env*` is gitignored except `.env.example`.
- The Udant access form uses **Netlify Forms** with a honeypot field
  (`netlify-honeypot="bot-field"`) and posts to `/thanks` on the same origin, so
  `form-action 'self'` holds. No custom function, no third-party endpoint. It
  collects an email and an optional free-text note, nothing else. Netlify Forms
  must be enabled on the site for submissions to be captured.
- No domain is hardcoded. `astro.config.mjs` reads `SITE_URL`, then Netlify's
  build-time `URL`, falling back to localhost — so canonical URLs, `og:url`,
  `robots.txt` and `sitemap.xml` are correct without anyone guessing a domain.
- Dependencies stay minimal and pinned; run `npm run audit` before each deploy.

## Accessibility

- Real `<button>`, `<a href>`, `<input>` + `<label>` throughout; no click
  handlers on divs.
- The capability tablist follows the ARIA tabs pattern with roving tabindex and
  arrow/Home/End keys. **Without JavaScript every panel renders, stacked** —
  nothing is hidden from a no-JS visitor.
- Visible focus ring on everything, never removed. 48px minimum touch targets.
- `prefers-reduced-motion: reduce` drops every transition to 0ms and turns off
  smooth scrolling.
- Hit and miss marks differ in lightness as well as hue, so they survive a
  greyscale print and most colour-vision differences.

## Published work (K Research index)

| # | Title | Venue | Date |
| - | ----- | ----- | ---- |
| 01 | When Routing Doesn't Move the Loss: Genre-Associated Routing Specialisation in a 125M-Parameter Hybrid Language Model | TMLR | Sep 2026 |
| 02 | Usable Information Theory: A Framework for Meaning, Utility, and Intelligence in Bounded Agents | Preprint · Zenodo | Jun 2026 |
| 03 | Aham: A Metacognitive Architecture for Latent-Steered Theory-of-Mind in Large Language Models | Preprint · Zenodo | Jan 2026 |

- 01 — <https://openreview.net/forum?id=uZuaQlxfwG>
- 02 — <https://zenodo.org/records/21063048> — doi 10.5281/zenodo.21063048
- 03 — <https://zenodo.org/records/18154827> — doi 10.5281/zenodo.18154827

No author byline is shown on the index, by choice.

## Addresses

Both live in `src/lib/site.ts` so a change lands everywhere at once:

- `intelligence@kaaldarshi.systems` — Udant access requests
- `ariet@kaaldarshi.systems` — general contact

## Still needed before launch

- Registered office address → `[REGISTERED OFFICE]` on `/`
- CIN, issued on incorporation → currently reads "On issue"
- Enable Netlify Forms on the site, and point a domain at it

## Content

All site copy is supplied by the company and used verbatim. No metrics,
customer names or track-record figures appear anywhere until they are real —
live readings render as em-dashes with an "illustrative" caption, and the
forecast card is a schema with bracketed fields, not an invented example.
