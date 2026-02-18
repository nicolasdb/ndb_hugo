# Nicolas's Portfolio & Skills Repository

**Tagline**: Capture knowledge pearls first. Organize into narratives. Watch skills emerge from the pattern of your documented work.

---

## 📋 Project Overview

### Match with Key Themes

1. **Knowledge Accessibility & Digital Literacy** - Making personal growth patterns visible, understandable, and shareable
2. **Research & Knowledge Networking** - Building infrastructure for pattern discovery and skill convergence
3. **Digital Restitution** - Returning documented knowledge to the community through open architecture

### Target Audience

1. **Primary**: Knowledge workers, learners, visionaries tracking non-linear growth
2. **Secondary**: Educators, researchers, portfolio reviewers seeking evidence-based capability mapping
3. **Tertiary**: Open-source communities, collaborative teams needing shared skill landscapes

---

## 🎯 The Idea: Knowledge-First Portfolio System

### Problem Identified

- Portfolio workflow is backwards: pick skills first, then write content to showcase them
- Knowledge pearls scatter across tools and formats (notes, sketches, audio, ideas) and get lost
- Documentation happens *after* work is done, losing raw learning moments
- No system captures *when* ideas emerged or *how* they evolved into convergence
- Growth patterns remain invisible; you don't see what you've unconsciously been building toward

### Core Concept

**Invert the portfolio workflow:** Capture knowledge first → Organize into narratives → Recognize skills as emergent patterns

1. **Capture pearls continuously** (multi-format: notes, images, audio, sketches, code snippets)
2. **Organize into projects** (turn related pearls into coherent posts and documentation)
3. **Track time dimension** (when was this learned? when did it become relevant?)
4. **Recognize skill emergence** (patterns clustering from accumulated evidence and repetition)
5. **Revive convergence** (surface when old ideas connect to current work)
6. **Build honest chronicle** (document the real learning journey, not curated highlights)

Build a **living knowledge graph** (with temporal tracking) that:
- **Captures** knowledge pearls in any format, without requiring completion
- **Organizes** into projects and narratives through related clustering
- **Tracks time** (temporal dimension for convergence detection and evolution)
- **Reveals patterns** through the shape of documented work (skills emerge naturally)
- **Maps evolution** by showing when ideas become relevant (time to traction)
- **Enables safe exploration** by visualizing what you've practiced vs. untouched areas

### Key Principles

📚 **Portfolio as Chronicle** - Honest documentation of learning, not curated showcase
⏱️ **Temporal Tracking** - When things happened matters as much as what happened
💎 **Memory Pearls First** - Capture learning moments before organizing them
🔗 **Convergence Recognition** - Detect when old ideas find new relevance
📊 **Emergence Over Extraction** - Skills recognized from documented patterns, not pre-defined
🗺️ **Safe Exploration** - Map what you know, identify adjacent learning frontiers

---

## 👥 Who?

**Project Lead**: Nicolas (Portfolio architect)

**Collaborators**:
- Multi-agent BMAD advisory team (Business Analyst, Architect, Product Manager, Designer, Storyteller)
- Community: Open for feedback, contributions, and collaborative refinement

---

## 🎯 Objectives

| # | Objective | Outcome |
|---|-----------|---------|
| O1 | Multi-format knowledge pearl capture | Ideas, notes, audio, sketches, code captured without friction; no format discrimination |
| O2 | Project organization from pearls | Related pearls clustered and organized into coherent projects and posts |
| O3 | Temporal tracking & sequencing | Timeline of how ideas emerged, evolved, and converged over time |
| O4 | Skill pattern recognition | LLM analysis reveals skill clusters from accumulated documented work (not predefined) |
| O5 | Convergence detection | Surface when old ideas/pearls become relevant to current work (time-to-traction visibility) |
| O6 | Safe exploration mapping | Visualize what's been practiced heavily vs. untouched areas (learning frontiers) |
| O7 | Honest narrative visibility | Growth story visible as knowledge graph—real trajectory, not curated highlights |
| **Meta** | **Restitution & Openness** | **Architecture open-sourced; methodology shareable for other learners and documentarians** |

---

## 🏗️ Constraints & Resources

### What's Needed

| Resource | Status | Notes |
|----------|--------|-------|
| Graph Database | ✅ Neo4j + Graphiti | Temporal knowledge graph, convergence detection |
| LLM Integration (Claude API) | ✅ Available | Existing account; cost-effective |
| Data Schema Design | ✅ Locked | Pearl/necklace/pattern model, two-layer storage (Neo4j + PostgreSQL) |
| Visualization Library | ✅ D3.js | Custom SVG/Canvas, full style control |
| Backend | ✅ FastAPI (Python) | Config-driven, layered architecture, proven in betterCallSaul MVP |
| BackOffice Frontend | ✅ Svelte + Vite | Reactive UI, TailwindCSS 4.1, containerized |
| Design System | ✅ Locked | TailwindCSS 4.1, OKLCH tokens, "The Archivist" typography |
| Time & Iteration | ⚙️ Active | Phase 0 walking skeleton approach (vertical slices) |

### Constraints

- **Time**: Must ship Phase 1 (data capture + basic graph) quickly; later phases iterative
- **Historical Data**: Scattered across multiple sources; Phase 1 forward-looking only
- **Expertise**: Solo development; may need design partner for visualization UX
- **Technology Choices**: Must avoid over-engineering; start minimal, expand based on evidence

### What's Available

✅ Portfolio site infrastructure (Hugo + TailBliss + TailwindCSS 4.1 + OKLCH)
✅ Visual charter and design tokens locked (DESIGN-SPEC.md, design-tokens.css)
✅ UI prototypes for portfolio homepage, post page, backoffice, and lobby
✅ Proven backend baseline (FastAPI + SvelteKit from betterCallSaul MVP)
✅ Existing outcome/project documentation
✅ Network of advisors with domain expertise

---

## ✅ Conditions of Success

### Quantitative Metrics

- [ ] Outcomes logged: 10-15/month consistently
- [ ] Skill clusters discovered: 15-25 initial, growing with evidence
- [ ] Memory pearls activated: 10-20% per month (serendipity effectiveness)
- [ ] Graph query response: <500ms (system usability)
- [ ] Visitor engagement: 3-5 min avg time on graph pages

### Qualitative Metrics

- [ ] System reveals patterns I didn't see myself
- [ ] Skill XP levels feel accurate and evidence-based
- [ ] Exploration frontiers are genuinely valuable for learning
- [ ] Old ideas resurface naturally (not forced)
- [ ] Growth narrative feels authentic and true

### Phase Gates

- **Phase 1 ✅**: Core data capture + graph working (Weeks 1-4)
- **Phase 2 ✅**: LLM discovery + memory pearls functional (Weeks 5-8)
- **Phase 3 ✅**: Visualization compelling + public-ready (Weeks 9-12)
- **Phase 4 ✅**: Integrated into portfolio; users engaging naturally (Weeks 13+)

---

## 🌟 Positive Outcomes | Impact

### Direct Impact
- **For Nicolas**: Transparent evidence of capabilities; clarity on learning vectors; old ideas revived at moment of traction
- **For Viewers**: Understand skills + growth trajectory + safe expertise areas through visible evidence
- **For Collaborators**: Shared language for discussing adjacent skills and learning paths

### Unlocked Opportunities
- Foundation for **future skill-based collaboration platforms**
- Model for **evidence-based portfolio systems** (vs. self-assessment)
- Open methodology for **other learners/creators** to build similar systems
- Potential **research paper** on emergence-designed knowledge systems
- Template for **grant applications** (this README structure itself)

### Negative Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Data quality inconsistency | Unreliable skill levels | Validation schema + LLM double-check |
| LLM hallucination | False skill claims | Human review before graph update |
| Motivation decay | System becomes stale | Minimal logging friction; visualization rewards |
| Performance degradation | Slow queries at scale | Regular optimization; query caching |
| Feature creep | Never ships | Strict phasing; minimize Phase 1 scope |

---

## 📚 Documentation & Knowledge Sharing

### Current Documentation

- ✅ **README** (this file) - Project overview + grant template structure
- ✅ **CLAUDE.md** - Development guidelines + architecture notes
- ✅ **PRD v2.1** (`_bmad-output/01-prd-skill-discovery-system.md`) - Complete specification with architecture amendments
- ✅ **UX Design Spec** (`_bmad-output/planning-artifacts/ux-design-specification.md`) - UX framework (steps 1-7 of 14)
- ✅ **Design Spec** (`_bmad-output/implementation-artifacts/DESIGN-SPEC.md`) - Visual charter, typography, colors, components
- ✅ **Design Tokens** (`_bmad-output/implementation-artifacts/design-tokens.css`) - CSS custom properties (OKLCH)
- ✅ **UI Prototypes** (`_bmad-output/implementation-artifacts/`) - HTML mockups for portfolio, backoffice, lobby, post page
- ⏳ **Architecture Doc** - In progress (linked repos, deployment topology, tech stack)
- ⏳ **User Guide** (Phase 1+) - How to use the skill discovery system
- ⏳ **API Reference** (Phase 1+) - Outcome logging + query endpoints

### Open-Source Commitment

- [ ] Code published on GitHub (MIT or Apache 2.0 license)
- [ ] Architecture methodology documented publicly
- [ ] Template/starter kit for others to build similar systems
- [ ] Blog series on design decisions and lessons learned

### Sharing & Restitution

Documentation will be:
- **Searchable**: Clear structure for discovery
- **Modular**: Usable pieces extracted for different contexts
- **Translatable**: Structured for multiple languages
- **Shareable**: Licensed for reuse and adaptation

---

## 🚀 Implementation Roadmap

**Strategy:** Vertical slices (walking skeleton), not horizontal layers. Each phase delivers end-to-end value. Frontend-first priority — portfolio ships while backoffice develops in parallel.

**Architecture:** Linked repos. Hugo portfolio (this repo, Netlify). BackOffice (separate repo, Docker container). Shared design tokens extracted when second consumer exists.

### Phase 0: Walking Skeleton (Current)

**Portfolio (this repo):**
- [x] Design spec locked (typography, colors, spacing, components)
- [x] Design tokens defined (OKLCH, CSS custom properties)
- [x] UI prototypes created (homepage, post page, backoffice, lobby)
- [ ] Implement design spec in Hugo templates (replace generic TailBliss)
- [ ] Deploy to Netlify
- [ ] Publish first posts documenting progress

**BackOffice (separate repo, parallel track):**
- [ ] Set up repo from betterCallSaul baseline (FastAPI + Svelte)
- [ ] Minimal pearl capture: upload → AI processing → validation queue
- [ ] Basic graph view (D3.js static force-directed)
- [ ] One compose/publish flow: pearls → draft → git commit → Hugo rebuilds

### Phase 1: Emergence
- [ ] Full pearl capture pipeline (multi-format: text, images, code)
- [ ] Pattern recognition pipeline (embed → cluster → label → validate)
- [ ] Natural language graph queries
- [ ] %Confidence display and training gauge
- [ ] Import existing data (Obsidian vaults, Logseq graphs)

### Phase 2: Visualization & Frontier
- [ ] Interactive graph visualization (temporal force-directed)
- [ ] Pattern gallery on portfolio (skill subgraph cards)
- [ ] Timeline view (anagnorisis moments)
- [ ] Fog of war / frontier mapping (500+ pearls threshold)
- [ ] Edge devices (Rust + ESP32-S3, parallel track)

---

## 🎬 Elevator Pitch (Boss Level - The Council)

What if your portfolio wasn't a curated showcase, but a living chronicle of what you're actually building and learning?

Instead of asking "What skills should I highlight?", start with knowledge pearls—quick captures of ideas, learning moments, half-formed thoughts in whatever format fits (photos, notes, audio, sketches). Then organize them: turn related pearls into posts, document your progress, share the real journey.

The genius part? As you accumulate documented projects and outcomes, patterns emerge naturally. The system helps you recognize what you've been practicing repeatedly, where success clusters form, how old ideas suddenly become relevant to new work. Skills don't need to be discovered—they become visible through the shape of your work over time.

It's portfolio as honest chronicle, not portfolio as highlight reel. The temporal dimension matters: you can see when ideas found traction, how thoughts converged, the real timeline of becoming. And it's restitution—you're sharing not just what you know, but how you learn, iterate, and grow. The infrastructure is open, so others can build similar systems for documenting their own knowledge journeys.

---

## 📖 License

### Theme: Apache 2.0

The theme is licensed under [Apache License 2.0](LICENSE) by [nicolas de Barquin](https://github.com/nicolasdb).

### Content: Creative Commons Attribution 4.0 (CC-BY 4.0)

All original content (articles, projects, code examples, images) is licensed under [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) by [nicolas de Barquin](https://github.com/nicolasdb).

You can share and adapt with attribution.

---

## Quick launch

```bash
pnpm run dev:watch    # Start development at http://localhost:1313
```

**Built with**: [Hugo](https://gohugo.io/) + [TailwindCSS 4.1](https://tailwindcss.com/) + [Alpine.js](https://alpinejs.dev/) + OKLCH color space
**Design system**: "The Archivist" — Literata + Hanken Grotesk + Commit Mono
**Deploys to**: [Netlify](https://netlify.com/) (git push → CDN rebuild)
