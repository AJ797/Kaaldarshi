# Kaaldarshi — public site

Public site for **Kaaldarshi (OPC) Private Limited** (referred to as *Kaaldarshi*
everywhere in copy). Incorporation pending; name reserved.

Kaaldarshi (कालदर्शी, "one who sees time") is an information company. The site's
job is to say that — systems that **infer rather than report** — and to present
the two arms as current instances of that question, not as the boundary of the
company.

| Arm            | What it is                                             | Route          |
| -------------- | ------------------------------------------------------ | -------------- |
| **Udant**      | Institutional intelligence tooling, built for analysts | `/udant`       |
| **K Research** | The research arm of Kaaldarshi                         | `/k-research`  |

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

Visual direction, page comps, the design system and the 390px layout live on the
project's Design canvas. Direction in one line: **instrument, not dashboard** —
ink ground, hairline structure, a single signal colour reserved for state, and
no decorative "intelligence platform" imagery.

K Research inverts to a paper ground: it is a journal, not a product page.

## Stack

- **Astro**, static output, zero client JS by default
- Self-hosted `woff2` subsets — **no font CDN**, so no third-party request and
  no CSP origin to allowlist. Devanagari is load-bearing (कालदर्शी, प्रत्यक्ष,
  अनुमान), so Noto Sans Devanagari subsets ship too.
- **Netlify** hosting; build config and headers in `netlify.toml`
- No analytics, no embedded widgets, no trackers

## Local development

```bash
npm install
npm run dev     # http://localhost:4321
npm run build   # -> dist/
npm run preview
```

## Security baseline

Enforced in `netlify.toml`:

- `Content-Security-Policy` with `default-src 'none'` and **no** `unsafe-inline`
  on `script-src` or `style-src`. If a build step emits an inline `<style>`,
  add its `sha256` hash — do not relax the directive.
- `frame-ancestors 'none'` plus legacy `X-Frame-Options: DENY`
- HSTS with `includeSubDomains; preload`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy` denying every powerful feature
- `Cross-Origin-Opener-Policy` / `Cross-Origin-Resource-Policy: same-origin`
- `X-Content-Type-Options: nosniff`

Other rules:

- No secrets in the repository. `.env*` is gitignored except `.env.example`.
- The Udant access form posts to a single serverless function with a honeypot
  field and rate limiting. It stores an email and a free-text note, nothing else.
- Dependencies stay minimal and pinned; run `npm audit` before each deploy.

## Published work (K Research index)

| # | Title | Venue | Date |
| - | ----- | ----- | ---- |
| 01 | *[TMLR PAPER TITLE — needed]* | TMLR | *[date needed]* |
| 02 | Usable Information Theory: A Framework for Meaning, Utility, and Intelligence in Bounded Agents | Preprint · Zenodo | Jun 2026 |
| 03 | Aham: A Metacognitive Architecture for Latent-Steered Theory-of-Mind in Large Language Models | Preprint · Zenodo | Jan 2026 |

- 02 — <https://zenodo.org/records/21063048> — doi 10.5281/zenodo.21063048
- 03 — <https://zenodo.org/records/18154827> — doi 10.5281/zenodo.18154827
- 01 — <https://openreview.net/forum?id=uZuaQlxfwG> — title not yet captured;
  OpenReview serves a bot challenge to automated fetches, so fill this in by hand.

No author byline is shown on the index yet; decide before launch.

## Still needed before launch

- TMLR paper title and publication date
- Registered office address
- Contact email
- CIN (issued on incorporation)

## Content

All site copy is supplied by the company and used verbatim. No metrics,
customer names or track-record figures appear anywhere until they are real —
live readings render as em-dashes with an "illustrative" caption.
