---
name: archive-epic
description: Preserve completed epic history by moving an active epic and its final artifacts into `docs/epics/archived`. Use when implementation, validation, and system-state updates are complete or when an epic is intentionally closed.
---

# Archive Epic

## Core Rule

Archive only when the epic has a clear final state. Archive preserves traceability after validated work and knowledge updates, without replacing current-state concern specs. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Review readiness:
   - Read the active epic, tasks and validation result, concern spec updates, and related ADRs.
   - Confirm all required tasks are done, intentionally deferred, or explicitly cancelled.
   - Confirm system state has been updated when implementation changed durable behavior.

2. Finalize history:
   - Write an archive summary with outcome, shipped behavior, validation evidence, ADRs, concern specs updated, deferred work, and closure reason.
   - Use [references/archive-summary-template.md](references/archive-summary-template.md).
   - Update artifact statuses where appropriate.

3. Move epic:
   - Move `docs/epics/active/<epic>/` to `docs/epics/archived/<epic>/`.
   - Preserve all files and links where possible.
   - If moving files is risky or the user only wants a draft, write the summary and ask before moving.

4. Report result:
   - Provide the archived epic path.
   - Summarize outcome, deferred work, and any remaining risks.

## Validation Checklist

Completed epics:

- [ ] Final state and closure reason are clear.
- [ ] Validation result is `Pass`, or a `Partial` result was explicitly approved for closure.
- [ ] Durable system changes are reflected in concern specs.
- [ ] ADRs are linked where relevant.
- [ ] Archived artifacts preserve useful implementation history.

Cancelled or superseded epics:

- [ ] Closure reason explains why implementation or validation did not complete.
- [ ] Deferred, cancelled, or superseded work is explicit.
- [ ] Any durable decisions or knowledge that remain true are linked or updated.
- [ ] Archived artifacts preserve useful planning and closure history.
