---
name: validate-epic
description: Validate one active epic plan against its source Product Vision before suggesting or adding stories or bugfixes. Use after `create-epic` and before `suggest-stories`, `add-story`, or `add-bugfix` to confirm the epic fits the Product Vision, is end-to-end, avoids unapproved scope, is not too technical, and is ready for child work.
---

# Validate Epic

## Core Rule

Validate one epic plan against the written Product Vision, not memory. Confirm the epic preserves current Product Vision intent for its selected focus, owns a clear end-to-end outcome, avoids contradictions or unapproved scope, stays high-level enough for planning, and is ready to accept stories and bugfixes. Do not validate whether the whole Product Vision is covered by all epics; use `suggest-epics` for Product Vision decomposition and gap discovery. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load validation context:
   - Read the source `docs/vision.md`.
   - Read exactly one target `docs/epics/active/<epic>/epic.md` file.
   - Read relevant `docs/knowledge/<concern>/` specs and existing active epics only when they affect this epic's scope, sequencing, ownership, overlap, or risk.

2. Validate epic fit:
   - Check that the epic outcome maps back to Product Vision intent and to the epic's stated `Product Vision Coverage Role`.
   - Check that the epic covers one end-to-end delivery outcome rather than a technical layer, component-only task bucket, or low-level implementation plan.
   - Check that the epic is broad enough to deliver usable value but narrow enough for child stories and bugfixes to be planned independently.
   - Check that dependencies, sibling-epic relationships, overlap, and sequencing are explicit where they affect this epic.
   - For each important durable decision with enough rationale, use `document-decisions` before child story or bugfix planning proceeds. If the decision is only a candidate, record it as an ADR candidate or validation gap instead of forcing an ADR.

3. Validate Product Vision coverage:
   - Check that owned, partially supported, and intentionally uncovered Product Vision items are explicit and accurate for this epic.
   - Check that the epic does not falsely claim ownership of Product Vision items that belong to another epic or remain undecided.
   - Record gaps only when they affect this epic's correctness, scope boundary, or readiness. Broader Product Vision gaps should be referred to `suggest-epics`.

4. Validate consistency:
   - Check that the epic does not contradict the Product Vision, relevant existing epics, or current concern knowledge.
   - Check that the epic does not add unapproved scope, low-level implementation commitments, or success criteria. High-level implementation strategy is expected when it stays within Product Vision intent.
   - Record inconsistencies, missing coverage, stale Product Vision references, missing ADRs, and blocking open questions.

5. Update epic validation status:
   - Add or update the validation section in the target epic file.
   - Record coverage evidence, gaps, skipped checks, and a decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
   - Do not create story or bugfix files; child planning belongs to `suggest-stories`, `add-story`, and `add-bugfix`.

6. Report result:
   - Summarize validation outcome, this epic's Product Vision fit, inconsistencies, blocking open questions, and ADRs created.
   - Recommend `suggest-stories` when the epic result is `Pass` and the next story has not been chosen.
   - Recommend `add-story` or `add-bugfix` when the epic result is `Pass` and the requested child work is already specific.
   - Recommend `create-epic` edits for this epic's gaps or `suggest-epics` for broader Product Vision decomposition gaps.

## Validation Checklist

- [ ] Exactly one target epic was validated.
- [ ] The target epic maps to the Product Vision and has an accurate `Product Vision Coverage Role`.
- [ ] The target epic is end-to-end and not too technical.
- [ ] The target epic does not overclaim whole Product Vision coverage.
- [ ] The target epic is consistent with the Product Vision, relevant existing epics, and relevant concern specs.
- [ ] Dependencies, overlap, and sequencing that affect this epic are explicit.
- [ ] Blocking open questions are resolved or recorded as `Blocked`.
- [ ] ADRs are created through `document-decisions` only for important durable decisions and linked where relevant.
- [ ] Result includes a decision for the target epic: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] A passing epic can accept stories and bugfixes.
