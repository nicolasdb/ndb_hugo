# Story 4.3: Create Timeline Content Section & Partial

Status: ready-for-dev

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

- [ ] Verify `content/timeline/_index.md` (AC: 1)
  - [ ] Check existing content — confirm appropriate list page config frontmatter

- [ ] Create `archetypes/timeline.md` (AC: 2)
  - [ ] Include all fields: `title`, `date`, `year`, `color`, `quote`, `linkedPost`, `featuredOnHomepage`
  - [ ] Add commented guidance for `color` field (valid values: fresh, convergence, pattern, temporal, frontier, block)
  - [ ] Set `draft: true` and `featuredOnHomepage: false` as defaults

- [ ] Upgrade existing timeline files with new frontmatter (AC: 8)
  - [ ] `2022-sensor-network.md` — add `year`, `color`, `quote`, `linkedPost`, `featuredOnHomepage`
  - [ ] `2023-ostrom-revelation.md` — same
  - [ ] `2024-teaching-docker.md` — same (this moment relates to docker-journey post)
  - [ ] `2024-valve-controller.md` — same (relates to sewer-museum post)
  - [ ] `2025-federation-protocol.md` — same
  - [ ] Use honest, meaningful values — `quote` should be a 1–2 sentence italic Literata moment

- [ ] Create `layouts/partials/timeline-moment.html` (AC: 4, 6)
  - [ ] Accept `.` context (page) or dict context — follow same pattern as other partials
  - [ ] Render: date (year group), color dot (semantic token), quote (Literata italic), optional link
  - [ ] Color dot uses CSS variable: `style="background-color: var(--{{ .Params.color }})"`
  - [ ] Use `{{ with .Params.quote }}` guard
  - [ ] Use `{{ with .Params.linkedPost }}` guard for optional link

- [ ] Create `layouts/timeline/` directory and `list.html` (AC: 5)
  - [ ] Extend `_default/baseof.html` with `{{ define "main" }}`
  - [ ] Sort moments by date descending (recent first per DESIGN-SPEC)
  - [ ] Group by year for year markers
  - [ ] Vertical spine layout using border-left utility
  - [ ] Include `section-heading.html` for page title
  - [ ] Graceful empty state

- [ ] Update `hugo.yaml` if Timeline not in menu (AC: 7)

- [ ] Run `pnpm run test` (AC: 9)

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

### Completion Notes List

### File List
