---
name: document-current-system
description: Document the current system by extracting knowledge from code, docs, configuration, and validation evidence, then updating living concern specs under `docs/knowledge`. Use when an existing system needs to become easier to understand or when implementation changes with `Pass` validation, or explicitly approved `Partial` validation, should become durable knowledge.
---

# Document Current System

## Core Rule

Document living system knowledge from repository evidence. Extract what is true now from code, tests, migrations, configuration, docs, operational artifacts, and implementation evidence with `Pass` validation, or explicitly approved `Partial` validation, so future agents and engineers do not need to replay feature history. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Knowledge Concerns

Use these concerns as the routing map for every fact added to `docs/knowledge`:

- `product`: capabilities, features, user value, and product behavior.
- `platform`: reusable services, shared libraries, internal platforms, and developer-facing capabilities.
- `engineering`: code organization, naming, style, test patterns, tooling, and contributor workflow.
- `architecture`: components, flows, boundaries, interfaces, dependencies, and patterns.
- `security`: authentication, authorization, data protection, privacy, audit, and threat controls.
- `operations`: monitoring, alerts, runbooks, SLOs, support procedures, and failure handling.
- `infrastructure`: environments, networks, databases, queues, storage, compute, and managed resources.

## Ownership Rules

Use one primary concern per fact. Cross-reference related concerns only when that relationship helps future maintainers.

- `product` owns what users can do, what value they get, and what behavior they experience.
- `platform` owns reusable internal capabilities offered to other modules, services, teams, or features.
- `engineering` owns how contributors work in the codebase: naming, style, file organization, tests, tooling, and local or CI workflow.
- `architecture` owns runtime structure: components, boundaries, interfaces, dependencies, data flows, and system patterns.
- `security` owns protection rules: identity, permissions, data protection, privacy, audit, abuse prevention, and threat controls.
- `operations` owns running and supporting the system: monitoring, alerts, runbooks, SLOs, incident response, recovery, and support procedures.
- `infrastructure` owns provisioned runtime resources: environments, networks, compute, databases, queues, storage, and managed services.

Tie-breakers:

- Platform vs architecture: use `platform` for reusable capability contracts; use `architecture` for runtime relationships and system boundaries.
- Engineering vs architecture: use `engineering` for contributor conventions; use `architecture` for design constraints that shape runtime structure.
- Operations vs infrastructure: use `operations` for procedures and signals; use `infrastructure` for resources and environments.
- Security vs other concerns: use `security` for protection rules, then cross-reference the affected product, architecture, operations, or infrastructure document when useful.

## Workflow

1. Load evidence:
   - Read relevant `docs/prd/<feature>.md`, `docs/epics/active/<epic>/epic.md`, and `docs/epics/active/<epic>/tasks.md` when present.
   - Inspect implemented code, migrations, configuration, docs, tests, scripts, CI, deployment, and operational artifacts.
   - Read existing concern specs under `docs/knowledge/`.

2. Classify knowledge:
   - Assign each durable fact to one explicit concern before writing it.
   - Prefer the concern that owns how future maintainers should use the fact.
   - If a fact affects multiple concerns, record the primary fact once and cross-reference the related concern instead of duplicating content.
   - Ignore concerns that have no durable facts in the inspected evidence.

3. Update concern specs:
   - Record only current system state, not project history or planned future work.
   - For each identified concern, create or update one corresponding document under `docs/knowledge/<concern>/`.
   - Update existing concern documents when they already cover the topic; create a new topic document only when no existing document owns the knowledge.
   - Capture naming conventions, code conventions, folder/module boundaries, interface contracts, and testing conventions when they are observable from the codebase.
   - Preserve useful existing knowledge and correct stale knowledge when evidence supports it.

4. Write or update files:
   - Use `docs/knowledge/<concern>/` paths.
   - Use the matching concern template for new concern specs:
     - `product`: [references/product-template.md](references/product-template.md)
     - `platform`: [references/platform-template.md](references/platform-template.md)
     - `engineering`: [references/engineering-template.md](references/engineering-template.md)
     - `architecture`: [references/architecture-template.md](references/architecture-template.md)
     - `security`: [references/security-template.md](references/security-template.md)
     - `operations`: [references/operations-template.md](references/operations-template.md)
     - `infrastructure`: [references/infrastructure-template.md](references/infrastructure-template.md)
   - Keep each spec scannable and grounded in code or operational references.
   - Put repository naming and code conventions in `docs/knowledge/engineering/conventions.md` by default; use `docs/knowledge/architecture/<topic>.md` when the convention defines architecture, module ownership, or cross-system contracts.

5. Report result:
   - Summarize identified concerns, created or updated documents, evidence used, unresolved knowledge gaps, and recommended next skill.

## Validation Checklist

- [ ] Updates are based on repository evidence and `Pass` validation, or explicitly approved `Partial` validation, when present.
- [ ] Specs describe current system state, not planned future work.
- [ ] Every added fact is routed to an explicit concern.
- [ ] Each identified concern created or updated a corresponding document.
- [ ] Naming and code conventions were captured when they are part of the current system state.
- [ ] Code, config, docs, or validation evidence is linked where useful.
