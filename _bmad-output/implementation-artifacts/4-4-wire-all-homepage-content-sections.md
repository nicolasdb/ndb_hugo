# Story 4.4: Wire All Homepage Content Sections

Status: done

## Story

As a **portfolio visitor**,
I want to see latest posts, featured patterns, and recent timeline moments on the homepage,
So that the knowledge-first narrative is immediately visible when I land on the site.

## Acceptance Criteria

1. The homepage queries and displays the 3 most recent posts using `post-list-item.html` partial
2. The homepage queries and displays up to 4 featured patterns (using `where .Params.featuredOnHomepage true` or similar) using `pattern-card.html` partial
3. The homepage queries and displays up to 10 recent timeline moments using `timeline-moment.html` partial
4. Each section uses the `section-heading.html` partial for its label
5. Sections render gracefully when no content exists yet (empty state, no errors)
6. The homepage is responsive across `sm`/`md`/`lg` breakpoints
7. `pnpm run test` passes

## Tasks / Subtasks

- [x] Wire "Latest Posts" section in `layouts/index.html` (AC: 1, 4)
  - [x] Replace `<!-- Wired in Story 4.4 -->` comment with real query
  - [x] Use `site.RegularPages` scoped to `posts` section, limit to 3
  - [x] Render each with `post-list-item.html` partial
  - [x] Section heading already uses `section-heading.html` partial (verify dict context)

- [x] Wire "Skill Patterns" section in `layouts/index.html` (AC: 2, 4)
  - [x] Query patterns where `featuredOnHomepage = true`, limit to 4
  - [x] Render each with `pattern-card.html` partial (dict context: `"pattern"` + `"index"`)
  - [x] Responsive 2-col grid on md+

- [x] Wire "Moments of Recognition" section in `layouts/index.html` (AC: 3, 4)
  - [x] Query timeline sorted by date desc, limit to 10
  - [x] Optionally filter by `featuredOnHomepage = true` if content has this field set
  - [x] Render each with `timeline-moment.html` partial

- [x] Add graceful empty states (AC: 5)
  - [x] Posts: if no posts, show nothing (empty section hides)
  - [x] Patterns: if no featured patterns, fall back to showing any 4 patterns
  - [x] Timeline: if no timeline moments, show nothing

- [x] Verify responsiveness (AC: 6)
  - [x] Pattern grid: 1-col on mobile, 2-col on md+
  - [x] Posts list: full-width, no grid needed
  - [x] Timeline: full-width vertical list

- [x] Run `pnpm run test` (AC: 7)

## Dev Notes

### Current State of `layouts/index.html`

The homepage layout already has the section scaffolding with placeholder comments. This story REPLACES those comments with real queries. The section structure and `section-heading.html` partials are already in place.

```html
<!-- CURRENT STATE (from Story 2.3): -->
<section class="mx-auto max-w-[920px] px-8 py-8 md:py-[44px]">
    {{ partial "section-heading.html" (dict "label" "LATEST POSTS" "link" "/posts/" "linkText" "All posts →") }}
    <!-- Wired in Story 4.4 -->
</section>

<section class="mx-auto max-w-[920px] px-8 py-8 md:py-[44px]">
    {{ partial "section-heading.html" (dict "label" "SKILL PATTERNS" "link" "/patterns/" "linkText" "All patterns →") }}
    <!-- Wired in Story 4.4 -->
</section>

<section class="mx-auto max-w-[920px] px-8 py-8 md:py-[44px]">
    {{ partial "section-heading.html" (dict "label" "MOMENTS OF RECOGNITION") }}
    <!-- Wired in Story 4.4 -->
</section>
```

**Only replace the `<!-- Wired in Story 4.4 -->` comments.** Do not touch the section wrappers, class names, or `section-heading.html` calls — those are already correct per DESIGN-SPEC.

### Hugo Queries

**Latest Posts (3 most recent):**
```html
{{ $posts := where site.RegularPages "Section" "posts" }}
{{ $posts = $posts | first 3 }}
{{ range $posts }}
  {{ partial "post-list-item.html" . }}
{{ end }}
```

**Featured Patterns (up to 4):**
```html
{{ $patterns := where site.RegularPages "Section" "patterns" }}
{{ $featured := where $patterns "Params.featuredOnHomepage" true }}
{{ if not $featured }}
  {{ $featured = $patterns | first 4 }}
{{ end }}
{{ $featured = $featured | first 4 }}
{{ range $i, $pattern := $featured }}
  {{ partial "pattern-card.html" (dict "pattern" $pattern "index" $i) }}
{{ end }}
```

**Timeline Moments (up to 10, recent first):**
```html
{{ $moments := where site.RegularPages "Section" "timeline" }}
{{ $moments = $moments.ByDate.Reverse | first 10 }}
{{ range $moments }}
  {{ partial "timeline-moment.html" . }}
{{ end }}
```

### partial Interface Verification

Before writing the homepage queries, verify these partial interfaces from prior stories:

- `post-list-item.html` — called with `.` (page context) from Story 3.4
- `pattern-card.html` — called with dict `(dict "pattern" . "index" $i)` from Story 4.2
- `timeline-moment.html` — called with `.` (page context) from Story 4.3
- `section-heading.html` — dict context `(dict "label" "..." "link" "..." "linkText" "...")` from Story 2.3

Check the actual partial files to confirm interfaces before using — don't assume.

### Graceful Empty States

Hugo queries return empty slices when no content matches — this is safe to range over. Sections will render empty (just the section heading) when no content exists. This is acceptable for Phase 0 where we'll have sample content.

The key risk is the `featuredOnHomepage` filter — if NO patterns have this set to true, fall back to showing any patterns:

```html
{{ if not $featured }}{{ $featured = $patterns | first 4 }}{{ end }}
```

### DESIGN-SPEC §6 — Homepage Layout

```
§ Latest posts (3)         → All posts
§ Skill patterns (4)       → All patterns  [2×2 grid, cards with mini-graph + confidence]
§ Moments of recognition (10) → Full timeline  [vertical spine, year groups, colored dots, italic quotes]
```

The section dividers (1px `--border`) between sections are already in place from Story 2.3. Do not add more.

### Architecture Compliance

- [Source: epics.md §Party Mode Decisions Round 2] — Story 4.4 is the single homepage wiring story; layouts/index.html touched once
- [Source: DESIGN-SPEC.md §6 — Page: Home] — 3 posts, 4 patterns, 10 timeline moments
- [Source: epics.md §D2.2] — max-width 920px, mobile-first

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 4.4 AC]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md §6 — Homepage structure]
- [Source: layouts/index.html] — current placeholder structure to replace
- [Source: _bmad-output/implementation-artifacts/3-4-build-post-list-post-detail-pages.md] — post-list-item.html interface

## Dev Agent Record

### Agent Model Used

*Implemented by: claude-haiku-4-5-20251001 — structured wiring work with clear Hugo query patterns*

### Completion Notes

#### Latest Posts Section
- Implemented query: `{{ $posts := where site.RegularPages "Section" "posts" }}`
- **FIXED (Code Review)**: Added explicit date sort: `{{ $posts = sort $posts "Date" "desc" }}`
  - Ensures "most recent" constraint is enforced (not reliant on filesystem order)
  - Posts now guaranteed to show newest first
- Limits to 3 most recent posts via `| first 3`
- Renders each post with `post-list-item.html` partial using dict context: `(dict "post" .)`
- Currently displaying 2 posts (Docker Journey [Jan 15], Sewer Museum Valve Controller [Dec 10])

#### Skill Patterns Section
- Implemented smart fallback: filters to featured patterns (`where .Params.featuredOnHomepage true`)
- **FIXED (Code Review)**: Replaced unsafe `if not $featured` with `if eq (len $featured) 0`
  - Ensures empty slice is reliably detected (Hugo gotcha: `if not` unreliable on slices)
  - Fallback to all patterns guaranteed to work in all Hugo versions
- If no featured patterns exist, falls back to showing any patterns (allows graceful content ramp-up)
- Limits to 4 patterns via `| first 4`
- Renders each with `pattern-card.html` partial using dict context: `(dict "pattern" . "index" $i)`
- Currently displaying 2 featured patterns (Commons Governance, Electronics & IoT Prototyping)
- Responsive grid: `grid grid-cols-1 md:grid-cols-2 gap-5`

#### Moments of Recognition Section
- **FIXED (Code Review)**: Aligned query method with spec
  - Now uses: `{{ $moments := where site.RegularPages "Section" "timeline" }}`
  - Consistent with posts/patterns queries (was using `.Site.GetPage` variant)
  - Replaced unsafe `if not` with `if eq (len $featured) 0` for reliable empty checks
  - Also changed final condition from `{{ if $featured }}` to `{{ if gt (len $featured) 0 }}` for consistency
- Filters to featured moments if any exist (`where .Params.featuredOnHomepage true`)
- Falls back to all timeline moments if none are featured
- Limits to 10 moments via `| first 10` and sorts by date descending
- Renders with `timeline-moment.html` partial inside vertical spine structure
- Currently displaying 5 featured timeline moments

#### Empty State Handling
- Posts: Hugo's empty slice handling ensures no rendering if no posts exist
- Patterns: Fallback logic ensures some patterns always show (featured or all)
- Timeline: Only renders the spine structure if moments exist (nested `{{ if $featured }}`)

#### Responsiveness
- Pattern grid uses Tailwind's responsive classes: `grid-cols-1 md:grid-cols-2`
- Tested breakpoints: mobile (1-col), tablet/desktop (2-col)
- Posts and timeline remain full-width across all breakpoints

### File List

- `layouts/index.html` — Modified: Replaced 3 placeholder comments with functional queries for Posts, Patterns, and Timeline sections

## Change Log

- **2026-02-27**: Story 4.4 completed — Wired all homepage content sections with Posts, Patterns, and Timeline queries. Added graceful empty state handling with fallbacks for featured content. All AC satisfied, tests passing.
- **2026-02-27** (Code Review): Applied 3 critical fixes:
  1. **Posts**: Added explicit `sort $posts "Date" "desc"` to ensure chronological ordering (not filesystem order)
  2. **Patterns**: Replaced unsafe `if not $featured` with `if eq (len $featured) 0` for reliable empty slice detection
  3. **Timeline**: Aligned query to spec (`where site.RegularPages` method), replaced unsafe `if not` conditions with explicit length checks
  - Fixes ensure compliance with Hugo best practices, reliability across versions, and spec compliance
  - Tests pass (Hugo build: 49 pages, 0 errors)
