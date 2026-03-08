# Story 5.1: Replace Branding Assets

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want all generic branding replaced with my own,
So that the portfolio is unmistakably mine.

## Acceptance Criteria

1. `assets/images/global/author.webp` is replaced with Nicolas's photo
2. `static/favicon/` contains Nicolas's favicon set (favicon.ico, favicon-16x16.png, favicon-32x32.png, apple-touch-icon.png at minimum)
3. `static/images/site-logo.svg` is replaced with Nicolas's logo OR removed if no logo is used
4. OG images in `static/images/og-images/` are updated for social sharing (at minimum: a default OG image)
5. No TailBliss or placeholder branding remains anywhere in the site — audit all `static/` and `assets/images/` for leftover TailBliss files
6. `hugo.yaml` author name, site title, description reflect Nicolas's identity
7. `pnpm run test` passes

## Tasks / Subtasks

- [ ] Audit current branding state (AC: 5)
  - [ ] List all files in `assets/images/`, `static/favicon/`, `static/images/`
  - [ ] Identify any remaining TailBliss/placeholder assets not removed in Epic 1
  - [ ] Note which files need replacing vs. which are already clean

- [ ] Replace author photo (AC: 1)
  - [ ] Place Nicolas's photo at `assets/images/global/author.webp`
  - [ ] If providing a non-WebP source, use the `imgc` shortcode pipeline or convert manually
  - [ ] Verify the author photo renders correctly wherever it's referenced in templates

- [ ] Replace/update favicon (AC: 2)
  - [ ] Place favicon files in `static/favicon/`
  - [ ] Required: `favicon.ico`, `favicon-16x16.png`, `favicon-32x32.png`, `apple-touch-icon.png`
  - [ ] Verify `layouts/partials/head.html` references the correct favicon paths

- [ ] Handle site logo (AC: 3)
  - [ ] If Nicolas has a logo SVG: replace `static/images/site-logo.svg`
  - [ ] If no logo: remove the file and update any template references to remove the `<img>` tag
  - [ ] Check `layouts/partials/nav.html` for logo references

- [ ] Update OG images (AC: 4)
  - [ ] Place a default OG image at `static/images/og-images/default-og.png` (or similar)
  - [ ] Recommended: 1200x630px, Nicolas's name/tagline, clean design
  - [ ] Verify `layouts/partials/head.html` or `meta.html` references OG images correctly

- [ ] Final audit — no TailBliss branding (AC: 5)
  - [ ] Search for any `tailbliss` references in templates or static files
  - [ ] Confirm all 5 `tailbliss-*.png/svg/webp` files and `sample-logo.svg` were removed in Epic 1
  - [ ] If any remain, remove them now

- [ ] Verify hugo.yaml identity metadata (AC: 6)
  - [ ] `hugo.yaml`: `title`, `author`, `description` reflect Nicolas's identity
  - [ ] Social links (GitHub, etc.) are correct

- [ ] Run `pnpm run test` (AC: 7)

## Dev Notes

### Asset Handoff Context

This story is **content-heavy and requires Nicolas directly** for asset provision. The dev agent scaffolds the structure and verifies template wiring; Nicolas provides the actual image files.

**What Nicolas needs to provide:**
- Author photo (ideally 400x400px+, WebP or JPG/PNG — will be converted)
- Favicon set (can generate from a single high-res PNG using a favicon generator)
- Logo SVG (optional — if not provided, remove logo references from nav)
- OG image (1200x630px, PNG preferred)

**If assets aren't available yet:** Create placeholder files with a note, and mark the story as "needs content" — do not block on waiting for assets if the template wiring can be verified.

### Template Wiring to Verify

Key files that reference branding assets:
- `layouts/partials/head.html` — favicon links, OG meta tags
- `layouts/partials/nav.html` — logo (if any)
- `layouts/partials/meta.html` — OG image, author meta
- Any author bio partial — author photo

### Author Photo Pipeline

The `imgc` shortcode handles WebP optimization:
```
{{< imgc src="global/author.webp" alt="Nicolas" >}}
```

For direct `<img>` in templates (not shortcodes), use Hugo's image processing:
```go-html-template
{{ $img := resources.Get "images/global/author.webp" }}
{{ with $img }}
  <img src="{{ .RelPermalink }}" alt="Nicolas" width="{{ .Width }}" height="{{ .Height }}">
{{ end }}
```

### Architecture Compliance

- [Source: epics.md §Epic 5, Story 5.1 AC]
- [Source: epics.md §D1.3] — `imgc` shortcode for WebP optimization with lazy loading
- [Source: DESIGN-SPEC.md §1] — Portfolio is the public-facing light gallery
- [Source: architecture.md] — File removal list included TailBliss branding images in Epic 1 — verify completion

### Project Structure Notes

Files touched:
- `assets/images/global/author.webp` (replace)
- `static/favicon/` (replace/update files)
- `static/images/site-logo.svg` (replace or remove)
- `static/images/og-images/` (add/update)
- `hugo.yaml` (title, author, description)
- `layouts/partials/head.html` (verify — may need path updates)
- `layouts/partials/nav.html` (verify logo reference)

### References

- [Source: epics.md §Story 5.1 — Replace Branding Assets]
- [Source: epics.md §D3.1] — Epic 1 should have removed original TailBliss branding
- [Source: epic-4-retro-2026-03-07.md §Epic 5 Preview] — "Nicolas hands-on" for Epic 5

## Dev Agent Record

### Agent Model Used

*Recommended: claude-haiku-4-5-20251001 — asset audit and template wiring verification*

### Debug Log References

### Completion Notes List

### File List
