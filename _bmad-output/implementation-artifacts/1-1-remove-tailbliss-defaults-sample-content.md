# Story 1.1: Remove TailBliss Defaults & Sample Content

Status: done

## Story

As a **portfolio owner**,
I want all generic TailBliss sample content and branding removed,
So that I have a clean slate to build my own visual identity.

## Acceptance Criteria

1. **Given** the repository contains TailBliss sample content **When** the cleanup is completed **Then** all 14 sample posts are removed (`blog-post-{1-7}.md`, `news-post-{1-7}.md`)
2. **And** unused partials are removed (`newsletter.html`, `posts-template.html`, `post-tile.html`)
3. **And** TailBliss branding images are removed (5 `tailbliss-*.png/svg/webp` files, `sample-logo.svg`)
4. **And** TailBliss sample images are removed (`tailbliss-rocket-indigo.png`, `hacktoberfest.jpg`)
5. **And** unused platform configs are removed (`Dockerfile`, `nginx.conf`, `nixpacks.toml`, `cloudflare.md`, `theme.toml`)
6. **And** `content/prose.md` is reviewed and removed if not needed
7. **And** `assets/css/style.css` is audited — useful content merged into `main.css` or file removed entirely
8. **And** `pnpm run test` passes with the cleaned codebase (Hugo builds successfully)

## Tasks / Subtasks

- [x] Task 1: Remove 14 sample posts (AC: #1)
  - [x] Delete `content/posts/blog-post-{1-7}.md` (7 files)
  - [x] Delete `content/posts/news-post-{1-7}.md` (7 files)
- [x] Task 2: Remove unused partials (AC: #2)
  - [x] Delete `layouts/partials/newsletter.html`
  - [x] Delete `layouts/partials/posts-template.html`
  - [x] Delete `layouts/partials/post-tile.html`
  - [x] Remove `{{ partial "newsletter.html" . }}` call from `layouts/index.html:210`
  - [x] Remove `{{ partial "post-tile.html" . }}` call from `layouts/index.html:201`
  - [x] Remove `{{ partial "posts-template.html" . }}` call from `layouts/_default/list.html:16`
- [x] Task 3: Remove TailBliss branding images (AC: #3, #4)
  - [x] Delete `assets/images/pages/tailbliss-rocket-indigo.png`
  - [x] Delete `assets/images/pages/hacktoberfest.jpg`
  - [x] Delete `assets/images/global/sample-logo.svg`
  - [x] Delete `static/images/sample-logo.svg`
  - [x] Delete `static/images/tailbliss-cover.png`
  - [x] Delete `static/images/tailbliss-full-blue.png`
  - [x] Delete `static/images/tailbliss-full-blue.svg`
  - [x] Delete `static/images/tailbliss-rocket-indigo.webp`
  - [x] Delete `static/images/tailbliss-white.svg`
  - [x] Delete `images/logo-tailbliss-round.svg` (root `images/` dir)
  - [x] Delete `images/tailbliss-lighthouse-11-03-22.png` (root `images/` dir)
  - [x] Remove hero image references from `layouts/index.html:20` and `layouts/partials/head.html:23`
  - [x] Remove sample-logo fallback from `layouts/index.html:154` (sponsors section)
- [x] Task 4: Remove unused platform configs (AC: #5)
  - [x] Delete `Dockerfile`
  - [x] Delete `nginx.conf`
  - [x] Delete `nixpacks.toml`
  - [x] Delete `cloudflare.md`
  - [x] Delete `theme.toml`
- [x] Task 5: Review and remove `content/prose.md` (AC: #6)
  - [x] Confirm prose.md is TailBliss typography demo (375+ lines of lorem ipsum) — remove it
  - [x] Remove `assets/images/featured/featured-img-placeholder.png` referenced by prose.md
- [x] Task 6: Audit `assets/css/style.css` (AC: #7)
  - [x] Read style.css (large file ~50k tokens) — identify anything NOT covered by TailwindCSS 4.1 + main.css
  - [x] If useful styles exist: merge into `assets/css/main.css` under custom utilities section
  - [x] If no useful content: delete entirely
  - [x] Verify no templates reference style.css directly (check `<link>` tags, `@import` statements)
- [x] Task 7: Clean up template references to removed files (AC: #8)
  - [x] Update `layouts/index.html` — remove/stub sections that referenced deleted content (hero image, blog section with post-tile, newsletter, sponsors with sample-logo)
  - [x] Update `layouts/_default/list.html` — remove posts-template partial call
  - [x] Update `layouts/partials/head.html` — remove hero image preload
  - [x] Grep codebase for "tailbliss", "sample-logo", "hacktoberfest", "newsletter" — fix any remaining references
- [x] Task 8: Verify Hugo build passes (AC: #8)
  - [x] Run `pnpm run test` — must pass
  - [x] Run `pnpm run dev` — site loads without errors in browser
  - [x] Confirm no broken image references or missing partial errors in console

## Dev Notes

### Critical: What NOT to Do

- **Do NOT delete `netlify.toml`** — this is the active deployment config, not a TailBliss artifact
- **Do NOT delete `tailwind.config.js`** — active build config
- **Do NOT delete `vite.config.mjs`** — active CSS build pipeline
- **Do NOT delete `postcss.config.js`** — active build config
- **Do NOT delete `layouts/partials/pagination.html`** — this is reused in future stories
- **Do NOT delete `layouts/shortcodes/imgc.html`** — active image shortcode, used in future stories
- **Do NOT delete `assets/js/darkmode.js`** — modified in Story 1.3, not removed here
- **Do NOT modify `assets/css/main.css`** beyond style.css audit merge — design tokens are Story 1.2
- **Do NOT create new content** — this story is deletion only. New content comes in later epics
- **Do NOT restructure layouts** — only remove references to deleted files. Full layout redesign is Epic 2

### Template Cleanup Strategy

When removing partial calls from templates, use **minimal stubs** rather than deleting entire template sections. The homepage (`layouts/index.html`) currently has sections for hero, blog posts, sponsors, newsletter — after cleanup:

- **Hero section**: Remove the TailBliss hero image (`tailbliss-rocket-indigo.png`) reference. Leave the section structure with a placeholder comment `{{/* Hero section — redesigned in Story 2.3 */}}`
- **Blog section**: Remove the `{{ range (.Paginator 3).Pages }}` + `post-tile.html` block. Leave a comment `{{/* Posts section — rebuilt in Epic 3 */}}`
- **Sponsors section**: Remove entirely (TailBliss feature, not in DESIGN-SPEC)
- **Newsletter section**: Remove entirely (TailBliss feature, not in DESIGN-SPEC)

For `layouts/_default/list.html`: Replace the `posts-template.html` call with a simple range loop or comment stub. This page will be rebuilt in Story 3.4.

### style.css Audit Guide

The file is large. Focus on:
1. **Custom prose styles** — main.css already has custom prose styles. If style.css has different prose rules, compare and keep the better version in main.css
2. **Component styles** — anything that's pure Tailwind utility composition can be removed (Tailwind 4.1 handles this)
3. **Reset/normalize** — Tailwind includes its own reset. Remove duplicates
4. **Animation/transition** — DESIGN-SPEC says "no animation". Remove all transition/animation rules
5. **Dark mode** — check if style.css has dark mode rules that conflict with or supplement main.css

**Decision framework**: If in doubt, **delete it**. TailwindCSS 4.1 + main.css is the source of truth. Anything in style.css that's genuinely needed can be re-added later with proper design token integration (Story 1.2).

### Build Pipeline

```
Vite (assets/css/main.css) → TailwindCSS 4.1 → static/css/
Hugo reads static/css/ → compiles templates → public/
```

- CSS pipeline: Vite, NOT Hugo Pipes. Never use `resources.PostCSS` or Hugo Pipes for CSS
- Build: `pnpm run build` (production), `pnpm run dev:watch` (development)
- Test: `pnpm run test` (Hugo build validation)

### Branch Strategy

Per architecture D3.1: Create branch `phase0/1-1-remove-tailbliss-defaults` from `main`. Merge to `main` when complete.

### Project Structure Notes

- All files to remove are in the main repo (not submodules or theme directories)
- The `images/` directory at project root contains TailBliss logos — this is separate from `assets/images/` and `static/images/`
- After cleanup, `content/posts/` directory will be empty (no posts). This is expected — posts are created in Epic 3
- `static/images/` will still contain `site-logo.svg` and `og-images/` — these are replaced in Story 5.1, not removed here

### References

- [Source: _bmad-output/planning-artifacts/architecture.md § File Removal List]
- [Source: _bmad-output/planning-artifacts/architecture.md § Build Pipeline Clarification]
- [Source: _bmad-output/planning-artifacts/architecture.md § Implementation Patterns]
- [Source: _bmad-output/planning-artifacts/epics.md § Story 1.1]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md § 10 Design Principles]

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

### Completion Notes List

- Deleted 14 sample posts (7 blog-post, 7 news-post)
- Deleted 3 unused partials (newsletter.html, posts-template.html, post-tile.html)
- Deleted 11 TailBliss branding/sample images across assets/, static/, and root images/
- Deleted 5 unused platform configs (Dockerfile, nginx.conf, nixpacks.toml, cloudflare.md, theme.toml)
- Deleted content/prose.md (TailBliss typography demo) and its placeholder image
- Deleted assets/css/style.css — confirmed as old Tailwind v3 compiled output, entirely redundant with Vite + TailwindCSS 4.1 pipeline
- Updated layouts/index.html: removed hero image, blog/post-tile section, sponsors section, newsletter section; kept P1/P2 sections with site params; added comment stubs for future stories
- Updated layouts/_default/list.html: replaced posts-template partial call with comment stub
- Updated layouts/partials/head.html: removed hero image preload block
- Updated hugo.yaml: cleared og_image to empty string, disabled newsletter_signup
- **CODE REVIEW FIXES (2026-02-12):**
  - Fixed hugo.yaml: changed title from "TailBliss" to "Nicolas de Barquin", baseURL cleared, author changed to "Nicolas de Barquin", moto/description updated to portfolio-specific text, removed Hacktoberfest heading, disabled all social media links (nusserstudios URLs removed)
  - Fixed package.json: changed name to "ndb-portfolio", author to "Nicolas de Barquin", repository URLs updated to ndb/ndb_hugo-tailbliss
  - Fixed layouts/partials/footer.html: removed "Made with ❤️ by Nusser Studios" credit line
  - Fixed archetypes/default.md: changed author from "TailBliss" to "Nicolas de Barquin"
  - Fixed CLAUDE.md: updated partials list to remove references to deleted newsletter/post-tile partials
- Note: root images/ directory still has screenshot.jpg and tn.jpg (TailBliss theme screenshots, not explicitly in story scope)
- `pnpm run test` passes: 11 pages, 0 errors, 142ms build

### File List

**Deleted:**
- content/posts/blog-post-1.md
- content/posts/blog-post-2.md
- content/posts/blog-post-3.md
- content/posts/blog-post-4.md
- content/posts/blog-post-5.md
- content/posts/blog-post-6.md
- content/posts/blog-post-7.md
- content/posts/news-post-1.md
- content/posts/news-post-2.md
- content/posts/news-post-3.md
- content/posts/news-post-4.md
- content/posts/news-post-5.md
- content/posts/news-post-6.md
- content/posts/news-post-7.md
- layouts/partials/newsletter.html
- layouts/partials/posts-template.html
- layouts/partials/post-tile.html
- assets/images/pages/tailbliss-rocket-indigo.png
- assets/images/pages/hacktoberfest.jpg
- assets/images/global/sample-logo.svg
- assets/images/featured/featured-img-placeholder.png
- static/images/sample-logo.svg
- static/images/tailbliss-cover.png
- static/images/tailbliss-full-blue.png
- static/images/tailbliss-full-blue.svg
- static/images/tailbliss-rocket-indigo.webp
- static/images/tailbliss-white.svg
- images/logo-tailbliss-round.svg
- images/tailbliss-lighthouse-11-03-22.png
- Dockerfile
- nginx.conf
- nixpacks.toml
- cloudflare.md
- theme.toml
- content/prose.md
- assets/css/style.css

**Modified:**
- layouts/index.html
- layouts/_default/list.html
- layouts/partials/head.html
- layouts/partials/footer.html
- hugo.yaml
- package.json
- archetypes/default.md
- CLAUDE.md
