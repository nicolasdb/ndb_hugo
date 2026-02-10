# ndb Visual Charter — Design Tokens & Specification

**Date:** 2026-02-10  
**Status:** Phase 0 foundation locked  
**Token file:** `shared/tokens/design-tokens.css`

---

## Architecture

```
project-root/
├── shared/tokens/
│   └── design-tokens.css       ← THIS FILE (single source of truth)
├── portfolio/                   ← Hugo site
│   └── assets/css/main.css     ← @import '../../shared/tokens/design-tokens.css'
│                                  <html class="light">
├── backoffice/                  ← Svelte app
│   └── src/app.css             ← @import '../../shared/tokens/design-tokens.css'
│                                  <html class="dark">
```

**Theme is fixed, not toggled.**  
- Portfolio = `.light` always. Respect visitor OS preference for contrast, not for dark mode.  
- BackOffice = `.dark` always. No toggle.  
- Two rooms in the same building. Same vocabulary, different density.

---

## Typography: "The Archivist"

### Font Stack

| Role | Font | Fallback | Usage |
|------|------|----------|-------|
| Heading | Literata | Georgia, Times New Roman, serif | Titles, article headings, names, anagnorisis quotes |
| Body | Hanken Grotesk | system-ui, sans-serif | Paragraphs, descriptions, UI labels |
| Mono | Commit Mono | JetBrains Mono, Fira Code, monospace | Metadata, timestamps, code, section labels, stats |

### Why This Pairing

- **Literata** — designed for Google Books. Optimized for sustained reading, warm serifs, optical sizing (shifts character between 7pt and 72pt). Quiet authority without stuffiness.
- **Hanken Grotesk** — geometric but friendly. Holds up at small sizes in dark dense UI. Good x-height for metadata readability.
- **Commit Mono** — even character width for alignment. Terminal feel grounding the BackOffice in tool-oriented identity.

### Type Roles (How Fonts Map to UI)

| Element | Font | Example |
|---------|------|---------|
| Hero name | Heading, 700 | "Nicolas de Barquin" |
| Article title | Heading, 700 | "From Confusion to Contribution" |
| Pattern card title | Heading, 700 | "Container Orchestration" |
| Anagnorisis quote | Heading, 400, italic | "The teaching didn't follow the learning..." |
| Article excerpt | Body, 400 | Paragraph text |
| UI labels | Body, 400–600 | Nav items, descriptions |
| Section label | Mono, 400, uppercase | "LATEST POSTS", "SKILL PATTERNS" |
| Stats & meta | Mono, 400 | "847 pearls · 12 projects" |
| Timestamps | Mono, 400 | "3h ago", "January 2025" |
| Code blocks | Mono, 400 | `ai_labels: ["docker"]` |
| Confidence values | Mono, 500 | "87%" |
| Freshness heartbeat | Mono, 400 | "last pearl captured 3h ago" |
| Footer trust line | Mono, 400 | "Patterns are extracted from documented work..." |
| Nav logo | Heading, 500 | "ndb" |

### Type Scale — Dual Density

**Portfolio (light, generous):**

| Token | Size | Use |
|-------|------|-----|
| `--text-display` | 40px | Hero name |
| `--text-h1` | 28px | Page titles |
| `--text-h2` | 22px | Section titles |
| `--text-h3` | 20px | Article titles in lists |
| `--text-h4` | 17px | Pattern card titles |
| `--text-body` | 15px | Article text, descriptions |
| `--text-small` | 13px | Secondary body, card descriptions |
| `--text-meta` | 12px | Mono metadata |
| `--text-micro` | 11px | Timestamps, quiet stats |
| `--text-nano` | 10px | Uppercase section labels |

**BackOffice (dark, compact):**

| Token | Size | Use |
|-------|------|-----|
| `--text-display` | 28px | Mode headers |
| `--text-h1` | 22px | Section titles |
| `--text-h2` | 18px | Panel titles |
| `--text-h3` | 16px | Card titles |
| `--text-h4` | 14px | Sub-headers |
| `--text-body` | 14px | Primary UI text |
| `--text-small` | 13px | Pearl titles |
| `--text-meta` | 12px | Mono metadata |
| `--text-micro` | 11px | Labels, timestamps |
| `--text-nano` | 10px | Uppercase micro-labels |

### Line Width

- Body text: `65ch` max (portfolio), `80ch` max (backoffice)
- Hero description: `54ch`
- Never full-width text. Always constrained.

---

## Color System (OKLCH)

### Semantic Colors — The Pearl System

These colors have *meaning*, not just aesthetics. They represent the knowledge system.

| Token | OKLCH (dark) | OKLCH (light) | Meaning |
|-------|-------------|---------------|---------|
| `--pearl` | `0.95 0.02 90` | `0.35 0.04 90` | Knowledge pearl — raw data, neutral |
| `--convergence` | `0.75 0.15 75` | `0.52 0.14 75` | Convergence — old idea meets new work (amber) |
| `--pattern` | `0.65 0.25 25` | `0.48 0.18 25` | Extracted skill pattern (coral/red) |
| `--temporal` | `0.70 0.12 240` | `0.48 0.10 240` | Time markers — dates, timeline (blue) |
| `--frontier` | `0.40 0.01 260` | `0.75 0.01 260` | Unexplored, quiet tertiary, fog of war (gray) |
| `--fresh` | `0.75 0.18 145` | `0.42 0.14 145` | Fresh capture, strong signal (green) |

### Surface & Text Colors

| Token | Light | Dark |
|-------|-------|------|
| `--surface` | `0.97 0.005 260` | `0.15 0.02 260` |
| `--surface-elevated` | `1.0 0 0` (white) | `0.20 0.02 260` |
| `--text-primary` | `0.15 0.02 260` | `0.93 0.01 260` |
| `--text-secondary` | `0.45 0.02 260` | `0.65 0.02 260` |
| `--text-tertiary` | `0.60 0.015 260` | `0.40 0.01 260` |
| `--border` | `0.90 0.005 260` | `0.25 0.02 260` |
| `--border-subtle` | `0.93 0.005 260` | `0.22 0.02 260` |

### Confidence Color Thresholds

| Range | Token | Semantic |
|-------|-------|----------|
| 85%+ | `--fresh` (green) | Strong pattern, well-evidenced |
| 70–84% | `--convergence` (amber) | Solid, growing |
| <70% | `--temporal` (blue) | Emerging, needs more evidence |

### Design Rules for Color

- **No gradients.** Flat colors only.
- **No shadows.** Border-only elevation (surface vs. surface-elevated).
- **No decoration.** Color is information, not ornamentation.
- Semantic colors appear in dots, bars, accents, and text highlights — never as backgrounds on large areas.

---

## Spacing

### Base Unit: 4px

| Token | Value | Primary use |
|-------|-------|-------------|
| `--space-1` | 4px | Micro gaps (e.g. between dot and label) |
| `--space-2` | 8px | Inline spacing, meta separators |
| `--space-3` | 12px | Tight component padding |
| `--space-4` | 16px | Standard component padding |
| `--space-5` | 20px | Card padding (backoffice) |
| `--space-6` | 24px | Card padding (portfolio), section gaps |
| `--space-8` | 32px | Page horizontal padding, section breaks |
| `--space-10` | 40px | Section vertical padding |
| `--space-12` | 48px | Major section spacing |
| `--space-16` | 64px | Hero top padding |
| `--space-20` | 80px | Page-level breathing room |

### Density Comparison

| Property | Portfolio | BackOffice |
|----------|-----------|------------|
| Page max-width | 920px | 100% (full screen) |
| Page padding-x | 32px | 16px |
| Section padding-y | ~44px | 20px |
| Card padding | 24px | 20px |
| Card gap | 16px | 12px |
| List item gap | 24px | 8px |

---

## Borders & Radii

| Token | Value | Use |
|-------|-------|-----|
| `--radius-sm` | 2px | Code blocks, inputs |
| `--radius-md` | 3px | Cards, panels |
| `--radius-lg` | 4px | Elevated containers (max for rectangular elements) |
| `--radius-full` | 9999px | Dots, nodes, status indicators only |

**Rule:** No rounded corners on large containers. Maximum `4px` for cards. `radius-full` reserved for circular elements (pearl dots, timeline nodes).

---

## Component Inventory (Phase 0)

### Portfolio Components

| Component | Description | Key tokens |
|-----------|-------------|------------|
| **Nav** | Sticky, 54px height, blurs on scroll, "ndb" logo left, links right | `--nav-height`, `--nav-blur` |
| **Hero** | Name (display heading), description (body), stats (mono), freshness heartbeat (mono, frontier) | `--text-display`, `--font-heading` |
| **Post list item** | Title (h3 heading), date (mono right-aligned), excerpt (body), meta row (mono: readTime · pearlCount · tags) | Pearl count in `--convergence` |
| **Pattern card** | 2-col grid, mini constellation SVG (72×44), title (h4 heading), meta (mono), description (small body), confidence bar | `--pattern-graph-*` |
| **Timeline** | Vertical SVG spine, year markers (ring nodes, `--temporal`), moment dots (colored), italic quotes (heading font) | `--timeline-*` |
| **Section heading** | Mono, uppercase, nano size, with optional "see all →" link right-aligned | `.section-label` |
| **Confidence bar** | 3px height, color by threshold, mono percentage | `--confidence-*` |
| **Footer** | Name + location left, links right, trust line below (mono, frontier) | |

### BackOffice Components (to be designed)

| Component | Description | Status |
|-----------|-------------|--------|
| **Context bar** | Top bar: pearl count, project count, freshness | Sketched in typography explorer |
| **Mode tabs** | CAPTURE / EXPLORE / COMPOSE / PUBLISH | Sketched |
| **Capture input** | Text area with rotating nudge prompts | Sketched |
| **Pearl list** | Recent pearls with dot + title + timestamp | Sketched |
| **Confidence indicator** | Same as portfolio but horizontal in context | Sketched |
| **Graph query input** | NL query bar, italic, temporal color | Sketched |
| **Slim nav** | Left-side icon strip, expands on hover | Specified only |

---

## Implementation Notes

### Hugo (Portfolio)

```css
/* portfolio/assets/css/main.css */
@import '../../shared/tokens/design-tokens.css';

/* TailBliss already uses @theme directive — 
   replace its generic color tokens with pearl system tokens.
   One-file change for Phase 0. */
```

```html
<!-- layouts/baseof.html -->
<html class="light">
```

### Svelte (BackOffice)

```css
/* backoffice/src/app.css */
@import '../../shared/tokens/design-tokens.css';
```

```html
<!-- app.html -->
<html class="dark">
```

### Tailwind Integration

For Tailwind utility classes, extend the config to reference CSS custom properties:

```javascript
// tailwind.config.js (both apps)
module.exports = {
  theme: {
    extend: {
      colors: {
        surface: 'var(--surface)',
        elevated: 'var(--surface-elevated)',
        pearl: 'var(--pearl)',
        convergence: 'var(--convergence)',
        pattern: 'var(--pattern)',
        temporal: 'var(--temporal)',
        frontier: 'var(--frontier)',
        fresh: 'var(--fresh)',
      },
      fontFamily: {
        heading: 'var(--font-heading)',
        body: 'var(--font-body)',
        mono: 'var(--font-mono)',
      },
    },
  },
};
```

---

## Design Principles (Reference)

Summarized from the UX specification. These constrain future design decisions.

1. **No animation.** Snappy, reactive. Animation is the first thing to disable.
2. **No dark mode toggle** on portfolio. No light mode toggle on backoffice. Fixed.
3. **No gradients, no shadows, no decoration.** Color is information.
4. **Typography-forward.** The writing IS the showcase.
5. **Progressive disclosure.** Show what's needed, when it's needed.
6. **No gamification.** Narrative momentum through reflection, not badges.
7. **Confidence as social contract.** Always show evidence density, never self-assessment.
8. **Freshness as trust signal.** "last pearl captured 3h ago" — heartbeat, not badge.
9. **Anti-over-engineering.** Build components as needed. Three similar implementations before abstracting.
10. **Two rooms, one building.** Same vocabulary (tokens), different density (scale), different mood (theme).

---

## Decisions Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-02-10 | Typography: "The Archivist" (Literata + Hanken Grotesk + Commit Mono) | Library warmth, reading-optimized, quiet authority. Fits "de Barquin" identity — established without stuffy. |
| 2026-02-10 | OKLCH color space | Perceptually uniform. Already in Hugo TailBliss 4.1. |
| 2026-02-10 | Homepage: 3 posts + 4 patterns + 10 anagnorisis moments | Tasting menu, not buffet. Each section hooks to deeper page. |
| 2026-02-10 | Timeline = anagnorisis moments, not events | Recognition moments trigger more curiosity than accomplishment lists. |
| 2026-02-10 | Freshness heartbeat | Single line: "last pearl captured 3h ago". Trust signal + self-incentive. |
| 2026-02-10 | No hover tooltips for meta | Invisible by default breaks progressive disclosure. Inline always. |
| 2026-02-10 | BackOffice: `featured_on_homepage` flag on moments | User curates which 10 appear. Editorial choice, not auto-generated. |
