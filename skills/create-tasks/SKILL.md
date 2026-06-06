---
name: create-tasks
description: Break one epic plan into small implementation tasks with task-level and acceptance verification in `docs/epics/active/<epic>/tasks.md`. Use when a single active epic needs sequenced, reviewable units and verification checks before code changes start.
---

# Create Tasks

## Core Rule

Create tasks for exactly one epic after `validate-epics` returns `Pass` for that epic. The required flow is `create-prd -> create-epics -> validate-epics -> create-tasks per epic -> validate-tasks`. `tasks.md` owns execution breakdown, task-level verification, acceptance verification against the PRD and that epic, and final validation status. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - Read one `docs/epics/active/<epic>/epic.md` and its source `docs/prd/<feature>.md`.
   - Inspect relevant code, tests, migrations, configuration, docs, and operational files.

2. Break down work:
   - Sequence tasks by dependency and risk.
   - Include code, test, migration, documentation, observability, rollout, and cleanup tasks where relevant.
   - Add verification instructions and pass criteria to every task.
   - Add acceptance verification rows for the PRD goals and acceptance criteria this epic is responsible for.
   - Do not introduce new scope, implementation strategy, or success criteria without suggesting updates to the owning PRD or epic artifact.
   - Keep tasks concrete, with file or module hints when known.

3. Write tasks:
   - Write `docs/epics/active/<epic>/tasks.md`.
   - Use [references/tasks-template.md](references/tasks-template.md).

4. Report result:
   - Provide the absolute tasks path.
   - Summarize first implementation task, dependencies, assumptions, and recommend `validate-tasks`.

## Validation Checklist

- [ ] Tasks are ordered and independently reviewable.
- [ ] Every major epic plan decision has implementation work or an explicit no-op.
- [ ] Every task includes verification and pass criteria.
- [ ] Every PRD goal or acceptance criterion owned by this epic has an acceptance verification row.
- [ ] Rollout, migration, documentation, and cleanup are included when relevant.
- [ ] The task list can feed `validate-tasks`.
