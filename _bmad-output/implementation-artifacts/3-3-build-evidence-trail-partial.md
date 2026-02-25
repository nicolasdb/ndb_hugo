# Story 3.3: Build Evidence Trail Partial

Status: ready-for-dev

## Story

As a **portfolio visitor**,
I want to expand a collapsible evidence trail on posts that have one,
So that I can see the chronological block journey behind the post.

## Acceptance Criteria

1. `layouts/partials/evidence-trail.html` reads from `.Resources.GetMatch "evidence.yaml"` and unmarshals the data
2. The evidence trail renders as a collapsible section (Alpine.js `x-data` for expand/collapse)
3. Each block entry in the trail displays: date, color indicator, and content text
4. The trail is collapsed by default, expandable on click
5. The partial renders nothing when no `evidence.yaml` sidecar exists (graceful degradation)
6. Block color indicators use design token semantic colors (`--fresh`, `--convergence`, `--pattern`, `--temporal`, `--frontier`, `--block`)
7. `pnpm run test` passes
8. **Visual validation:** render locally with a post that has an `evidence.yaml` sidecar — verify expand/collapse works, color indicators match the block color token, and the trail renders nothing on a post without a sidecar

## Tasks / Subtasks

- [ ] Add `evidence.yaml` to one sample post for testing (AC: 8)
  - [ ] Create `content/posts/docker-journey/evidence.yaml` with 3+ real-ish block entries
  - [ ] Use varied `color` values to test all token mappings

- [ ] Build `layouts/partials/evidence-trail.html` (AC: 1–6)
  - [ ] Load sidecar: `{{ $evidence := .page.Resources.GetMatch "evidence.yaml" }}`
  - [ ] Guard: render nothing if `$evidence` is nil
  - [ ] Unmarshal: `{{ $data := $evidence | transform.Unmarshal }}`
  - [ ] Wrap in Alpine.js `x-data="{ open: false }"` for expand/collapse
  - [ ] Render toggle trigger (button/div) with `@click="open = !open"` and chevron indicator
  - [ ] Render block list with `x-show="open"` and `x-transition` for smooth reveal
  - [ ] For each block: render date (mono), color dot (semantic color), content text (body font)
  - [ ] Map `color` field value → CSS custom property (e.g., `fresh` → `var(--fresh)`)

- [ ] Visual validation (AC: 8)
  - [ ] `pnpm run dev:watch` — navigate to docker-journey post
  - [ ] Verify trail is collapsed by default
  - [ ] Click toggle — verify trail expands smoothly
  - [ ] Verify each block entry shows date, color dot, content
  - [ ] Verify color dots match semantic token colors (inspect CSS vars)
  - [ ] Navigate to sewer-museum post (no evidence.yaml) — verify no trail rendered

- [ ] Build validation (AC: 7)
  - [ ] `pnpm run test` passes

## Dev Notes

### Mechanics-First Principle

Story 2.6 established visual language. This story adds **interactive mechanics** — collapsible trail via Alpine.js. The expand/collapse behavior is the feature; styling follows existing token conventions. Do not introduce new spacing patterns or typography weights.

### Partial Interface Contract

```
{{/* evidence-trail.html */}}
{{/* Call: {{ partial "evidence-trail.html" (dict "page" .) }} */}}
{{ $evidence := .page.Resources.GetMatch "evidence.yaml" }}
{{ if $evidence }}
  {{ $data := $evidence | transform.Unmarshal }}
  <div x-data="{ open: false }">
    ... toggle trigger ...
    <div x-show="open" x-transition>
      {{ range $data.blocks }}
        ... render block entry ...
      {{ end }}
    </div>
  </div>
{{ end }}
```

### Evidence YAML Schema

Expected structure in `evidence.yaml`:

```yaml
blocks:
  - date: "2024-03-10"
    color: fresh
    content: "First attempt at Docker bridge networking — couldn't get two containers to talk."
  - date: "2024-06-15"
    color: convergence
    content: "Old Linux networking knowledge activated: subnets, routing tables, iptables."
  - date: "2025-01-08"
    color: pattern
    content: "Custom bridge plugin complete — handles DNS, isolation, cleanup automatically."
```

### Color Token Mapping

Map the `color` string from YAML to CSS custom property in the template:

| YAML `color` value | CSS token | DESIGN-SPEC meaning |
|--------------------|-----------|---------------------|
| `fresh` | `var(--fresh)` | New capture, strong signal (green) |
| `convergence` | `var(--convergence)` | Old idea meets new work (amber) |
| `pattern` | `var(--pattern)` | Skill pattern highlighted (coral) |
| `temporal` | `var(--temporal)` | Time marker (blue) |
| `frontier` | `var(--frontier)` | Unexplored, quiet (gray) |
| `block` | `var(--block)` | Raw knowledge block (neutral warm) |

Implementation via Hugo dict or if/else chain:
```
{{/* Inline approach — readable and safe */}}
{{ $colorMap := dict "fresh" "var(--fresh)" "convergence" "var(--convergence)" "pattern" "var(--pattern)" "temporal" "var(--temporal)" "frontier" "var(--frontier)" "block" "var(--block)" }}
{{ $dotColor := index $colorMap .color | default "var(--block)" }}
```

### Alpine.js Scope

Alpine.js is already loaded site-wide (TailBliss baseline). Scope stays minimal per architecture D2.3: only `x-data`, `@click`, `x-show`, `x-transition`. No custom Alpine components or plugins needed.

### Toggle Trigger Design

Follow the existing mono/tertiary label pattern from DESIGN-SPEC §2:
- Label: "Evidence trail (N blocks)" — mono font, `--text-tertiary`
- Chevron: rotate 180° when open (`x-bind:class="{ 'rotate-180': open }"`)
- Border separator above the trail section

### Resources.GetMatch Requirement

This partial **only works with page bundles**. The partial must be called with the page object (`.`), not a page parameter. If called on a flat `.md` file, `Resources.GetMatch` returns nil — graceful degradation covers this case. This is why story 3-1 converting flat posts to page bundles is a prerequisite.

### Architecture Compliance

- [Source: epics.md §Additional Requirements — D2.3] — Alpine.js scope moderate: evidence trail expand/collapse is explicitly listed
- [Source: epics.md §Additional Requirements — D1.1] — evidence trail as page bundle sidecar (`evidence.yaml`)
- [Source: epics.md §Additional Requirements — D1.1] — graceful degradation: renders nothing without sidecar
- [Source: DESIGN-SPEC.md§3] — Semantic colors for block types

### Visual Validation Checklist

Before marking done:
- [ ] Trail collapsed by default on page load
- [ ] Single click opens trail, second click collapses
- [ ] `x-transition` gives smooth reveal (not instant pop)
- [ ] Each entry: date in mono, color dot rendered, content text in body font
- [ ] Color dots: inspect `background-color` computed value — must resolve to OKLCH token, not hardcoded hex
- [ ] Post without `evidence.yaml`: no trail section rendered, no empty containers
- [ ] No console errors from Alpine.js
- [ ] Responsive: trail readable on mobile (`sm` breakpoint)

### Project Structure Notes

**New files this story:**
```
layouts/partials/
  evidence-trail.html    ← NEW
content/posts/docker-journey/
  evidence.yaml          ← NEW (test fixture, 3+ blocks)
```

**Note:** Story 3-1 converts posts to page bundles. If 3-1 is not yet done, you cannot use `Resources.GetMatch`. Confirm 3-1 is complete before starting this story.

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 3.3 AC]
- [Source: _bmad-output/planning-artifacts/architecture.md — D1.1 evidence trail sidecar, D2.3 Alpine.js scope]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md§3 — Block system colors]
- [Source: _bmad-output/implementation-artifacts/3-1-create-post-archetypes-content-structure.md — Evidence YAML schema]

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

### Completion Notes List

### File List
