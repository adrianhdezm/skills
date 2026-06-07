---
name: document-decisions
description: Capture important design decisions, rationale, consequences, and tradeoffs as ADRs under `docs/adrs`. Use only when a Product Vision, epic plan, standalone change, implementation, validation, or system-state update includes an important durable decision that future maintainers must understand.
---

# Document Decisions

## Core Rule

Write ADRs only for important durable decisions, not routine implementation notes, transient choices, or low-impact preferences. ADRs preserve rationale for choices whose future consequences matter without turning concern specs into history logs. Follow [references/clarification-policy.md](references/clarification-policy.md).

## ADR Criteria

Write ADRs for:

- Architecture choices, including components, boundaries, data models,
  execution models, and API shape.
- Integration strategy, especially how components interact at boundaries.
- Platform contracts that other modules, services, teams, or features depend on.
- Security decisions about authentication, authorization, data protection,
  privacy, audit, abuse prevention, or threat controls.
- Operations and infrastructure decisions about deployment, environments,
  observability, recovery, provisioned resources, or managed services.
- Test isolation or simulation approaches.
- Concurrency or consistency strategies.
- Performance tradeoffs with measurable impact.
- Durable product behavior decisions with long-term user, customer, operator, or
  compatibility consequences.

Do not write ADRs for:

- Choices already dictated by the spec or existing conventions.
- Trivial implementation details, including variable naming and file layout.
- Choices with only one viable option.

## Workflow

1. Identify decision:
   - Read the available phase evidence: Product Vision, `docs/epics/active/<epic>/epic.md` when present, standalone change files when present, story or bugfix files, validation results, relevant concern specs, and implementation evidence when those artifacts already exist.
   - Confirm the decision is important and durable because it affects architecture, data, security, operations, infrastructure, platform contracts, long-term product behavior, or another high-consequence concern.
   - Confirm the decision matches at least one "Write ADRs for" category and none of the "Do not write ADRs for" exclusions.
   - Skip ADR creation when the decision is routine, easily reversible, purely local to one implementation detail, dictated by existing requirements, has only one viable option, or is already obvious from code and current-system docs.
   - If the decision is only a candidate and durable rationale is not yet available, record it in the owning Product Vision, epic, standalone change, story, or bugfix artifact instead of forcing an ADR.

2. Capture rationale:
   - State context, options, decision, consequences, tradeoffs, and follow-up work.
   - Link affected concern specs and code paths.
   - Keep the ADR neutral and factual.

3. Write ADR:
   - Ensure `docs/adrs/` exists.
   - Number ADRs sequentially based on existing ADRs in `docs/adrs/`.
   - Use the next four-digit ADR number and a kebab-case title, such as `docs/adrs/ADR-0007-use-event-driven-sync.md`.
   - Use [references/adr-template.md](references/adr-template.md).

4. Report result:
   - Provide the absolute ADR path.
   - Summarize the decision and any concern specs that should be updated by `document-current-system`.

## Validation Checklist

- [ ] The decision is important, durable, and high-consequence enough to justify an ADR.
- [ ] The decision matches an allowed ADR category from Cortex decision-record policy.
- [ ] Routine, reversible, local, dictated, single-option, or low-impact decisions were not documented as ADRs.
- [ ] Context, options, decision, and consequences are explicit.
- [ ] Affected concerns and evidence are linked.
- [ ] Status is clear.
- [ ] The ADR avoids restating routine code changes.
