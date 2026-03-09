# Hugo Gotchas — ndb_hugo

**Created:** 2026-03-09 (Story 5.0)
**Purpose:** Document recurring Hugo template pitfalls discovered across Epics 1-4. Prevents rediscovery in each story.

---

## Slice Empty Check

**Problem:** `{{ if not $items }}` is unreliable for slices in Hugo. An empty slice `[]` evaluates as truthy in some contexts.

| Wrong | Correct |
|-------|---------|
| `{{ if not $items }}` | `{{ if eq (len $items) 0 }}` |
| `{{ if $pages }}` (unreliable) | `{{ if gt (len $pages) 0 }}` |

**Pattern:**
```go-html-template
{{ $items := slice }}
{{ if gt (len $items) 0 }}
  {{/* has items */}}
{{ else }}
  {{/* empty */}}
{{ end }}
```

**Source:** Confirmed in Stories 3.3, 4.3 — evidence trail and timeline moment rendering.

---

## Dynamic CSS Variables — Use `safeCSS`

**Problem:** Hugo escapes dynamic string values injected into `style=` attributes. Without `safeCSS`, CSS variable references like `var(--color)` get escaped and break.

| Wrong | Correct |
|-------|---------|
| `style="color: {{ $color }}"` | `{{ printf "color: %s" $color \| safeCSS }}` |
| `style="background-color: var(--{{ $name }})"` | `{{ printf "background-color: var(--%s)" $name \| safeCSS }}` |

**Pattern (from timeline-moment.html):**
```go-html-template
style="{{ printf "background-color: var(--%s)" (.Params.color | default "block") | safeCSS }}"
```

**Source:** Confirmed in Story 4.3 — timeline dot color rendering.

---

## Frontmatter Field Queries — Use `.Params.fieldName`

**Problem:** Hugo's `where` function requires `.Params.fieldName` to access frontmatter fields, not `.fieldName`.

| Wrong | Correct |
|-------|---------|
| `where .Pages ".featured" true` | `where .Pages ".Params.featured" true` |
| `where .Pages ".blockCount" ">" 0` | `where .Pages ".Params.blockCount" ">" 0` |

**Pattern:**
```go-html-template
{{ $featured := where .Site.RegularPages ".Params.featured_on_homepage" true }}
```

**Source:** Hugo documentation + confirmed in Story 4.4 — homepage section wiring.

---

## Date Sorting — Descending Requires Explicit Direction

**Problem:** Hugo's `sort` function sorts ascending by default. For date-ordered lists (newest first), the direction must be explicit.

| Wrong | Correct |
|-------|---------|
| `sort .Pages "Date"` | `sort .Pages "Date" "desc"` |

**Pattern:**
```go-html-template
{{ $posts := sort .Site.RegularPages "Date" "desc" }}
{{ range first 3 $posts }}
```

**Source:** Confirmed in Story 3.4, 4.4 — post list ordering.

---

## Page Weight for Manual Ordering

**Problem:** When using `weight` frontmatter for manual page ordering, Hugo sorts ascending (lower weight = first). For timeline moments sorted by date, use `.Date` not `.Weight`.

**Pattern (timeline — recent first):**
```go-html-template
{{ $moments := sort .Pages "Date" "desc" }}
```

**Pattern (patterns — manual weight order):**
```go-html-template
{{ $patterns := sort .Pages "Weight" "asc" }}
```

**Source:** Story 4.3, 4.4.

---

## Partial Context — Always Pass Explicit Dict

**Problem:** Hugo partials receive the full page context by default, which can cause variable shadowing and unexpected behavior when partials are called inside loops.

**Best practice:** Always pass an explicit dict to partials.

| Pattern | Usage |
|---------|-------|
| `{{ partial "foo.html" . }}` | Only when passing full page context is intentional |
| `{{ partial "foo.html" (dict "key" $value) }}` | Preferred — explicit, predictable |

**Pattern (confidence-bar.html):**
```go-html-template
{{ partial "confidence-bar.html" (dict "confidence" $pattern.Params.confidence) }}
```

**Source:** Confirmed as standard pattern across Stories 3.2, 4.2.

---

## `safeURL` for Dynamic Link Hrefs (Best Practice)

**Pattern:** When `href=` contains a dynamic value (especially from frontmatter), apply `safeURL` to prevent Hugo's security layer from escaping it.

```go-html-template
{{/* From user-provided frontmatter URL */}}
<a href="{{ .Params.linkedPost | safeURL }}">

{{/* Hugo-generated URLs are safe; safeURL is optional */}}
<a href="{{ .RelPermalink }}">{{/* Already safe */}}
```

**Example from ndb_hugo:**
- Timeline moments use `.Params.linkedPost` (user-provided) — should use `| safeURL`
- Pagination uses `.URL` (Hugo-generated) — doesn't need `safeURL`

**Source:** Hugo security model + Timeline moment implementation in Story 4.3 (potential improvement noted, not implemented).

---

## `scratch` / `newScratch` for Loop Accumulators

**Modern approach (Hugo 0.99+, current: 0.152.2):** Variable reassignment with `=` inside loops is now supported.

```go-html-template
{{ $count := 0 }}
{{ range .Pages }}
  {{ $count = add $count 1 }}  {{/* Now works in Hugo 0.99+ */}}
{{ end }}
{{ $count }}
```

**When to still use Scratch:** Only when sharing mutable state **across partial boundaries** (different scopes).

```go-html-template
{{ $scratch := newScratch }}
{{ $scratch.Set "total" 0 }}
{{ range .Site.RegularPages }}
  {{/* Inside partial, modify shared counter */}}
  {{ partial "count-blocks.html" (dict "scratch" $scratch) }}
{{ end }}
{{ $scratch.Get "total" }}
```

**Source:** Hugo documentation, less relevant for current version (this project uses Hugo 0.152.2).

---

## Build Test Command

The canonical test command for this repo:
```bash
pnpm run test
```

This runs `hugo --gc --minify` and validates the build. Always run before committing template changes.
