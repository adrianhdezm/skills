---
name: add-bugfix
description: Add one surgical bugfix file under `docs/epics/active/<epic>/bugfixes/bugfix_<name>.md`. Use when an active epic needs corrective work with current behavior, expected behavior, unchanged behavior, root cause, fix boundary, and regression checks.
---

# Add Bugfix

## Core Rule

Add exactly one bugfix to an existing active epic. A bugfix is the implementation source of truth for corrective work; it goes directly from analysis to implementation tasks without an epic subdivision. Use `add-story` for planned value slices. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - Read `docs/epics/active/<epic>/epic.md` and its source `docs/prd/<feature>.md` when present.
   - Read existing `stories/story_*.md` and `bugfixes/bugfix_*.md` in the epic.
   - Inspect relevant code, tests, logs, issue reports, docs, and concern specs.

2. Analyze the defect:
   - Capture current defective behavior, expected behavior, unchanged behavior, reproduction evidence, suspected root cause, affected surfaces, and fix constraints.
   - If the fix changes the epic outcome, public contract, rollout, or risk profile, stop and recommend updating `epic.md` and re-running `validate-epic`.
   - Prefer a failing reproduction test or deterministic repro command. If impossible, record why and use the closest reliable evidence.

3. Write the bugfix:
   - Create or update `docs/epics/active/<epic>/bugfixes/bugfix_<bug-slug>.md`.
   - Use [references/bugfix-template.md](references/bugfix-template.md).
   - Include root cause, fix boundary, regression boundaries, implementation tasks, verification matrix, and validation sections.

4. Report result:
   - Provide the absolute bugfix path.
   - Summarize root cause confidence, fix boundary, reproduction evidence, assumptions, and recommend `validate-work-plan`.

## Validation Checklist

- [ ] Current defective behavior is reproducible or evidence-backed.
- [ ] Expected behavior is observable and testable.
- [ ] Unchanged behavior protects regression-sensitive paths.
- [ ] Root cause and fix boundary are specific enough for surgical implementation.
- [ ] Implementation tasks include repro, fix, and regression verification.
- [ ] Bugfix can feed `validate-work-plan`.
