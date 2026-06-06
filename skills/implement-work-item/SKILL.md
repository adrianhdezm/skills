---
name: implement-work-item
description: Implement one validated story or bugfix as scoped code, test, migration, documentation, and configuration changes. Use after `validate-work-item` returns `Pass`, or when the user explicitly accepts the risk of implementing an unvalidated or partially validated work item.
---

# Implement Work Item

## Core Rule

Implement exactly one story or bugfix with tight scope, explicit intent, and continuous verification. Normally start only after `validate-work-item` returns `Pass`; if the user explicitly overrides a missing, `Partial`, `Fail`, or `Blocked` validation result, record that risk before coding. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load the plan:
   - Read one `docs/epics/active/<epic>/stories/story_*.md` or `docs/epics/active/<epic>/bugfixes/bugfix_*.md`.
   - Read `docs/epics/active/<epic>/epic.md`, its source PRD when present, and relevant `docs/knowledge/` concern specs.
   - Confirm the work item passed `validate-work-item`, or record the user's explicit override and risk.
   - Check repository status and avoid overwriting unrelated user changes.
   - Extract requirements, expected behavior, unchanged behavior, constraints, implementation tasks, verification steps, and out-of-scope behavior.

2. Resolve blocking ambiguity:
   - Use repository context, planning artifacts, concern specs, documentation, code, logs, and tests before asking the user.
   - Ask before coding when ambiguity affects scope, design, verification strategy, sequencing, ownership, or artifact meaning.
   - Proceed with a stated assumption when ambiguity is non-blocking, and record it in implementation notes or the work item.

3. Implement task by task:
   - Work through the work item's `Implementation Tasks` in dependency order unless a clearly stated adjustment is required.
   - For bugfixes, add or confirm reproduction coverage before changing the fix path unless the bugfix explains why deterministic reproduction is not practical.
   - Follow repository patterns, naming, architecture, and test conventions.
   - Keep changes limited to the work item unless a discovered dependency is required.
   - Update implementation task checkboxes only when implementation work is complete and task-level verification has passed.
   - If the work item cannot be implemented as written, stop and propose a work item or epic edit before coding an alternative.
   - Use `document-decisions` when implementation exposes an important durable decision not already dictated by the plan or existing conventions.

4. Handle plan drift explicitly:
   - Treat `epic.md` and the selected story or bugfix file as the source of truth.
   - If implementation discovers an impossible, contradictory, obsolete, or materially risky requirement, stop affected work.
   - Propose a concrete edit to the owning artifact and wait for approval before implementing materially different behavior.

5. Verify while building:
   - Run focused tests, linters, type checks, migrations, or build commands tied to the changed area.
   - Record commands and outcomes for `run-validation`.
   - Add or update tests according to the work item's verification matrix.
   - After each implementation task, compare the implementation against the extracted checklist and fill missing requirements before moving on.

6. Reconcile before reporting:
   - Review `epic.md`, the selected work item, and relevant concern specs against the implementation.
   - Fix implementation gaps that are still within the written plan.
   - Raise any remaining mismatch that changes scope, success criteria, or durable design intent.

7. Report result:
   - Summarize completed implementation tasks, modified files, commands run, failures, assumptions, plan drift, and remaining work.
   - Recommend `run-validation` when implementation is ready for full verification.

## Validation Checklist

- [ ] Work matches the selected story or bugfix and its active epic.
- [ ] Work item validation status was checked.
- [ ] Requirements, constraints, verification steps, and out-of-scope behavior were extracted before implementation.
- [ ] Bugfix reproduction coverage was added, confirmed, or explicitly impractical.
- [ ] Blocking ambiguities were resolved before coding affected requirements.
- [ ] Repository conventions were followed.
- [ ] Important durable design choices were documented with `document-decisions` when needed.
- [ ] Relevant tests or checks were run.
- [ ] Implementation task status reflects reality.
- [ ] Any plan drift is corrected, approved, documented, or raised.
