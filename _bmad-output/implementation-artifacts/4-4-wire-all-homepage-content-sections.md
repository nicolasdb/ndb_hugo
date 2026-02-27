# Story 4.4: Wire All Homepage Content Sections

Status: ready-for-dev

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

- [ ] Wire "Latest Posts" section in `layouts/index.html` (AC: 1, 4)
  - [ ] Replace `<!-- Wired in Story 4.4 -->` comment with real query
  - [ ] Use `site.RegularPages` scoped to `posts` section, limit to 3
  - [ ] Render each with `post-list-item.html` partial
  - [ ] Section heading already uses `section-heading.html` partial (verify dict context)

- [ ] Wire "Skill Patterns" section in `layouts/index.html` (AC: 2, 4)
  - [ ] Query patterns where `featuredOnHomepage = true`, limit to 4
  - [ ] Render each with `pattern-card.html` partial (dict context: `"pattern"` + `"index"`)
  - [ ] Responsive 2-col grid on md+

- [ ] Wire "Moments of Recognition" section in `layouts/index.html` (AC: 3, 4)
  - [ ] Query timeline sorted by date desc, limit to 10
  - [ ] Optionally filter by `featuredOnHomepage = true` if content has this field set
  - [ ] Render each with `timeline-moment.html` partial

- [ ] Add graceful empty states (AC: 5)
  - [ ] Posts: if no posts, show nothing (empty section hides)
  - [ ] Patterns: if no featured patterns, fall back to showing any 4 patterns
  - [ ] Timeline: if no timeline moments, show nothing

- [ ] Verify responsiveness (AC: 6)
  - [ ] Pattern grid: 1-col on mobile, 2-col on md+
  - [ ] Posts list: full-width, no grid needed
  - [ ] Timeline: full-width vertical list

- [ ] Run `pnpm run test` (AC: 7)

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

*Recommended: claude-haiku-4-5-20251001 — structured wiring work with clear Hugo query patterns*

### Debug Log References

### Completion Notes List

### File List
