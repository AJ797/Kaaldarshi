# Kaaldarshi — public site

Public marketing site for **Kaaldarshi (OPC) Private Limited** (referred to as
*Kaaldarshi* everywhere in copy). Incorporation pending; name reserved.

Two verticals are presented:

| Vertical     | What it is                                             | Route          |
| ------------ | ------------------------------------------------------ | -------------- |
| **Udant**    | Institutional intelligence tooling, built for analysts | `/udant`       |
| **K Research** | The research arm of Kaaldarshi                       | `/k-research`  |

## Design

The visual direction, page comps, design system and small-screen layouts live
on the Design canvas for this project. Direction in one line: **instrument, not
dashboard** — ink ground, hairline structure, a single signal colour reserved
for state, and no decorative "intelligence platform" imagery.

K Research inverts to a paper ground: it is a journal, not a product page.

## Stack

- **Astro**, static output, zero client JS by default
- Self-hosted `woff2` subsets — **no font CDN**, so no third-party request and
  no CSP origin to allowlist
- **Netlify** hosting, build config and headers in `netlify.toml`
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
- The access-request form posts to a single serverless function with a honeypot
  field and rate limiting. It stores an email and a free-text note, nothing else.
- Dependencies are kept minimal and pinned; run `npm audit` before each deploy.

## Entity details still needed

These are placeholders in the comps and must be filled before launch:

- Registered office address
- Contact email
- CIN (issued on incorporation)

## Content ownership

All Udant and K Research copy is supplied by the company. Company-level copy on
the home page (hero line, position statement) is a draft and open to revision.
No metrics, customer names or track-record figures appear anywhere until they
are real.
