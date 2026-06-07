---
name: add-bugfix
description: Add one surgical bugfix file either under a validated active epic or under `docs/standalone-changes/active/`. Use when corrective work needs current behavior, expected behavior, unchanged behavior, root cause, fix boundary, and regression checks.
---

# Add Bugfix

## Core Rule

Add exactly one bugfix. A bugfix is the implementation source of truth for corrective work; it goes directly from analysis to implementation tasks without an epic subdivision. Place the bugfix inside an active epic when it corrects behavior in that epic, or under `docs/standalone-changes/active/` when it is self-contained and no active epic or new epic is needed. Use `add-story` for planned value slices. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - If an epic is provided, read `docs/epics/active/<epic>/epic.md` and its source `docs/vision.md` when present.
   - If no epic is provided, read `docs/vision.md` when present, active epics under `docs/epics/active/`, and standalone changes under `docs/standalone-changes/active/`.
   - Read existing sibling `story_*.md` and `bugfix_*.md` files for the selected placement.
   - Inspect relevant code, tests, logs, issue reports, docs, and concern specs.

2. Analyze the defect:
   - Capture current defective behavior, expected behavior, unchanged behavior, reproduction evidence, suspected root cause, affected surfaces, and fix constraints.
   - For epic-scoped bugfixes, verify `Epic Validation` is `Pass` before creating child work.
   - If the epic validation is missing, `Fail`, or `Blocked`, stop and recommend `validate-epic` or epic corrections before creating the bugfix.
   - If the epic validation is `Partial`, create the bugfix only when the user explicitly accepts the documented gaps and the bugfix does not depend on them; record the override in the bugfix.
   - For epic-scoped bugfixes, if the fix changes the epic outcome, public contract, rollout, or risk profile, stop and recommend updating `epic.md` and re-running `validate-epic`.
   - For standalone bugfixes, verify the bugfix does not fit an active epic, does not need a new epic, and does not materially change the Product Vision.
   - If a standalone bugfix needs multiple coordinated stories or bugfixes, rollout/backout planning, cross-cutting risk tracking, or durable product direction changes, stop and recommend `plan-change`, `create-epic`, or `define-product-vision` as appropriate.
   - Prefer a failing reproduction test or deterministic repro command. If impossible, record why and use the closest reliable evidence.

3. Write the bugfix:
   - For epic-scoped placement, create or update `docs/epics/active/<epic>/bugfix_<bug-slug>.md`.
   - For standalone placement, create or update `docs/standalone-changes/active/bugfix_<bug-slug>.md`.
   - Use [references/bugfix-template.md](references/bugfix-template.md).
   - For standalone placement, include a `Routing Decision` section that records placement, reason, active epics checked, Product Vision impact, epic need, and `plan-change` when it supplied the route.
   - Include root cause, fix boundary, regression boundaries, implementation tasks, verification matrix, and validation sections.

4. Report result:
   - Provide the absolute bugfix path.
   - Summarize placement fit, root cause confidence, fix boundary, reproduction evidence, assumptions, and recommend `validate-change-plan`.

## Validation Checklist

- [ ] Current defective behavior is reproducible or evidence-backed.
- [ ] Expected behavior is observable and testable.
- [ ] Unchanged behavior protects regression-sensitive paths.
- [ ] Bugfix is inside the epic scope, or has a recorded standalone routing decision.
- [ ] Epic-scoped bugfixes are added only under a passing epic validation, or an explicit `Partial` override is recorded.
- [ ] Root cause and fix boundary are specific enough for surgical implementation.
- [ ] Implementation tasks include repro, fix, and regression verification.
- [ ] Bugfix can feed `validate-change-plan`.
