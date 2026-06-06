---
name: validate-tasks
description: Validate task plans against their corresponding epic before implementation. Use after `create-tasks` and before `implement-tasks` to confirm every epic topic is covered by tasks, task verification is complete, and no inconsistencies or blocking open questions remain.
---

# Validate Tasks

## Core Rule

Validate tasks against the written epic and source PRD, not memory. Confirm `tasks.md` covers the epic completely, has executable verification for each task, includes acceptance verification for owned PRD criteria, and is ready to feed `implement-tasks`. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load validation context:
   - Read one `docs/epics/active/<epic>/epic.md`.
   - Read its `docs/epics/active/<epic>/tasks.md`.
   - Read the source `docs/prd/<feature>.md` and relevant concern specs when they affect task coverage or verification.

2. Validate epic coverage:
   - Check that every epic scope item, implementation strategy topic, dependency, risk, rollout item, migration, documentation need, operations concern, security concern, and deferred item is covered by a task or explicit no-op.
   - Check that every PRD goal or acceptance criterion owned by this epic has an acceptance verification row.
   - Check that task sequencing and dependencies match the epic.

3. Validate task quality:
   - Check that every task has purpose, scope, dependencies, verification steps, and pass criteria.
   - Check that verification methods are concrete enough to execute during `run-validation`.
   - Check that tasks do not contradict the epic, expand scope, or leave blocking open questions unresolved.

4. Update task validation status:
   - Update the task plan validation section in `docs/epics/active/<epic>/tasks.md` with evidence, gaps, skipped checks, and a decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
   - Add remediation tasks or notes for missing coverage, unclear verification, or inconsistency.
   - Do not implement code; implementation belongs to `implement-tasks`.

5. Report result:
   - Summarize validation outcome, epic coverage gaps, inconsistent tasks, and blocking open questions.
   - Recommend `implement-tasks` when the result is `Pass`; otherwise recommend the specific artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Every epic topic is covered by a task, explicit no-op, or recorded gap.
- [ ] Every task has concrete verification steps and pass criteria.
- [ ] Acceptance verification rows cover PRD criteria owned by the epic.
- [ ] Task sequencing and dependencies match the epic.
- [ ] Blocking open questions are resolved or recorded as `Blocked`.
- [ ] Result includes an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] Passing tasks can feed `implement-tasks`.
