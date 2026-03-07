---
title: "Manual Content Publishing"
date: 2026-02-26
draft: false
description: "The Hugo-native workflow for authoring posts, patterns, and timeline moments. Manual precision while the backoffice is being built."
tags: ["hugo", "workflow", "authoring"]
confidence: 78
blockCount: 8
timespan: "December 2025 – February 2026"
trajectory: rising
featuredOnHomepage: true
---

## The Content Stack

Three content types, three workflows. Each backed by the same evidence model.

When I'm learning something — writing code, running experiments, documenting a decision — I capture dated blocks of insight. That block becomes evidence. Evidence becomes patterns when the same insight surfaces across multiple contexts. Timeline moments mark when those patterns converge into actionable knowledge.

This Hugo workflow lets me author all three without a backoffice. Manual, but precise.

## Creating a Post

```bash
hugo new content posts/{slug}
```

This scaffolds `content/posts/{slug}/index.md` with YAML frontmatter and an empty `evidence.yaml` file.

**Frontmatter fields:**
- `title`: Post title (e.g., "Debugging Valve Controller MQTT Timing")
- `date`: Publication date (YYYY-MM-DD, must be past/current)
- `draft: false`: Publish immediately
- `description`: One-sentence summary for archives
- `tags`: List for categorization
- `linkedPattern`: Optional link to a pattern this post contributes to

Write the post body in markdown. It becomes the context for your evidence blocks.

## Writing evidence.yaml

Each block represents a dated insight — a decision made, a learning realized, a problem solved.

```yaml
blocks:
  - date: 2026-02-18
    label: "MQTT listener active"
    color: "fresh"
    description: "Got the valve controller responding to publish messages. Timing was the issue — debounce window too aggressive."
  - date: 2026-02-19
    label: "Persistence solved"
    color: "pattern"
    description: "Reading back the state from the controller reveals the real problem: state wasn't persisting across power cycles."
```

**Color semantics:**
- `fresh`: New discovery, first attempt
- `building`: Iterating toward solution
- `pattern`: Insight that recurs across problems
- `convergence`: Multiple patterns aligning into knowledge

**Dating matters:** Blocks appear chronologically on the post detail page. Real dates > guessed dates.

## Creating a Pattern

Patterns emerge when the same insight surfaces across multiple posts.

```bash
hugo new content patterns/{slug}
```

This scaffolds `content/patterns/{slug}.md` with frontmatter. Patterns are leaf files — one markdown file per pattern, no nested structure.

**Frontmatter fields:**
- `title`: Pattern name
- `date`: When the pattern crystallized (often the date of the most recent contributing post)
- `draft: false`: Publish immediately
- `description`: The insight in one sentence
- `tags`: Thematic tags (e.g., "docker", "infrastructure", "learning")
- `confidence`: 0-100 scale of how confident you are in this pattern
- `blockCount`: How many evidence blocks contributed to this pattern
- `timespan`: Years this pattern has been developing (e.g., "2021 – present")
- `trajectory`: How the pattern is evolving (`stable`, `converging`, `rising`, `declining`)
- `featuredOnHomepage: true/false`: Whether to show on the homepage patterns section

**Body:** Write it as you'd want to read it six months from now. Be specific. Include examples.

## Adding Timeline Moments

Timeline moments mark inflection points — when patterns converge, when a skill completes, when direction shifts.

```bash
hugo new content timeline/{year}-{slug}
```

This scaffolds `content/timeline/{year}-{slug}.md` with frontmatter.

**Frontmatter fields:**
- `title`: Moment title
- `date`: Date of the moment (YYYY-MM-DD)
- `year`: Numeric year for grouping
- `draft: false`: Publish immediately
- `color`: Color code (same semantics as evidence blocks)
- `quote`: A memorable quote or insight from that moment
- `linkedPost`: Optional link to a related post
- `featuredOnHomepage: true/false`: Whether to show on homepage timeline section
- `description`: Full description (typically duplicates the quote)

**Body:** Can be empty, or a short reflection. The quote and description usually suffice.

## Publishing

```bash
git add content/
git commit -m "Add: {post/pattern/moment title}"
git push
```

Netlify triggers on push to main. Build completes in ~30 seconds. If you see warnings about draft dates, check that your post date is not in the future.

## Why Manual?

A backoffice CMS is coming in Epic 5. Until then, this workflow has served us well:

- **Precision:** Git history tracks every word change
- **Simplicity:** No database, no API, no deployment complexity
- **Durability:** Markdown files survive tool changes
- **Clarity:** `hugo new` scaffolds the exact structure you need

The friction we *do* have — editing YAML, manual git commits — keeps us thoughtful. We don't create content casually. Every post, pattern, and moment represents real work.

This document itself is dog-food. It's a pattern about the workflow for creating patterns.
