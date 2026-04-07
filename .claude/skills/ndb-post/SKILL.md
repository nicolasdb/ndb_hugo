---
name: ndb-post
description: |
  Use this skill when creating or editing portfolio content for the ndb_hugo site.
  Covers all three content types (posts, patterns, timeline), their frontmatter schemas,
  evidence.yaml sidecar structure, block metadata, Hugo page bundle conventions, and
  the knowledge-first evidence model this portfolio is built on.

  Trigger keywords: new post, write post, add content, create pattern, timeline entry,
  evidence block, blockCount, timespan, confidence bar, portfolio content, ndb content,
  knowledge block, evidence trail, page bundle.
license: MIT
metadata:
  version: "1.0.0"
  last_verified: "2026-04-07"
  production_tested: true
---

# ndb_hugo Content Creation

## Mental Model

This portfolio does not list claims — it presents **evidence**. Every post, pattern,
and timeline moment is part of a knowledge graph where skills are demonstrated through
a dated trail of real events. When creating content:

- A **post** documents a project, decision, or learning arc — with an evidence trail
- A **pattern** models a reusable skill backed by blocks of evidence
- A **timeline moment** captures a single insight or pivot point

---

## Content Types & Commands

| Type | Directory | Create Command |
|------|-----------|----------------|
| Post (page bundle) | `content/posts/{slug}/` | `hugo new content posts/{slug}/index.md` |
| Skill Pattern | `content/patterns/{slug}.md` | `hugo new content patterns/{slug}.md` |
| Timeline Moment | `content/timeline/{slug}.md` | `hugo new content timeline/{slug}.md` |

After creating, always set `draft: false` before the post is ready to publish.

---

## Post Bundle

Posts live in a **page bundle** — a directory, not a single file:

```
content/posts/{slug}/
  index.md        ← content + frontmatter
  evidence.yaml   ← knowledge trail (optional but recommended)
  image.png       ← co-located images (optional)
```

### Frontmatter

```yaml
---
title: "Human-readable title in Title Case"
date: YYYY-MM-DD           # past or present only — future dates won't publish
description: "One to two sentence summary. No markdown. Appears in listings and meta tags."
tags: ["tag1", "tag2"]     # lowercase kebab-case
categories: ["Technical"]  # inferred from content; linked to knowledge graph
draft: false               # false = live, true = hidden
blockCount: 5              # integer — number of blocks in evidence.yaml
timespan: "MMM YYYY – MMM YYYY"  # e.g. "Jan 2025 – Mar 2026" or "Dec 2025 – present"
patterns: ["pattern-slug"] # optional — slugs of linked /patterns/ pages (no leading slash)
confidence: 80             # optional — 0–100 (85+ strong, 70–84 solid, <70 emerging)
---
```

**Required**: `title`, `date`, `description`, `tags`, `draft`
**Block-meta UI** (renders confidence bar + block count): `blockCount`, `timespan`, `patterns`, `confidence`

### evidence.yaml

```yaml
blocks:
  - date: "YYYY-MM-DD"
    color: fresh
    content: "What happened, what was understood. 1–2 sentences, plain language."

  - date: "YYYY-MM-DD"
    color: convergence
    content: "When a prior understanding met new evidence and something solidified."
```

Set `blockCount` in frontmatter to match the number of entries in this file.

### Block Colors

| Color | Use when |
|-------|----------|
| `fresh` | First encounter, new insight, strong signal just observed |
| `convergence` | Old idea meets new work — understanding confirmed or deepened |
| `pattern` | A reusable principle was extracted or generalized |
| `temporal` | Historical marker, reflection on past state |
| `frontier` | Speculative, unexplored, hypothesis not yet tested |
| `block` | Neutral — raw knowledge event, no strong semantic |

---

## Skill Pattern

```yaml
---
title: "Pattern Name in Title Case"
date: YYYY-MM-DD
draft: false
description: "One sentence: what skill this demonstrates."
tags: ["tag1", "tag2"]
confidence: 75             # required for patterns
blockCount: 4              # evidence blocks backing this skill
timespan: "2023 – present" # required; format: "YYYY – present" or "YYYY – YYYY"
trajectory: stable         # rising | stable | converging
featuredOnHomepage: false  # true = pinned to homepage patterns section
---
```

---

## Timeline Moment

```yaml
---
title: "Moment Title"
date: YYYY-MM-DD
draft: false
year: 2025                 # integer — used for grouping in timeline view
color: fresh               # same color vocabulary as evidence blocks
quote: "The insight that clicked. First-person voice. 1–2 sentences."
linkedPost: /posts/slug/   # optional — relative URL to related post or pattern
featuredOnHomepage: false
---
```

---

## Images

Store images inside the page bundle and use the `imgc` shortcode:

```
{{< imgc src="image.png" alt="Descriptive alt text" >}}
```

- Hugo auto-optimizes to WebP with lazy loading
- Keep source images under 1MB

---

## Validation

```bash
pnpm run test        # Hugo build validation — catches frontmatter and template errors
pnpm run dev:watch   # Live preview at localhost:1313
```

---

## Known Gaps (fog-of-war)

This skill evolves as the portfolio grows. Fields, categories, and knowledge graph
connections will be added here as they are discovered.
