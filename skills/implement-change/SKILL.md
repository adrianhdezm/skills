---
name: implement-change
description: Implement one ready or partially implemented epic-scoped or standalone story or bugfix as scoped code, test, migration, documentation, and configuration changes. Use when the selected story or bugfix is actionable and should move to review.
---

# Implement Change

## Core Rule

Implement exactly one story or bugfix with tight scope, explicit intent, and continuous verification. Only implement artifacts with `State: Ready` or `State: Partial Implemented`. If the selected artifact is `Blocked`, resolve and record the blocker before coding; if it is `Review` or `Implemented`, do not implement it again unless the user explicitly reopens the artifact. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load the plan:
   - Read one epic-scoped story or bugfix under `docs/epics/active/<epic>/story_*.md` or `docs/epics/active/<epic>/bugfix_*.md`, or one standalone story or bugfix under `docs/standalone-changes/active/story_*.md` or `docs/standalone-changes/active/bugfix_*.md`.
   - For epic-scoped work, read `docs/epics/active/<epic>/epic.md`, its source Product Vision when present, and relevant `docs/knowledge/` concern specs.
   - For standalone work, read `docs/vision.md` when present, active epics when placement could affect scope, sibling standalone changes, and relevant `docs/knowledge/` concern specs.
   - Confirm the selected story or bugfix has `State: Ready` or `State: Partial Implemented`.
   - Check repository status and avoid overwriting unrelated user changes.
   - Extract requirements, expected behavior, unchanged behavior, constraints, implementation tasks, verification steps, and out-of-scope behavior.

2. Resolve blocking ambiguity:
   - Use repository context, planning artifacts, concern specs, documentation, code, logs, and tests before asking the user.
   - Ask before coding when ambiguity affects scope, design, verification strategy, sequencing, ownership, or artifact meaning.
   - Proceed with a stated assumption when ambiguity is non-blocking, and record it in implementation notes or the selected story or bugfix.

3. Implement task by task:
   - Work through the selected story or bugfix's `Implementation Tasks` in dependency order unless a clearly stated adjustment is required.
   - For bugfixes, add or confirm reproduction coverage before changing the fix path unless the bugfix explains why deterministic reproduction is not practical.
   - Follow repository patterns, naming, architecture, and test conventions.
   - Keep changes limited to the selected story or bugfix unless a discovered dependency is required.
   - Update implementation task checkboxes only when implementation work is complete and task-level verification has passed.
   - If the selected story or bugfix cannot be implemented as written, stop and propose a story, bugfix, or epic edit before coding an alternative.
   - Use `document-decisions` when implementation exposes an important durable decision not already dictated by the plan or existing conventions.

4. Handle plan drift explicitly:
   - Treat the selected story or bugfix file as the source of truth, plus `epic.md` for epic-scoped work.
   - If implementation discovers an impossible, contradictory, obsolete, or materially risky requirement, stop affected work.
   - Propose a concrete edit to the owning artifact and wait for approval before implementing materially different behavior.

5. Verify while building:
   - Run focused tests, linters, type checks, migrations, or build commands tied to the changed area.
   - Record commands and outcomes for `validate-implementation`.
   - Add or update tests according to the selected story or bugfix's verification matrix.
   - After each implementation task, compare the implementation against the extracted checklist and fill missing requirements before moving on.

6. Reconcile before reporting:
   - Review the selected story or bugfix, relevant concern specs, and `epic.md` when the work is epic-scoped against the implementation.
   - Fix implementation gaps that are still within the written plan.
   - Raise any remaining mismatch that changes scope, success criteria, or durable design intent.

7. Report result:
   - Update the selected story or bugfix to `State: Review` and `Blocked By: N/A` when the implementation attempt is ready for validation.
   - Summarize completed implementation tasks, modified files, commands run, failures, assumptions, plan drift, and remaining work.
   - Recommend `validate-implementation` when implementation is ready for full verification.

## Validation Checklist

- [ ] Work matches the selected story or bugfix and its selected placement.
- [ ] Selected story or bugfix started in `Ready` or `Partial Implemented`.
- [ ] Requirements, constraints, verification steps, and out-of-scope behavior were extracted before implementation.
- [ ] Bugfix reproduction coverage was added, confirmed, or explicitly impractical.
- [ ] Blocking ambiguities were resolved before coding affected requirements.
- [ ] Repository conventions were followed.
- [ ] Important durable design choices were documented with `document-decisions` when needed.
- [ ] Relevant tests or checks were run.
- [ ] Implementation task status reflects reality.
- [ ] Selected story or bugfix state was updated to `Review` when ready for validation.
- [ ] Any plan drift is corrected, approved, documented, or raised.
