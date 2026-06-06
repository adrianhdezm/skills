---
name: validate-epics
description: Validate epic plans against their source PRD before task creation. Use after `create-epics` and before `create-tasks` to confirm every current PRD goal and acceptance criterion is covered, epics are consistent, and no blocking open questions remain.
---

# Validate Epics

## Core Rule

Validate epic plans against the written PRD, not memory. Confirm the epics preserve current PRD intent, cover all required outcomes, avoid contradictions or unapproved scope, and are ready to feed `create-tasks`. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load validation context:
   - Read the source `docs/prd/<feature>.md`.
   - Read every related `docs/epics/active/<epic>/epic.md`.
   - Read relevant `docs/knowledge/<concern>/` specs and active epics when they affect scope, sequencing, ownership, or risk.

2. Validate PRD coverage:
   - Check that every current PRD goal, user story, constraint, non-goal, and acceptance criterion is owned by at least one epic or explicitly deferred.
   - Check that each epic outcome maps back to PRD intent.
   - Check that cross-epic dependencies and sequencing are explicit.
   - For each important durable decision with enough rationale, use `document-decisions` before task planning proceeds. If the decision is only a candidate, record it as an ADR candidate or validation gap instead of forcing an ADR.

3. Validate consistency:
   - Check that epics do not contradict the PRD, each other, or current concern knowledge.
   - Check that epics do not add unapproved scope, low-level implementation commitments, or success criteria. High-level implementation strategy is expected when it stays within PRD intent.
   - Record inconsistencies, missing coverage, stale PRD references, missing ADRs, and blocking open questions.

4. Update epic validation status:
   - Add or update a validation section in the affected epic files.
   - Record coverage evidence, gaps, skipped checks, and a decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
   - Do not create `tasks.md`; task sequencing belongs to `create-tasks`.

5. Report result:
   - Summarize validation outcome, PRD coverage gaps, inconsistencies, blocking open questions, and ADRs created.
   - Recommend `create-tasks` when the result is `Pass`; otherwise recommend the specific artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Every current PRD goal and acceptance criterion is covered, deferred, or marked as a gap.
- [ ] Epics are consistent with the PRD, each other, and relevant concern specs.
- [ ] Cross-epic dependencies and sequencing are explicit.
- [ ] Blocking open questions are resolved or recorded as `Blocked`.
- [ ] ADRs are created through `document-decisions` only for important durable decisions and linked where relevant.
- [ ] Result includes an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] Passing epics can feed `create-tasks`.
