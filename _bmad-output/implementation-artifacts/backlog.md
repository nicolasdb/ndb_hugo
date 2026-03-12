# Project Backlog

**Created:** 2026-03-07 (Epic 4 Retrospective)
**Mandatory:** Review in Epic 5 Retrospective

This backlog captures deferred items, future work, and post-Phase 0 tasks. Items are swept from Epic 1-4 story records and retrospective decisions. Story 5.0 will do a comprehensive sweep and may add more items.

---

## Post-Phase 0 (Deferred Features)

### SVG Logo Sizing Cleanup
- **Source:** Story 2.3 completion notes
- **Description:** Logo SVG requires a triple-layer sizing approach (HTML width/height attrs + inline style + Tailwind classes) due to Inkscape export complexity. The implementation works but is inelegant. Cleanup deferred to UI polishing epic.
- **Scope:** Portfolio / Phase 1
- **Priority:** Low (functional, just messy)

### Constellation SVG for Pattern Cards
- **Source:** Story 4-2 (deferred), DESIGN-SPEC section 6
- **Description:** Procedural mini-graph SVG (72x44px) for pattern cards. Nodes connected when distance < 22px, color by confidence threshold. Currently replaced by simple confidence bar.
- **Scope:** Backoffice / Phase 1+
- **Priority:** Low (confidence bar covers the essential visual)

---

## Post-Phase 0 (Reusable Skills)

### Skill: design-spec-split
- **Source:** Epic 4 Retrospective
- **Description:** Portable skill for extracting structured TOML from prose design specs. Applicable to any design-heavy project. Invoke after creating a DESIGN-SPEC to generate a structured companion file.
- **Rationale:** LLM agents drift on pixel-level values embedded in prose. Structured TOML prevents this.

### Skill: ndb_hugo content schemas (backend-frontend contract)
- **Source:** Epic 4 Retrospective
- **Description:** Packages frontmatter specs, evidence.yaml format, pattern/timeline schemas, file structure conventions as a reusable skill. Becomes the integration contract between ndb_hugo (frontend) and ndb_backoffice (backend). Backend output = frontend input, no API needed.
- **Validation plan:** Battle-test with OpenClaw + copywriter agent to preprocess real posts and refine backend specs before building ndb_backoffice.
- **Source material:** Story 5.3 ndb_hugo documentation post + design-config.toml from Story 5.0

---

## Phase 1 Design Leads (ndb_backoffice)

These items emerged from Story 5.3 implementation and reflect architectural decisions that need to be locked before Phase 1 begins. They are not isolated features — they form a coherent direction.

### Evidence Provenance: Anchoring Blocks to External Refs

- **Source:** Story 5.3 implementation reflection
- **Problem:** Current `evidence.yaml` blocks are assertions — a date and a claim, with no external anchor. There is no mechanism to distinguish a real dated event from a retroactively invented one.
- **Direction:** Add optional `ref` field to the evidence block schema. In Phase 0, this means a git commit SHA. In Phase 1, it means any resolvable URI (commit, PR, issue, calendar event, external link). The field is ignored by the Hugo template (graceful degradation), so it can be introduced now without any rendering changes.
- **Scope:** Schema change only. Template unchanged. Add to `ndb_hugo content schemas` skill when that skill is packaged.
- **Priority:** Medium — the field should be documented before Phase 1 locks the contract.

### Evidence as First-Class Entities (Graph Model)

- **Source:** Story 5.3 implementation reflection
- **Problem:** Evidence is currently owned by posts (post sidecar). This is wrong at the data level: evidence *supports* claims, and the same evidence event can support multiple posts, patterns, and timeline entries. The current model requires duplication and manual synchronization when new posts retrospectively strengthen old ones.
- **Direction:** In Phase 1, `ndb_backoffice` should own a canonical evidence store where each block is a first-class entity with a URI. Posts, patterns, and timeline entries *reference* evidence rather than own it. The build pipeline generates `evidence.yaml` sidecars from SPARQL queries against this store, not from hand-authored files.
- **Concrete stack candidate:** [Oxigraph](https://github.com/oxigraph/oxigraph) — embedded, SPARQL 1.1, Rust, fast enough for a build-time preprocessing step.
- **Data model sketch:**
  ```
  evidence-block:X  prov:atTime   "2026-02-07"
                    rdfs:label    "Architecture locked..."
                    prov:supports post:ndb-hugo-architecture
                    prov:supports post:evidence-first-engineering
                    prov:supports pattern:manual-content-publishing
  ```
  A SPARQL query at build time collects all evidence supporting each content node, regardless of where the block "lives." Old posts gain new evidence without their files being touched.
- **Bridge to Phase 0:** The `ref` field above (git SHA) becomes `prov:wasRevisionOf` in the RDF model. The schemas documented in the Story 5.3 post are the serialization format of the graph, not its source of truth.
- **Priority:** High for Phase 1 architecture. This decision shapes ndb_backoffice's data model fundamentally.

---

## Post-Phase 0 (Deferred Features)

- Story 5.0 will do a comprehensive sweep of all Epic 1-4 story records and may add items to this backlog
- This document is reviewed as a mandatory commitment in the Epic 5 retrospective
