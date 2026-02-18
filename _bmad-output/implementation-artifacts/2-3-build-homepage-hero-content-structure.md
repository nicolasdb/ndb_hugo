# Story 2.3: Build Homepage Hero & Content Structure

Status: done

## Story

As a **portfolio visitor**,
I want to see Nicolas's identity and tagline when landing on the site,
So that I immediately understand what this portfolio is about.

## Acceptance Criteria

1. **Given** the homepage shows generic TailBliss content
   **When** the hero and homepage are rebuilt
   **Then** `content/_index.md` exists with hero content in frontmatter (tagline, description)

2. **And** `layouts/partials/hero.html` renders hero content from `.Params.hero` (no hardcoded strings)

3. **And** `layouts/index.html` uses the hero partial and reads from `content/_index.md`

4. **And** `layouts/partials/section-heading.html` exists (mono uppercase section label, reusable)

5. **And** the homepage has empty placeholder sections for "Latest Posts", "Patterns", and "Timeline" (wired in Epic 4)

6. **And** the homepage is responsive across `sm`/`md`/`lg` breakpoints

7. **And** `pnpm run test` passes

## Tasks / Subtasks

- [x]Task 1: Create content/_index.md with hero frontmatter (AC: #1)
  - [x]1.1 Create `content/_index.md` with YAML frontmatter:
    ```yaml
    title: "Nicolas de Barquin"
    description: "Portfolio & Skills Repository"
    hero:
      tagline: "Building a living knowledge graph from documented work"
      description: "Capturing knowledge pearls, discovering skill patterns, and making the invisible visible — one evidence trail at a time."
      stats:
        pearls: 0
        projects: 0
        patterns: 0
    ```
  - [x]1.2 Content can be placeholder — Nicolas will refine text later

- [x]Task 2: Create hero.html partial (AC: #2)
  - [x]2.1 Create `layouts/partials/hero.html` matching DESIGN-SPEC §6 Hero:
    - Name: `font-heading text-[40px] font-bold tracking-[-0.02em]` max 18ch
    - Description: `font-body text-[17px] leading-[1.7] text-[var(--text-secondary)]` max 54ch
    - Stats: `font-mono text-[12px] text-[var(--text-tertiary)]` with `·` separators
    - Freshness heartbeat: `font-mono text-[11px] text-[var(--frontier)]` — static placeholder for Phase 0
  - [x]2.2 Read all content from `.Params.hero` — no hardcoded strings
  - [x]2.3 Use `{{ with }}` guards for optional fields (stats, freshness)
  - [x]2.4 Page max-width: 920px centered with 32px horizontal padding

- [x]Task 3: Create section-heading.html partial (AC: #4)
  - [x]3.1 Create `layouts/partials/section-heading.html`
  - [x]3.2 Implement DESIGN-SPEC §6 Section Heading:
    - `font-mono text-[12px] font-normal uppercase tracking-[0.08em] text-[var(--text-tertiary)]`
    - Optional right-aligned "All posts →" link (same style)
    - Flex row, space-between
  - [x]3.3 Interface: `{{ partial "section-heading.html" (dict "label" "LATEST POSTS" "link" "/posts/" "linkText" "All posts →") }}`
  - [x]3.4 `link` and `linkText` are optional — guard with `{{ with }}`

- [x]Task 4: Rebuild layouts/index.html (AC: #3, #5, #6)
  - [x]4.1 Remove all TailBliss P1/P2/P3 section content
  - [x]4.2 Add hero partial call: `{{ partial "hero.html" . }}`
  - [x]4.3 Add empty placeholder sections with section-heading partial:
    - "LATEST POSTS" — `<!-- Wired in Story 4.4 -->`
    - "SKILL PATTERNS" — `<!-- Wired in Story 4.4 -->`
    - "MOMENTS OF RECOGNITION" — `<!-- Wired in Story 4.4 -->`
  - [x]4.4 Each section: 920px max-width centered, semantic `<section>` element
  - [x]4.5 Section padding-y: 44px per DESIGN-SPEC §4
  - [x]4.6 Responsive: mobile-first, test at `sm`/`md`/`lg` breakpoints

- [x]Task 5: Clean up hugo.yaml params (AC: #1)
  - [x]5.1 Remove TailBliss `p1`, `p2`, `p3`, `p4`, `p5` param blocks from `hugo.yaml`
  - [x]5.2 Remove `social_media` block if not used
  - [x]5.3 Keep `author`, `authorimage`, `description`, `disable_theme_toggle`

- [x]Task 6: Verify build and rendering (AC: #7)
  - [x]6.1 Run `pnpm run build` — must succeed
  - [x]6.2 Run `pnpm run test` — Hugo build validation must pass
  - [x]6.3 Verify hero renders with correct fonts and spacing
  - [x]6.4 Verify placeholder sections show headings with no errors

## Dev Notes

### DESIGN-SPEC §6 — Hero Component

- Name: Literata 40px, weight 700, letter-spacing -0.02em, max 18ch
- Description: Hanken Grotesk 17px, line-height 1.7, text-secondary, max 54ch
- Stats: Commit Mono 12px, text-tertiary, flex with `·` separators
- Freshness heartbeat: Commit Mono 11px, frontier color, 8px below stats
  - Format: `last pearl captured {time} ago`
  - Phase 0: static placeholder (e.g., "last pearl captured — ago" or omit entirely)

### Homepage Architecture Pattern

```
content/_index.md → .Params.hero → hero.html partial → rendered in index.html
```

**Critical:** `layouts/index.html` reads `.Params` from `content/_index.md`. No hardcoded strings in templates. This makes content editable without touching templates.

### DESIGN-SPEC §6 — Section Heading Component

- Commit Mono 12px, weight 400, uppercase, letter-spacing 0.08em, text-tertiary
- Optional right-aligned link (same style)
- Flex row, space-between

### Current hugo.yaml Cleanup

The `params` section still has TailBliss placeholder content:
- `p1` through `p5`: lorem ipsum sections with images — **remove all**
- `social_media`: all disabled — **remove**
- `moto`: keep (used as site subtitle)

### Spacing Reference (DESIGN-SPEC §4)

- Page max-width: 920px
- Page padding-x: 32px (portfolio)
- Section padding-y: 44px
- Card padding: 24px

### Partial Interface Conventions (Architecture Doc)

- Partials needing context beyond `.` receive a `dict`:
  ```go-html-template
  {{ partial "section-heading.html" (dict "label" "LATEST POSTS" "link" "/posts/" "linkText" "All posts →") }}
  ```
- Use `"page"` as dict key for page context when needed (not `"context"`)
- Hero partial receives `.` directly since it reads `.Params.hero`

### What NOT to Do

- ❌ Do NOT hardcode hero text in the template — read from `content/_index.md`
- ❌ Do NOT wire homepage content sections to actual content queries — that's Story 4.4
- ❌ Do NOT create post-list-item, pattern-card, or timeline-moment partials — those are Epic 3/4
- ❌ Do NOT add the freshness heartbeat as a live API call — Phase 0 is static
- ❌ Do NOT use custom CSS for spacing/layout — Tailwind utilities only
- ❌ Do NOT keep any TailBliss P1-P5 section templates or params

### Scope Boundary

This story builds the hero and homepage shell. It does NOT:
- Create post, pattern, or timeline partials (Epics 3-4)
- Wire homepage sections to real content queries (Story 4.4)
- Redesign nav (Story 2.2) or footer (Story 2.4)
- Add real content beyond placeholder frontmatter

### Previous Story Dependencies

- **Story 2.1**: Font utilities (`font-heading`, `font-body`, `font-mono`) must be available
- **Story 2.2**: Nav redesign should be complete for visual coherence, but hero works independently

### Project Structure Notes

**Files to create:**
- `content/_index.md` — Homepage content with hero frontmatter
- `layouts/partials/hero.html` — Hero section partial
- `layouts/partials/section-heading.html` — Reusable section label

**Files to modify:**
- `layouts/index.html` — Replace TailBliss content with hero + placeholder sections
- `hugo.yaml` — Remove TailBliss p1-p5 params

**Files NOT to modify:**
- `layouts/_default/baseof.html` — Already wraps index.html
- `layouts/partials/nav.html` — Story 2.2 handles this
- `layouts/partials/footer.html` — Story 2.4 handles this

### References

- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md#Component: Hero]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md#Component: Section Heading]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md#Page: Home]
- [Source: _bmad-output/planning-artifacts/architecture.md#Homepage Content Pattern]
- [Source: _bmad-output/planning-artifacts/architecture.md#Partial Interface Pattern]
- [Source: _bmad-output/planning-artifacts/epics.md#Story 2.3]

### Branch Strategy

Per architecture D3.1: Create branch `phase0/2-3-build-homepage-hero-content-structure` from `main`.

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

No issues encountered during implementation.

### Completion Notes List

- Created `content/_index.md` with hero frontmatter (title, tagline, description, stats)
- Created `layouts/partials/hero.html` reading all content from `.Params.hero` with `{{ with }}` guards
- Created `layouts/partials/section-heading.html` with dict interface for label, optional link/linkText
- Rebuilt `layouts/index.html` — removed all TailBliss P1/P2 sections, added hero partial and 3 placeholder sections (Latest Posts, Skill Patterns, Moments of Recognition) each with 920px max-width and 44px vertical padding
- Removed TailBliss `p1`–`p5` and `social_media` param blocks from `hugo.yaml`
- `pnpm run build` and `pnpm run test` both pass successfully
- Hero renders with correct font classes, stats with `·` separators, freshness placeholder guarded

### Post-Review Fixes (Follow-up Plan)

**Nav alignment & styling:**
- Changed nav `position: fixed` → `sticky top-0` (fixes overlap, nav takes space in normal flow)
- Changed nav bg: `bg-transparent` → `bg-[var(--surface)]` (matches page bg, aligns with mockup)
- Changed nav links font: `font-body` → `font-mono` (matches design spec Commit Mono)
- Logo: replaced "ndb" text with SVG (debarquin.svg) at 28px height (width/height HTML attrs + inline style + Tailwind triple-layer sizing for browser compatibility)

**Hero section refinements:**
- Changed `<section>` → `<header>` (semantic HTML for hero)
- Fixed padding: responsive `px-4 sm:px-6 md:px-8 py-8 md:py-11` → fixed `px-8 pt-[68px] pb-[52px]` (matches mockup spec)
- Changed stats separator color: `text-[var(--text-tertiary)]` → `text-[var(--border)]` (lighter gray per mockup)
- Added 1px divider after hero using `bg-[var(--border)]`

**Homepage sections:**
- Simplified padding: responsive `px-4 sm:px-6 md:px-8 py-8 md:py-11` → fixed `px-8 py-[44px]` per spec

**404 page restyle:**
- Removed TailBliss blue button styling
- Rebuilt with design tokens (font-mono label, font-heading title, border button, proper focus states)
- Centered layout with `min-height: calc(100vh - 54px)` (accounts for sticky nav height)

**Single page template (about, posts):**
- Removed TailBliss `bg-primary-600` purple banner from header
- Replaced with clean minimal header: `pt-[68px]` padding, design-token typography

**Additional files:**
- Updated `head.html` preload: `/images/site-logo.svg` → `/images/debarquin.svg`
- Added `static/images/debarquin.svg` (SVG logo file)

**Build validation:**
- All fixes tested; `pnpm run test` passes (Hugo 0.152.2)
- Note: SVG sizing requires triple-layer approach (HTML width/height attrs + inline style + Tailwind classes) due to Inkscape export complexity; cleanup deferred to UI polishing epic

### Change Log

- 2026-02-18: Implemented homepage hero & content structure (Story 2.3)
- 2026-02-18: Code review fixes — responsive breakpoints (px-4/sm:px-6/md:px-8, py-8/md:py-11), semantic h2 for section headings, focus states on links, aria-label on hero, hugo.yaml whitespace cleanup
- 2026-02-18: Post-review fixes (follow-up plan) — nav sticky positioning, hero element/padding/divider, 404 restyle, about page banner removal, SVG logo integration

### File List

- `content/_index.md` (new) — Homepage content with hero frontmatter
- `layouts/partials/hero.html` (new) — Hero section partial
- `layouts/partials/section-heading.html` (new) — Reusable section heading partial
- `layouts/index.html` (modified) — Replaced TailBliss content with hero + placeholder sections
- `hugo.yaml` (modified) — Removed TailBliss p1-p5 and social_media params
- `layouts/partials/nav.html` (modified) — Fixed sticky positioning, nav styling, SVG logo
- `layouts/partials/head.html` (modified) — Updated logo preload href
- `layouts/_default/single.html` (modified) — Removed TailBliss banner, minimal header
- `layouts/404.html` (modified) — Full restyle with design tokens, no blue colors
- `static/images/debarquin.svg` (new) — SVG logo file
