---
name: write-a-prd
description: Create implementation-ready product requirement documents by turning product ideas into scoped engineering plans with user stories, routes, implementation decisions, and testing decisions. Use when the user asks to draft a PRD, formalize feature requirements, or turn a product idea into a scoped engineering plan in the repo.
---

# Write A PRD

## Core Rule

Ground every PRD in both product intent and local repository context. Ask when ambiguity blocks implementation; when ambiguity remains but is not blocking, make a clear assumption and record it in the PRD.

## Workflow

1. Gather product context:
   - Ask for the problem, target users, success outcome, constraints, non-goals, known solution ideas, and whether the PRD should cover only the MVP or future phases too.
   - Ask whether meeting notes, stakeholder briefs, designs, pictures, previous conversations, inspiration products, or other references should inform the PRD.
   - If the idea is rough, ask the smallest useful set of follow-up questions before drafting.

2. Inspect the repository:
   - Read project documentation inside `docs/` when present.
   - Explore relevant routes/pages, domain models, API boundaries, auth or permission patterns, tests, and adjacent UI flows to validate assumptions.
   - Prefer local repository context over remote trackers or repository workflows unless the user explicitly asks.

3. Resolve design decisions:
   - Walk through design branches, dependencies, and tradeoffs until implementation decisions are concrete.
   - Surface contradictions between user input, reference material, documentation, or code, and ask the user to resolve them before proceeding.
   - Record rejected alternatives only when they affect implementation.

4. Define pages and navigation:
   - Propose every route or screen with a short goal statement.
   - If the feature has no UI, replace pages with surfaces and entry points such as APIs, CLIs, jobs, events, or integrations.
   - Include key UI elements without prescribing visual design.
   - Document primary entry points and navigation relationships.
   - Ask before deciding when the page breakdown is ambiguous.

5. Define implementation and testing direction:
   - Identify modules to build or modify, important interfaces, schema/API changes, and interaction rules.
   - Favor deep modules with simple, stable interfaces.
   - Confirm open module and testing decisions with the user before finalizing.

6. Write the PRD:
   - Ensure a `docs/prd/` folder exists at the repository root.
   - Use a concise kebab-case filename, such as `docs/prd/checkout-discounts.md`, unless the user provides one.
   - If the target file already exists, ask before overwriting unless the user explicitly requested an update.
   - Use the template in [references/prd-template.md](references/prd-template.md) and fill every section.
   - Scale PRD depth to feature complexity; keep small changes concise while still filling every section.
   - After writing, report the absolute file path and summarize remaining assumptions.

## Validation Checklist

- [ ] Product problem, users, goals, constraints, non-goals, and reference materials are captured.
- [ ] Relevant local docs, modules, routes, and tests were inspected.
- [ ] Contradictions or ambiguous decisions were resolved with the user.
- [ ] Pages, navigation, non-UI surfaces, implementation decisions, and testing decisions are concrete enough to build.
- [ ] Non-blocking assumptions and unresolved questions are recorded in the PRD.
- [ ] An engineer can start implementation without rediscovering core product behavior.
- [ ] The PRD lives in `docs/prd/`, uses Markdown, and fills every template section.
