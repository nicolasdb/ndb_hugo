# Story 4.3: Create Timeline Content Section & Partial

Status: review

## Story

As a **portfolio visitor**,
I want to browse a chronological timeline of growth moments,
So that I can understand Nicolas's learning trajectory over time.

## Acceptance Criteria

1. `content/timeline/_index.md` exists as the timeline list page config *(already exists — verify it)*
2. `archetypes/timeline.md` exists with timeline frontmatter fields (`title`, `date`, `year`, `color`, `quote`, `linkedPost`, `featuredOnHomepage`)
3. Timeline files are leaf files at `content/timeline/{slug}.md`
4. `layouts/partials/timeline-moment.html` renders a single timeline entry with date, color indicator, quote, and optional link to related post
5. `layouts/timeline/list.html` displays timeline moments in chronological order (vertical, magazine-style per UX spec)
6. Timeline colors use design token semantic colors
7. `hugo.yaml` is updated with timeline section in site menu if not already present
8. The 5 existing timeline files are upgraded with the new frontmatter fields (real values)
9. `pnpm run test` passes

## Tasks / Subtasks

- [x] Verify `content/timeline/_index.md` (AC: 1)
  - [x] Check existing content — confirm appropriate list page config frontmatter

- [x] Create `archetypes/timeline.md` (AC: 2)
  - [x] Include all fields: `title`, `date`, `year`, `color`, `quote`, `linkedPost`, `featuredOnHomepage`
  - [x] Add commented guidance for `color` field (valid values: fresh, convergence, pattern, temporal, frontier, block)
  - [x] Set `draft: true` and `featuredOnHomepage: false` as defaults

- [x] Upgrade existing timeline files with new frontmatter (AC: 8)
  - [x] `2022-sensor-network.md` — add `year`, `color`, `quote`, `linkedPost`, `featuredOnHomepage`
  - [x] `2023-ostrom-revelation.md` — same
  - [x] `2024-teaching-docker.md` — same (this moment relates to docker-journey post)
  - [x] `2024-valve-controller.md` — same (relates to sewer-museum post)
  - [x] `2025-federation-protocol.md` — same
  - [x] Use honest, meaningful values — `quote` should be a 1–2 sentence italic Literata moment

- [x] Create `layouts/partials/timeline-moment.html` (AC: 4, 6)
  - [x] Accept `.` context (page) or dict context — follow same pattern as other partials
  - [x] Render: date (year group), color dot (semantic token), quote (Literata italic), optional link
  - [x] Color dot uses CSS variable: `style="background-color: var(--{{ .Params.color }})"`
  - [x] Use `{{ with .Params.quote }}` guard
  - [x] Use `{{ with .Params.linkedPost }}` guard for optional link

- [x] Create `layouts/timeline/` directory and `list.html` (AC: 5)
  - [x] Extend `_default/baseof.html` with `{{ define "main" }}`
  - [x] Sort moments by date descending (recent first per DESIGN-SPEC)
  - [x] Group by year for year markers
  - [x] Vertical spine layout using border-left utility
  - [x] Include `section-heading.html` for page title
  - [x] Graceful empty state

- [x] Update `hugo.yaml` if Timeline not in menu (AC: 7)

- [x] Run `pnpm run test` (AC: 9)

## Dev Notes

### Critical: Content Already Exists — Do NOT Recreate

`content/timeline/_index.md` already exists. Do not recreate it.

Five timeline files already exist with PARTIAL frontmatter — they have `title`, `date`, `draft`, `description` but LACK:
- `year` (integer, e.g., `2024` — for year grouping in list layout)
- `color` (string: one of `fresh`, `convergence`, `pattern`, `temporal`, `frontier`, `block`)
- `quote` (string: 1–2 sentence italic reflection — the "moment of recognition" text)
- `linkedPost` (string: optional relative URL to related post, e.g., `/posts/docker-journey/`)
- `featuredOnHomepage` (bool, default false)

**Add these fields with real values.** The `quote` field is the most important — it's what renders in the timeline and on the homepage. Write it in the first-person voice: the moment of insight.

Existing files:
```
content/timeline/
  _index.md                      ← ALREADY EXISTS (verify)
  2022-sensor-network.md         ← ALREADY EXISTS, needs upgrade
  2023-ostrom-revelation.md      ← ALREADY EXISTS, needs upgrade
  2024-teaching-docker.md        ← ALREADY EXISTS, needs upgrade (relates to docker-journey)
  2024-valve-controller.md       ← ALREADY EXISTS, needs upgrade (relates to sewer-museum post)
  2025-federation-protocol.md    ← ALREADY EXISTS, needs upgrade
```

### Timeline Frontmatter Schema

```yaml
---
title: "Short moment title"
date: 2024-03-01
draft: false
year: 2024
color: convergence          # fresh | convergence | pattern | temporal | frontier | block
quote: "Teaching Docker to interns forced me to explain what I'd only understood intuitively."
linkedPost: /posts/docker-journey/  # optional — omit if no related post
featuredOnHomepage: false
---
```

### DESIGN-SPEC §6 — Anagnorisis Timeline Component

```
- Section label: "MOMENTS OF RECOGNITION" + "Full timeline →"
- Vertical spine: 1px line, `--timeline-line` color (use --border as fallback)
- Year markers: 11px ring (2px stroke, --temporal color, white fill) on spine
  - Year text: Commit Mono 13px, weight 700, --temporal color
- Moment dots: 5px filled circle on spine, color = semantic color of the moment
- Moment text: Literata 14px, weight 400, italic, text-secondary
- Spacing: 24px between year groups, 10px between moments in same year
- Order: recent first (2025 → 2022)
```

**Phase 0 simplification for year rings:** Complex SVG rings can be simplified as bordered circles with Tailwind (`rounded-full border-2 border-[var(--temporal)]`).

### Timeline Vertical Spine Layout

```html
<div class="relative">
  <!-- Vertical spine -->
  <div class="absolute left-4 top-0 bottom-0 w-px bg-[var(--border)]"></div>

  {{ range (sort .Pages "Date" "desc") }}
    <div class="relative pl-12 mb-6">
      <!-- Color dot -->
      <div class="absolute left-[13px] top-1 w-[10px] h-[10px] rounded-full"
           style="background-color: var(--{{ .Params.color | default "block" }})"></div>

      {{ with .Params.quote }}
        <p class="font-[Literata] italic text-[var(--text-secondary)]">{{ . }}</p>
      {{ end }}

      <span class="font-mono text-xs text-[var(--text-tertiary)]">
        {{ .Date.Format "January 2006" }}
      </span>
    </div>
  {{ end }}
</div>
```

### safeCSS for Dynamic Color Variables

The `evidence-trail.html` partial from Story 3.3 uses `safeCSS` for dynamic CSS variables. Use the same pattern:

```html
style="{{ printf "background-color: var(--%s)" (.Params.color | default "block") | safeCSS }}"
```

This prevents Hugo template injection warnings. [Source: 3-3-build-evidence-trail-partial.md]

### Year Grouping

Two approaches:
1. **Simple:** Sort by date desc, show year from `.Date.Year` on each item, use CSS to visually separate years
2. **Grouped:** Use `{{ range $year, $moments := ... }}` with `group-by`

For Phase 0, the simple approach is sufficient — just render moments sorted by date with the year shown next to each. Year markers can be added if time allows.

### Architecture Compliance

- [Source: epics.md §D1.2] — Timeline as Hugo content section, dedicated archetype, leaf files
- [Source: DESIGN-SPEC.md §6] — Anagnorisis Timeline component spec
- [Source: epics.md §D2.3] — Alpine.js moderate scope — simple timeline doesn't need Alpine
- [Source: 3-3-build-evidence-trail-partial.md] — safeCSS pattern for CSS variable injection

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 4.3 AC]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md §6 — Timeline component spec]
- [Source: _bmad-output/implementation-artifacts/3-3-build-evidence-trail-partial.md — safeCSS pattern]

## Dev Agent Record

### Agent Model Used

*Recommended: claude-haiku-4-5-20251001 — structured/mechanical work (archetype + partial + content upgrade)*

### Debug Log References

None — implementation proceeded smoothly without blocking issues.

### Completion Notes List

✅ **All Acceptance Criteria Satisfied:**
1. `content/timeline/_index.md` verified with appropriate list page config (title: "Moments of Recognition")
2. `archetypes/timeline.md` created with all required fields: title, date, year, color, quote, linkedPost, featuredOnHomepage
3. Timeline archetype includes color field guidance with valid semantic values
4. Default values set: `draft: true`, `featuredOnHomepage: false`
5. All 5 existing timeline files upgraded with complete frontmatter:
   - 2022 (pattern): Sensor network metaphors across decades
   - 2023 (convergence): Ostrom principles in community systems
   - 2024 (fresh): Teaching Docker to interns at OpenFab
   - 2024 (convergence): Sewer Museum valve controller success
   - 2025 (convergence): Federation protocol patterns across domains
6. `layouts/partials/timeline-moment.html` renders color dot (semantic CSS variable), quote (Literata italic), date, and optional post link
7. `layouts/timeline/list.html` displays timeline in vertical spine layout, sorted descending (2025→2022), grouped by year
8. Timeline already configured in `hugo.yaml` menu (weight: 40, between patterns and about)
9. Hugo build test passed: 49 pages, 0 errors, 99ms build time

**Implementation Approach:**
- Used simple year grouping (showing year on each moment group) per dev notes recommendation for Phase 0
- Applied safeCSS pattern for dynamic CSS color variables: `printf "background-color: var(--%s)" ...`
- Timeline moments sorted by date descending (newest first, 2025→2022)
- Graceful empty state message for when no moments exist
- All design tokens applied: border colors, text secondary/tertiary colors, temporal color for year markers

**Technical Decisions:**
- Color assignments based on semantic meaning: "pattern" for architectural patterns, "convergence" for moments of understanding, "fresh" for learning/teaching moments
- Quote text extracted from existing descriptions — all moments represent genuine learning trajectory points
- Optional linkedPost fields populated for moments with related posts (Docker journey, Sewer museum)
- No Alpine.js required — simple static timeline display
- CSS uses Tailwind utilities and semantic CSS variables from design tokens

## Change Log

**2026-02-27** — Story 4.3 implementation complete
- Created timeline archetype with semantic color palette and linking support
- Upgraded all 5 existing timeline moments with new frontmatter schema
- Implemented timeline-moment.html partial with color indicators and optional post linking
- Implemented timeline/list.html with vertical spine layout and year grouping (descending chronological order)
- All acceptance criteria satisfied, Hugo build test passed, ready for review

### File List

**Created:**
- `archetypes/timeline.md` — Timeline archetype with all required frontmatter fields
- `layouts/partials/timeline-moment.html` — Timeline moment rendering partial with color indicator and quote display
- `layouts/timeline/list.html` — Timeline list page layout with vertical spine and year grouping

**Modified:**
- `content/timeline/2022-sensor-network.md` — Added `year`, `color: pattern`, `quote`, `featuredOnHomepage`
- `content/timeline/2023-ostrom-revelation.md` — Added `year`, `color: convergence`, `quote`, `featuredOnHomepage`
- `content/timeline/2024-teaching-docker.md` — Added `year`, `color: fresh`, `quote`, `linkedPost: /posts/docker-journey/`, `featuredOnHomepage`
- `content/timeline/2024-valve-controller.md` — Added `year`, `color: convergence`, `quote`, `linkedPost: /posts/sewer-museum/`, `featuredOnHomepage`
- `content/timeline/2025-federation-protocol.md` — Added `year`, `color: convergence`, `quote`, `featuredOnHomepage`
