---
name: create-epic
description: Create exactly one active epic plan under `docs/epics/active/<epic>/epic.md` from a Product Vision and a user-provided focus. Use after a Product Vision is ready and the user has chosen one specific end-to-end delivery outcome to plan.
---

# Create Epic

## Core Rule

Create exactly one epic for a user-selected part of the single Product Vision. The required flow is `define-product-vision -> plan-change optional -> suggest-epics optional -> create-epic -> validate-epic -> suggest-stories optional -> add-story or add-bugfix`; `create-epic` must not slice the whole Product Vision, create sibling epics, or create child work item files. Each `docs/epics/active/<epic>/epic.md` owns one end-to-end delivery outcome and can later contain independently validated stories and bugfixes. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Confirm the epic focus:
   - Use the user's requested Product Vision area, outcome, workflow, or capability as the epic focus.
   - If the focus is missing or too broad to produce one coherent epic, stop and ask for the specific Product Vision part to plan.
   - If the user asks to brainstorm or discover multiple epic options, recommend `suggest-epics` first.

2. Load inputs:
   - Read the Product Vision from `docs/vision.md`.
   - Read relevant `docs/knowledge/` concern specs and active epics.
   - Inspect code and docs enough to understand current system boundaries, existing behavior, and related work.

3. Define one epic:
   - Define the epic's outcome, in-scope behavior, out-of-scope behavior, dependencies, risks, and rollout approach.
   - Keep the epic end-to-end: it should describe a deliverable user, product, operational, or platform outcome, not a technical layer or task bucket.
   - Keep implementation guidance at strategy level. Do not turn the epic into low-level task instructions.
   - Identify which Product Vision goals, success signals, principles, constraints, non-goals, assumptions, and open questions this epic owns, partially supports, or explicitly does not cover.
   - Record cross-epic dependencies, sequencing assumptions, overlaps, and gaps against existing active epics.

4. Write the epic:
   - Ensure one `docs/epics/active/<epic>/` folder exists.
   - Write `docs/epics/active/<epic>/epic.md` using [references/epic-template.md](references/epic-template.md).
   - Include implementation strategy, concern impact, rollout/backout, ADR candidates, Product Vision coverage role, and cross-epic relationships.
   - Do not write story or bugfix files; child work item sequencing and verification tracking are created by `add-story` and `add-bugfix`.

5. Report result:
   - Provide the absolute path for the epic created.
   - Summarize the focus, Product Vision coverage role, cross-epic dependencies, assumptions, open questions, and recommend `validate-epic`.

## Validation Checklist

- [ ] Product Vision intent is preserved.
- [ ] Current system state and active work were checked.
- [ ] Exactly one active epic was created or updated.
- [ ] The epic covers one end-to-end delivery outcome, not a technical layer.
- [ ] The epic has concrete scope, non-scope, dependencies, risks, rollout, and concern impact.
- [ ] Product Vision coverage ownership, partial coverage, and non-coverage are explicit.
- [ ] Cross-epic dependencies, overlap, and sequencing are explicit.
- [ ] No story or bugfix files were created by this skill.
- [ ] The epic is concrete enough to feed `validate-epic`.
