# Story 3.4: Build Post List & Post Detail Pages

Status: ready-for-dev

## Story

As a **portfolio visitor**,
I want to browse a list of posts and read individual posts with their full block context,
So that I can explore Nicolas's knowledge-backed content.

## Acceptance Criteria

1. `layouts/partials/post-list-item.html` renders a post card with title, date, description, and block-meta (if present)
2. `layouts/posts/list.html` displays paginated post list using the `post-list-item.html` partial
3. `layouts/posts/single.html` renders full post content with block-meta, confidence-bar, and evidence-trail
4. The post detail page uses `block-meta.html` partial (not inline guards)
5. Posts without block fields render cleanly as standard blog posts (no empty sections, no broken layout)
6. All layouts are responsive across `sm`/`md`/`lg` breakpoints
7. `pnpm run test` passes
8. **Visual validation:** render locally — post list shows both sample posts correctly; post detail with block fields shows block-meta + confidence bar + evidence trail; post detail without block fields renders as clean standard post

## Tasks / Subtasks

- [ ] Build `layouts/partials/post-list-item.html` (AC: 1, 5)
  - [ ] Accept context via dict: `(dict "post" .)`
  - [ ] Render title (heading font, h3 size), date (mono, tertiary), description (body font)
  - [ ] Call `block-meta.html` partial if any block field present
  - [ ] Border separator between items (consistent with `_default/list.html` pattern)
  - [ ] Title links to post permalink

- [ ] Build `layouts/posts/list.html` (AC: 2, 6)
  - [ ] Override `_default/list.html` for the posts section specifically
  - [ ] Use same outer wrapper and header spacing as `_default/list.html` (`max-w-[920px] px-8`, `pt-12 md:pt-[68px]`)
  - [ ] Render each post via `{{ partial "post-list-item.html" (dict "post" .) }}`
  - [ ] Include pagination partial at bottom

- [ ] Build `layouts/posts/single.html` (AC: 3, 4, 5, 6)
  - [ ] Override `_default/single.html` for posts specifically
  - [ ] Preserve EXACT header structure from `_default/single.html`: `pt-12 md:pt-[68px] pb-10 md:pb-[52px]`, h1, date+reading-time row, tags row
  - [ ] Add block-meta section below tags row: `{{ partial "block-meta.html" (dict "page" .) }}`
  - [ ] Add evidence-trail section after post content: `{{ partial "evidence-trail.html" (dict "page" .) }}`
  - [ ] Post content div unchanged: `pb-10 md:pb-[52px] prose font-body text-[17px] leading-[1.7]`
  - [ ] All block sections render nothing when fields absent (delegated to partials)

- [ ] Visual validation (AC: 8)
  - [ ] `pnpm run dev:watch`, navigate to `/posts/`
  - [ ] Verify both sample posts appear in list with correct title/date/description
  - [ ] Docker-journey post (has block fields): confirm block-meta appears in list item
  - [ ] Sewer-museum post (no block fields): confirm clean render, no gaps
  - [ ] Click docker-journey: verify post header preserved, block-meta below tags, evidence trail at bottom
  - [ ] Click sewer-museum: verify standard post layout, no block sections
  - [ ] Resize to mobile: verify responsive layout holds

- [ ] Build validation (AC: 7)
  - [ ] `pnpm run test` passes

## Dev Notes

### Mechanics-First: Extend, Don't Restyle

`_default/single.html` and `_default/list.html` are the **visual reference**. The posts-specific layouts extend them:

- `layouts/posts/list.html` = `_default/list.html` + `post-list-item.html` partial call instead of inline article markup
- `layouts/posts/single.html` = `_default/single.html` + block-meta partial after tags row + evidence-trail partial after content

**Do not change spacing, font sizes, or color choices from `_default/` templates.** Copy the exact Tailwind classes.

### Existing `_default/single.html` Structure (reference — copy faithfully)

```html
{{define "main"}}
<article class="mx-auto max-w-[920px] px-8">
  <header class="pt-12 md:pt-[68px] pb-10 md:pb-[52px]">
    <h1 class="font-heading text-[40px] font-bold tracking-[-0.02em] max-w-[18ch] leading-[1.2] text-[var(--text-primary)]">
      {{ .Title }}
    </h1>
    <div class="font-mono text-[12px] text-[var(--text-tertiary)] flex items-center gap-2 mt-4 flex-wrap">
      {{ with .Date }}<span>{{ .Format "January 2, 2006" }}</span>{{ end }}
      {{ with .ReadingTime }}<span>·</span><span>{{ . }} min read</span>{{ end }}
    </div>
    {{ with .Params.tags }}
    <div class="flex items-center gap-2 mt-3 flex-wrap">
      {{ range . }}
      <span class="font-mono text-[11px] text-[var(--text-tertiary)] border border-[var(--border)] px-2 py-0.5 rounded-[2px]">{{ . }}</span>
      {{ end }}
    </div>
    {{ end }}
    {{/* INSERT block-meta partial here */}}
  </header>
  ...content div...
  {{/* INSERT evidence-trail partial here (after content, before </article>) */}}
</article>
{{end}}
```

### `post-list-item.html` — Visual Pattern

Follow the inline article markup from `_default/list.html` but extract into partial:

```html
{{/* post-list-item.html — call: {{ partial "post-list-item.html" (dict "post" .) }} */}}
{{ $post := .post }}
<article class="py-4 md:py-[24px] border-t border-[var(--border)]">
  <div class="flex justify-between items-start gap-8">
    <div class="flex-1">
      <h2 class="font-heading text-[20px] font-bold text-[var(--text-primary)] leading-[1.3]">
        <a href="{{ $post.RelPermalink }}" class="hover:text-[var(--text-secondary)]">{{ $post.Title }}</a>
      </h2>
      {{ with $post.Description }}
      <p class="font-body text-[15px] leading-[1.7] text-[var(--text-secondary)] mt-2 max-w-[54ch]">{{ . }}</p>
      {{ end }}
      <div class="font-mono text-[12px] text-[var(--text-tertiary)] flex items-center gap-2 mt-2 flex-wrap">
        {{ with $post.ReadingTime }}<span>{{ . }} min</span>{{ end }}
        {{ with $post.Params.tags }}
          <span>·</span>
          {{ range $i, $t := . }}{{ if $i }}, {{ end }}{{ $t }}{{ end }}
        {{ end }}
      </div>
      {{/* block-meta inline — compact view for list */}}
      {{ partial "block-meta.html" (dict "page" $post) }}
    </div>
    {{ with $post.Date }}
    <span class="font-body text-[14px] text-[var(--text-tertiary)] whitespace-nowrap hidden sm:block">{{ .Format "January 2006" }}</span>
    {{ end }}
  </div>
</article>
```

### Hugo Layout Lookup Order

Hugo will use `layouts/posts/list.html` over `layouts/_default/list.html` for the `/posts/` section. Same for `single.html`. This is standard Hugo section-specific override — no configuration needed.

### Pagination

Reuse the existing `layouts/partials/pagination.html` (already exists from prior epics). Same call as `_default/list.html`:
```
<div class="py-8 md:py-[44px]">
  {{ partial "pagination" . }}
</div>
```

### Architecture Compliance

- [Source: epics.md §Additional Requirements — D1.1] — `block-meta.html` as shared partial (not inline guards in templates)
- [Source: epics.md §Additional Requirements — D1.1] — naming: kebab-case partials
- [Source: epics.md §Additional Requirements — D2.2] — responsive breakpoints: mobile-first, Tailwind defaults
- [Source: epics.md §Additional Requirements — D2.2] — post content max-width: 700px (note: existing single.html uses 920px for article — post content prose area should use narrower measure per spec)

### Note on Content Width

DESIGN-SPEC §6 and architecture D2.2 specify post content max-width at 700px while the article wrapper is 920px. The existing `_default/single.html` uses `max-w-[920px]` for the article wrapper (correct), but the prose content div should use `max-w-[700px]` or equivalent ch measure. Check whether the current `prose` div in `_default/single.html` constrains prose width — if not, add `max-w-[65ch]` to the content div in `layouts/posts/single.html`.

### Visual Validation Checklist

Before marking done:
- [ ] `/posts/` list: both posts render, separated by border, title links work
- [ ] List item with block fields: compact block-meta appears below description
- [ ] List item without block fields: no block-meta section, no gaps
- [ ] Post detail (with blocks): header preserved, block-meta below tags, evidence trail after content
- [ ] Post detail (no blocks): clean standard post, no empty sections
- [ ] Mobile (`sm`): date hidden, content readable, evidence trail collapsible
- [ ] No visual regressions vs. 2.6 shell (nav, footer, spacing unchanged)

### Project Structure Notes

**New files this story:**
```
layouts/
  partials/
    post-list-item.html    ← NEW
  posts/
    list.html              ← NEW (section-specific override)
    single.html            ← NEW (section-specific override)
```

**Files read but NOT modified:**
```
layouts/_default/single.html    ← reference only
layouts/_default/list.html      ← reference only
```

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 3.4 AC]
- [Source: _bmad-output/planning-artifacts/architecture.md — D1.1 partial interfaces, D2.2 responsive breakpoints]
- [Source: layouts/_default/single.html — exact spacing classes to preserve]
- [Source: layouts/_default/list.html — exact article markup to extract into partial]
- [Source: _bmad-output/implementation-artifacts/3-2-build-block-meta-confidence-partials.md — partial interface contracts]
- [Source: _bmad-output/implementation-artifacts/3-3-build-evidence-trail-partial.md — partial interface contract]

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

### Completion Notes List

### File List
