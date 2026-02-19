# Story 2.6: Visual polish — close mockup gap

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want the Hugo render to match the visual mockup's whitespace, density, and overall feel,
So that the portfolio shell feels "finished" and ready for content.

## Acceptance Criteria

1. **Home page visual alignment:** Hugo render matches mockup PNG screenshots for navigation, hero, sections, and footer
   - Navigation blur, spacing, link alignment match mockup
   - Hero padding and typography match mockup proportions
   - Section headings and spacing follow mockup rhythm
   - Footer layout, typography, and spacing align with spec

2. **Page consistency framework:** All other pages (posts, patterns, timeline, about, 404) derive visual patterns from home
   - Post detail layout uses home's spacing hierarchy
   - Pattern detail pages use home's card and heading patterns
   - Timeline page follows home's section structure
   - About page respects home's typography and padding
   - 404 page reflects home's visual language
   - No separate page-specific styling (visual consistency enforced through reusable partials and spacing utilities)

3. **Placeholder content strategy:** All pages populated with synthetic/meaningful placeholder content
   - Home hero: real bio text (not "Nicolas" placeholder)
   - Posts: sample posts with realistic content
   - Patterns: sample patterns with meaningful descriptions
   - Timeline: sample moments with dates and quotes
   - About: realistic about text
   - 404: helpful error messaging
   - Spacing proportions work with both sparse and full content

4. **Responsive verification:** All visual changes work across sm/md/lg breakpoints on every page
5. **Build passes:** `pnpm run test` executes without errors
6. **Visual regression captured:** Screenshots of all pages showing consistency

## Tasks / Subtasks

- [ ] **Home page visual audit**
  - [ ] Compare current render against mockup PNG files (7 screenshots provided)
  - [ ] Navigation: blur effect, padding, link spacing
  - [ ] Hero: section padding, typography sizing, bio text area
  - [ ] Sections: vertical breathing between posts/patterns/timeline
  - [ ] Footer: link layout, typography stack, location text
  - [ ] Identify spacing adjustments needed to match mockup

- [ ] **Home page adjustments**
  - [ ] Update hero content in `content/_index.md` (real bio text)
  - [ ] Audit and adjust Tailwind spacing classes throughout home layout
  - [ ] Update footer location text ("Ixelles, Brussels")
  - [ ] Verify link sets and typography hierarchy

- [ ] **Post detail page visual consistency**
  - [ ] Verify post-single.html uses home's spacing hierarchy
  - [ ] Post header/title spacing derives from home hero patterns
  - [ ] Content area breathing matches home section spacing
  - [ ] Pearl metadata, confidence bar, evidence trail use home's typography
  - [ ] Footer on post pages matches home footer styling

- [ ] **Pattern and Timeline page consistency**
  - [ ] Pattern list/detail pages use spacing patterns from home sections
  - [ ] Pattern cards follow home's heading and padding conventions
  - [ ] Timeline layout mirrors home's section structure (vertical rhythm)
  - [ ] Pattern detail pages use consistent typography hierarchy with home

- [ ] **About and 404 page styling**
  - [ ] About page respects home's typography and spacing (generous whitespace)
  - [ ] About content uses home's semantic HTML and section structure
  - [ ] 404 page reflects home's visual language (not default Hugo error page)
  - [ ] Both pages maintain responsive consistency with home across sm/md/lg

- [ ] **Synthetic placeholder content across all pages**
  - [ ] Home: hero bio, section headings, meaningful placeholders
  - [ ] Posts: 1-2 sample posts with realistic content (stored in content/posts/)
  - [ ] Patterns: 2-3 sample patterns with skill descriptions
  - [ ] Timeline: 3-5 sample moments with dates and quotes
  - [ ] About: realistic about text describing portfolio purpose
  - [ ] Content chosen to verify spacing works with both sparse and full pages

- [ ] **Responsive verification across all pages**
  - [ ] sm breakpoint: mobile layout proportions match intent
  - [ ] md breakpoint: tablet layout maintains spacing rhythm
  - [ ] lg breakpoint: desktop layout breathes correctly
  - [ ] Test on all 6+ pages (home, post detail, posts list, patterns, timeline, about, 404)

- [ ] **Regression verification**
  - [ ] Stories 2.1-2.4 functionality intact (nav blur, fonts, footer)
  - [ ] No layout breakage from spacing adjustments
  - [ ] All links work, images load, partials render

- [ ] **Build and visual capture**
  - [ ] Run `pnpm run test` for build validation
  - [ ] Run `pnpm run build` for production build check
  - [ ] Capture final screenshots of all pages
  - [ ] Store screenshots in `_bmad-output/implementation-artifacts/` with naming convention

## Dev Notes

### Visual Consistency Strategy

**The "home-derived design" principle:**

All pages must visually derive from the home page mockup. Specific mockup details were only designed for home (nav, hero, sections, footer). Other pages must follow the *visual patterns* established on home:

- **Navigation bar:** Same blur, spacing, typography on all pages
- **Section spacing:** Same vertical breathing (py-8/py-12 hierarchy) on all pages
- **Typography:** Same heading hierarchy, font stacks, sizing across all pages
- **Cards/content blocks:** Consistent padding (p-4/p-6) whether used for posts, patterns, or timeline
- **Footer:** Consistent layout and typography on all pages

**This ensures visual consistency without requiring separate mockups for every page type.**

### Mockup Reference Sources (Home page only)

| PNG File | Section | Focus |
|----------|---------|-------|
| 01_mockup_screencap_Home-Header-navbar.png | Navigation | Blur on scroll, link spacing, padding |
| 02_mockup_screencap_Home-posts.png | Posts section | List item density, description area, spacing |
| 03_mockup_screencap_Home-patterns.png | Patterns section | Card grid, padding, title sizing |
| 04_mockup_screencap_Home-timeline.png | Timeline section | Vertical rhythm, entry spacing, date styling |
| 05_mockup_screencap_Home-footer.png | Footer | Link layout, typography, padding |
| 06_mockup_screencap_Post-header-body.png | Post detail (reference) | Hero area, title, meta spacing patterns |
| 07_mockup_screencap_Post-body-footer.png | Post detail (reference) | Content area breathing, footer |

**Note:** Post detail screenshots (06, 07) are *reference* only — post layout should derive spacing patterns from home, not be detailed in mockup.

### Page Checklist: Spacing & Typography Consistency

All pages must follow this template consistency:

```
[Navbar] ← consistent with home mockup 01
[Page Title/Section] ← uses home's heading patterns
[Content Area] ← spacing derived from home sections
  - Generous whitespace (py-8 or py-12 between sections)
  - Typography hierarchy matches home (Literata/Hanken/Commit Mono)
  - Cards/lists use p-4/p-6 padding from home patterns
[Footer] ← consistent with home mockup 05
```

**Pages to verify:**
1. Home (`layouts/index.html`) — *SOURCE* of design patterns
2. Post list (`layouts/posts/list.html`) — derives spacing from home posts section
3. Post detail (`layouts/posts/single.html`) — derives hero/content spacing from home
4. Pattern list (`layouts/patterns/list.html`) — derives grid/spacing from home patterns section
5. Pattern detail (`layouts/patterns/single.html`) — consistent with pattern list
6. Timeline (`layouts/timeline/list.html`) — derives section spacing from home timeline section
7. About (`layouts/about.md` or single-page) — derives spacing, respects home typography
8. 404 (`layouts/404.html`) — derives layout from home, adds helpful messaging

### Architecture Compliance

- [Source: DESIGN-SPEC.md§5] — Whitespace and typography rhythm (apply to all pages)
- [Source: DESIGN-SPEC.md§6.2] — Navigation padding (consistent across all pages)
- [Source: DESIGN-SPEC.md§6.7] — Footer layout (consistent across all pages)
- [Source: CLAUDE.md] — Tailwind utilities only (no custom CSS)

### Tailwind Spacing Hierarchy (from Stories 2.1-2.4)

Use consistently across all pages:

```
Hero/title area: py-12 md:py-16 (substantial)
Main sections: py-8 md:py-12 (breathing room)
Section to section: gap-8 md:gap-12 (separation)
Card content: p-4 md:p-6 (internal padding)
Footer: py-8 md:py-10 (anchors bottom)
```

### Synthetic Placeholder Content Strategy

**Goal:** Demonstrate that spacing works with realistic content density, without requiring real content yet.

**Content to seed:**

| Page | Placeholder Content | Purpose |
|------|-------------------|---------|
| Home hero | Real 2-3 line bio | Show substantial hero area works |
| Home posts | 1-2 sample posts | Verify post list spacing with items |
| Home patterns | 2-3 sample patterns | Verify grid/card spacing |
| Home timeline | 3-5 sample moments | Verify timeline vertical rhythm |
| Post detail | One full sample post | Show post page spacing with content |
| Pattern detail | One full sample pattern | Show pattern detail layout |
| About | Realistic about text (2-3 paragraphs) | Show page spacing with body text |
| 404 | Helpful error messaging | Maintain brand voice in error state |

**All synthetic content is placeholder:** Real content seeding is Epic 5. This story just ensures spacing/layout works.

### Previous Story Intelligence

**Stories 2.1-2.4** established:
- Typography stack (Literata, Hanken Grotesk, Commit Mono) in place
- Navigation with blur-on-scroll working
- Hero partial created
- Footer with design tokens working
- Section heading partial created

This story builds on those patterns, ensuring consistency across the full site.

### Testing Strategy

1. **Visual rendering:**
   - Render locally: `pnpm run dev:watch`
   - Compare home against 7 mockup PNGs side-by-side
   - Verify spacing matches intent (generous, not cramped)

2. **Page consistency audit:**
   - Visually compare all 8 pages for consistent spacing/typography
   - Check responsive behavior at sm/md/lg breakpoints
   - Verify all links work, all partials render

3. **Build validation:**
   - `pnpm run test` (Hugo build check, all pages must render)
   - `pnpm run build` (production build)

4. **Screenshot capture:**
   - Home page (full, nav visible)
   - Post detail page (showing spacing with content)
   - Pattern page (showing card consistency)
   - Timeline page (showing vertical rhythm)
   - About page (showing body text spacing)
   - 404 page (showing error messaging)
   - Store in `_bmad-output/implementation-artifacts/` with timestamp

## Dev Agent Record

### Agent Model Used

Opus 4.6 (visual judgment, multi-page consistency, layout decisions)

### File List

**Files to modify:**
- `content/_index.md` (hero frontmatter, sample content)
- `layouts/partials/footer.html` (location text)
- `layouts/index.html` (spacing audit)
- `layouts/_default/single.html` (spacing consistency with home)
- `layouts/posts/single.html` (spacing consistency)
- `layouts/patterns/single.html` (spacing consistency)
- `layouts/timeline/list.html` (spacing consistency)
- `content/about.md` (realistic text, spacing test)
- `layouts/404.html` (visual consistency)
- Possible: sample content files in `content/posts/`, `content/patterns/`, `content/timeline/`

### Completion Notes

- [ ] Home page mockup visual alignment verified
- [ ] All other pages derive visual patterns from home
- [ ] Synthetic placeholder content seeded
- [ ] Responsive behavior verified across all pages
- [ ] Build passes, no regressions
- [ ] Screenshots captured and stored
- [ ] Epic 2 shell feels "finished" and consistent

