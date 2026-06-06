---
name: implement-tasks
description: Implement task plans as scoped code, test, migration, documentation, and configuration changes. Use after `validate-tasks` returns `Pass`, or when the user explicitly accepts the risk of implementing an unvalidated or partially validated plan.
---

# Implement Tasks

## Core Rule

Implement the task plan with tight scope, explicit intent, and continuous verification. Normally start only after `validate-tasks` returns `Pass`; if the user explicitly overrides a missing, `Partial`, `Fail`, or `Blocked` validation result, record that risk before coding. Build executes `epic.md` and `tasks.md`; it does not silently redefine scope, implementation strategy, terminology, or success criteria. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load the plan:
   - Read `docs/epics/active/<epic>/epic.md` and `docs/epics/active/<epic>/tasks.md`.
   - Confirm `tasks.md` passed `validate-tasks`, or record the user's explicit override and the risk of implementing an unvalidated or partially validated plan.
   - Read relevant `docs/knowledge/` concern specs.
   - Check repository status and avoid overwriting unrelated user changes.
   - Extract a working checklist of requirements, acceptance criteria, constraints, task verification steps, and explicitly out-of-scope behavior.

2. Resolve blocking ambiguity:
   - Identify anything ambiguous, underspecified, contradictory, or risky enough to affect scope, design, verification strategy, sequencing, ownership, or artifact meaning.
   - Use repository context, existing planning artifacts, concern specs, documentation, and code before asking the user.
   - Ask for clarification before coding when ambiguity blocks implementation quality.
   - Proceed with a stated assumption when ambiguity is non-blocking, and record the assumption in implementation notes or the relevant artifact.

3. Implement task by task:
   - Work through tasks and task sections in the order defined by `tasks.md` unless dependency ordering requires a clearly stated adjustment.
   - Before coding a requirement, confirm the reason for the requirement from the plan, PRD context, concern specs, or existing product behavior.
   - Follow repository patterns, naming, architecture, and test conventions.
   - Match plan terminology in code where it fits existing project conventions, including type names, function names, module boundaries, user-facing labels, and test names.
   - Prefer names and boundaries that make intent visible. Add brief comments only when a non-obvious constraint or tradeoff would otherwise be hidden.
   - Isolate decisions likely to change behind existing boundaries or narrow interfaces; do not hardwire assumptions the plan does not guarantee.
   - Keep changes limited to planned tasks unless a discovered dependency is required.
   - Update task checkboxes only when implementation work is genuinely complete and its task-level verification has passed. Final acceptance remains in `Final Validation` and `Validation Result`.
   - If the plan prescribes a specific approach that cannot be implemented as written, stop and ask to update the plan before coding an alternative.
   - If the plan leaves an important durable design choice open and multiple viable approaches exist, use `document-decisions` before proceeding. Do not write ADRs for decisions already dictated by the plan, existing conventions, or a single viable option.

4. Handle plan drift explicitly:
   - Treat `epic.md` and `tasks.md` as the implementation source of truth.
   - If a requirement is impossible, contradictory, obsolete, or produces a clearly worse outcome because of discovered repository constraints, stop implementation for that requirement.
   - Propose a concrete edit to `docs/epics/active/<epic>/epic.md` or `docs/epics/active/<epic>/tasks.md` that resolves the divergence, with the reason for the change.
   - Wait for user approval before changing code to match a materially different plan.
   - Do not let code and planning artifacts drift apart silently.

5. Verify while building:
   - Run focused tests, linters, type checks, migrations, or build commands tied to the changed area.
   - Record commands and outcomes for `run-validation`.
   - Add or update tests according to task-level verification in `docs/epics/active/<epic>/tasks.md`.
   - After each task or section, compare the implementation against the extracted checklist and fill any missing requirement before moving on.

6. Reconcile before reporting:
   - Review `epic.md`, `tasks.md`, and relevant concern specs against the implementation.
   - Identify residual mismatches, including terminology drift, undocumented behavior, implicit decisions, missing verification evidence, or partially implemented requirements.
   - Fix implementation gaps when they are still within the written plan.
   - Propose planning artifact edits for any remaining mismatch that changes scope, success criteria, or durable design intent.

7. Report result:
   - Summarize completed tasks, modified files, commands run, failures, assumptions, plan drift, and remaining work.
   - Recommend `run-validation` when implementation is ready for full verification.

## Validation Checklist

- [ ] Work matches `docs/epics/active/<epic>/epic.md` and `docs/epics/active/<epic>/tasks.md`.
- [ ] Task plan validation status was checked.
- [ ] Requirements, acceptance criteria, constraints, and verification steps were extracted before implementation.
- [ ] Blocking ambiguities were resolved before coding affected requirements.
- [ ] Repository conventions were followed.
- [ ] Plan terminology was preserved where compatible with repository conventions.
- [ ] Important durable design choices were documented with `document-decisions` when needed.
- [ ] Relevant tests or checks were run.
- [ ] Task status reflects reality.
- [ ] Any plan drift is corrected, approved, documented, or raised.
- [ ] Final reconciliation found no silent mismatch between plan and implementation.
