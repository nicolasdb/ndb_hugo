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

## Notes

- Story 5.0 will do a comprehensive sweep of all Epic 1-4 story records and may add items to this backlog
- This document is reviewed as a mandatory commitment in the Epic 5 retrospective
