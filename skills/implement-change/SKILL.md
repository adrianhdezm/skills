---
name: implement-change
description: Implement one ready or partially implemented epic-scoped or standalone story or bugfix as scoped code, test, migration, documentation, and configuration changes. Use when the selected story or bugfix is actionable and should move to review.
---

# Implement Change

## Core Rule

Implement exactly one story or bugfix with tight scope, explicit intent, and continuous verification. Only implement artifacts with `State: Ready` or `State: Partial Implemented`. If the selected artifact is `Blocked`, resolve and record the blocker before coding; if it is `Review` or `Implemented`, do not implement it again unless the user explicitly reopens the artifact. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Select exactly one work item:
   - If the user provided a specific artifact path, use that path as the candidate work item.
   - If the user did not provide a specific artifact path, run this skill's `scripts/list-actionable-work.sh <target-repo-root>` to list `Ready` and `Partial Implemented` stories and bugfixes, then choose or ask for exactly one row from that output.
   - Do not read implementation context for multiple rows. Stop and ask the user to choose when more than one item is plausible and there is no clear single requested item.
   - Confirm the selected story or bugfix has `State: Ready` or `State: Partial Implemented`; do not proceed with `Blocked`, `Review`, or `Implemented` unless the user explicitly reopens or changes the artifact state.

2. Load context from the selected item:
   - Read only the selected epic-scoped story or bugfix under `docs/epics/active/<epic>/story_*.md` or `docs/epics/active/<epic>/bugfix_*.md`, or the selected standalone story or bugfix under `docs/standalone-changes/active/story_*.md` or `docs/standalone-changes/active/bugfix_*.md`.
   - Derive epic context from the selected item, not from the broader actionable list: for epic-scoped paths, read the sibling `docs/epics/active/<epic>/epic.md`; for standalone paths, treat `Epic: N/A` as authoritative unless the selected artifact says otherwise.
   - For epic-scoped work, read the selected artifact's parent `epic.md`, its source Product Vision when present, and relevant `docs/knowledge/` concern specs.
   - For standalone work, read `docs/vision.md` when present, active epics only when the selected artifact's routing, placement, or regression scope depends on them, sibling standalone changes, and relevant `docs/knowledge/` concern specs.
   - Check repository status and avoid overwriting unrelated user changes.
   - Extract requirements, expected behavior, unchanged behavior, constraints, implementation tasks, verification steps, and out-of-scope behavior.

3. Resolve blocking ambiguity:
   - Use repository context, planning artifacts, concern specs, documentation, code, logs, and tests before asking the user.
   - Ask before coding when ambiguity affects scope, design, verification strategy, sequencing, ownership, or artifact meaning.
   - Proceed with a stated assumption when ambiguity is non-blocking, and record it in implementation notes or the selected story or bugfix.

4. Implement task by task:
   - Work through the selected story or bugfix's `Implementation Tasks` in dependency order unless a clearly stated adjustment is required.
   - For bugfixes, add or confirm reproduction coverage before changing the fix path unless the bugfix explains why deterministic reproduction is not practical.
   - Follow repository patterns, naming, architecture, and test conventions.
   - Keep changes limited to the selected story or bugfix unless a discovered dependency is required.
   - Update implementation task checkboxes only when implementation work is complete and task-level verification has passed.
   - If the selected story or bugfix cannot be implemented as written, stop and propose a story, bugfix, or epic edit before coding an alternative.
   - Use `document-decisions` when implementation exposes an important durable decision not already dictated by the plan or existing conventions.

5. Handle plan drift explicitly:
   - Treat the selected story or bugfix file as the source of truth, plus `epic.md` for epic-scoped work.
   - If implementation discovers an impossible, contradictory, obsolete, or materially risky requirement, stop affected work.
   - Propose a concrete edit to the owning artifact and wait for approval before implementing materially different behavior.

6. Verify while building:
   - Run focused tests, linters, type checks, migrations, or build commands tied to the changed area.
   - Record commands and outcomes for `validate-implementation`.
   - Add or update tests according to the selected story or bugfix's verification matrix.
   - After each implementation task, compare the implementation against the extracted checklist and fill missing requirements before moving on.

7. Reconcile before reporting:
   - Review the selected story or bugfix, relevant concern specs, and `epic.md` when the work is epic-scoped against the implementation.
   - Fix implementation gaps that are still within the written plan.
   - Raise any remaining mismatch that changes scope, success criteria, or durable design intent.

8. Report result:
   - Update the selected story or bugfix to `State: Review` and `Blocked By: N/A` when the implementation attempt is ready for validation.
   - Summarize completed implementation tasks, modified files, commands run, failures, assumptions, plan drift, and remaining work.
   - Recommend `validate-implementation` when implementation is ready for full verification.

## Validation Checklist

- [ ] Work matches the selected story or bugfix and its selected placement.
- [ ] Exactly one story or bugfix was selected before epic, standalone, or implementation context was loaded.
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
