# Story 3.5: Create First Real Post with Evidence Trail

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want at least one real post published as a page bundle with evidence trail,
So that the content pipeline is proven end-to-end and visitors see a working example.

## Acceptance Criteria

1. A post exists at `content/posts/{slug}/index.md` with all core and block frontmatter fields populated (real content)
2. An `evidence.yaml` sidecar exists with at least 3 block entries (real content, not placeholder)
3. The post renders correctly on the post list page with block metadata visible
4. The post detail page shows the confidence bar and collapsible evidence trail
5. The evidence trail expands/collapses correctly
6. `pnpm run test` passes
7. **Visual validation (end-to-end pipeline check):** render locally — the complete mechanic chain works: post list shows block-meta → post detail shows confidence bar → evidence trail expands with color-coded blocks → all within the 2.6 polished shell without visual regressions

## Tasks / Subtasks

- [ ] Choose post to make "first real" (AC: 1, 2)
  - [ ] Elevate `docker-journey` to full real post OR write a new post from scratch
  - [ ] Populate ALL frontmatter fields: title, date, description, tags, categories, draft: false
  - [ ] Add block fields: blockCount, timespan, patterns, confidence (real values)
  - [ ] Write substantive post body (existing docker-journey content is already good — extend if needed)

- [ ] Write `evidence.yaml` sidecar with real block entries (AC: 2)
  - [ ] Minimum 3 blocks with real dates, meaningful `color` values, real content text
  - [ ] Blocks in chronological order
  - [ ] Use varied colors to demonstrate the semantic system (mix of `fresh`, `convergence`, `pattern`)

- [ ] End-to-end pipeline validation (AC: 3, 4, 5, 7)
  - [ ] `pnpm run dev:watch`
  - [ ] Navigate to `/posts/` — post appears in list with block-meta (blockCount, timespan, confidence bar snippet)
  - [ ] Click into post — full header with block-meta and confidence bar visible
  - [ ] Scroll to evidence trail — collapsed by default
  - [ ] Click to expand — all 3+ blocks render with date, color dot, content text
  - [ ] Verify color dots use correct semantic tokens (not hardcoded)
  - [ ] Verify overall page feels polished inside 2.6 shell (no layout breaks)

- [ ] Cleanup and verify sample posts (AC: 6)
  - [ ] Verify `sewer-museum-valve-controller` still renders cleanly as standard post (no block fields)
  - [ ] `pnpm run test` passes

## Dev Notes

### This Story Is an End-to-End Integration Test

Stories 3-1 through 3-4 build the mechanics. Story 3-5 **proves they all work together**. The real value here is not just the post content — it's validating the complete pipeline:

```
content/posts/docker-journey/
  index.md         ← frontmatter with block fields
  evidence.yaml    ← sidecar with real blocks
        ↓
layouts/posts/list.html
  → post-list-item.html
    → block-meta.html     ← block count, timespan, patterns visible
        ↓
layouts/posts/single.html
  → block-meta.html       ← full block metadata + confidence bar
  → evidence-trail.html   ← collapsible, color-coded blocks
```

If any link in this chain is broken, this story surfaces it.

### Recommended Post: Elevate docker-journey

`content/posts/docker-journey/index.md` already has good content. Real frontmatter to add:

```yaml
---
title: "From Confusion to Contribution: A Docker Journey"
date: 2025-01-15
draft: false
description: "What started as networking confusion became a custom bridge plugin. Somewhere in between, I taught it to interns — and teaching is where the real understanding happened."
tags: ["docker", "networking", "teaching"]
categories: ["engineering"]
blockCount: 7
timespan: "March 2024 – January 2025"
patterns: ["container-orchestration"]
confidence: 72
---
```

### Real `evidence.yaml` for docker-journey

```yaml
blocks:
  - date: "2024-03-10"
    color: fresh
    content: "First attempt at Docker bridge networking. Two containers on same bridge can't resolve each other by name. Documentation assumes you know Linux routing. I don't."
  - date: "2024-05-22"
    color: convergence
    content: "Recalled a sysadmin workshop from 2022 on iptables and NAT chains. Realized Docker's bridge networking is just Linux netfilter with defaults. Old knowledge reactivated."
  - date: "2024-08-14"
    color: fresh
    content: "Taught Docker networking fundamentals to fablab interns. Explaining subnets forced me to confront every gap. Teaching as debugging."
  - date: "2024-10-30"
    color: pattern
    content: "Identified the pattern: isolation policy + shared service reachability + automatic cleanup. This is the plugin interface I need."
  - date: "2025-01-08"
    color: pattern
    content: "Custom bridge plugin shipped. Handles DNS resolution, group isolation, automatic cleanup on container stop. Proof that understanding accumulates."
```

**Confidence 72** maps to `--pattern` color range (70–89) — skill emerging into pattern. This is honest.

### Visual Regression Check

After completing this story, manually verify that nothing in the 2.6 shell is broken:

| Check | Expected |
|-------|----------|
| Nav blur on scroll | Works |
| Footer location/links | Unchanged |
| Home page sections | Unchanged |
| Post list page | Shows new real post + sample posts |
| Post detail spacing | `pt-12 md:pt-[68px]` preserved |
| Confidence bar | Appears below tags in post header |
| Evidence trail | Collapsed by default, expands on click |
| Sewer-museum post | No block sections, clean standard layout |

### Content Quality Bar

Per NFR-3 (Evidence-Based): "every skill claim links to documented outcomes." The first real post sets the standard for the portfolio. The content must:
- Tell a real story with a real timeline
- Have evidence blocks that genuinely back the post's claims
- Use confidence score honestly (not 90+ for something still developing)

This is not dummy content — it is the first real demonstration of the knowledge-first approach.

### Architecture Compliance

- [Source: epics.md §NFR-3] — Evidence-based: every skill claim links to documented outcomes
- [Source: epics.md §Additional Requirements — D1.1] — Posts as page bundles
- [Source: epics.md §Additional Requirements — D1.1] — evidence trail as page bundle sidecar

### Project Structure Notes

**Modified files:**
```
content/posts/docker-journey/
  index.md         ← Add block frontmatter, keep existing content
  evidence.yaml    ← Add real block entries (created in 3-3 as test fixture, now real content)
```

**Unchanged files (verify only):**
```
content/posts/sewer-museum-valve-controller/
  index.md         ← No block fields — verify renders cleanly as standard post
```

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 3.5 AC]
- [Source: _bmad-output/planning-artifacts/epics.md — NFR-3 Evidence-Based]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md§3 — Confidence thresholds for honest scoring]
- [Source: _bmad-output/implementation-artifacts/3-2-build-block-meta-confidence-partials.md — confidence bar color thresholds]
- [Source: _bmad-output/implementation-artifacts/3-3-build-evidence-trail-partial.md — evidence.yaml schema]

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

### Completion Notes List

### File List
