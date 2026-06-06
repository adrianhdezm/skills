---
name: create-prd
description: Define why work exists by turning ideas, problems, or business requests into implementation-ready PRDs under `docs/prd`. Use when starting planned work, drafting a PRD, formalizing feature requirements, or converting an unstructured request into a concern-centric system evolution input.
---

# Create PRD

## Core Rule

Ground every PRD in product intent, local repository context, and concern knowledge. The required flow is `create-prd -> create-epics -> validate-epics -> create-tasks per epic -> validate-tasks`; do not skip the epic slicing step or validation gates. Features drive change; the PRD defines why the feature should exist, not the final implementation or verification strategy. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Gather product intent:
   - Ask for the problem or opportunity, target users, success outcome, constraints, non-goals, deadlines, known solution ideas, and whether the PRD covers only the MVP or future phases too.
   - Ask whether meeting notes, stakeholder briefs, designs, pictures, previous conversations, inspiration products, or other references should inform the PRD.
   - Ask what concerns may be affected: product, platform, engineering, architecture, security, operations, or infrastructure.
   - If the request is vague, ask the smallest set of questions needed to make planning possible.

2. Inspect existing context:
   - Read `docs/knowledge/` and active epics when present.
   - Read project documentation when present.
   - Explore relevant routes/pages, domain models, API boundaries, auth or permission patterns, tests, adjacent UI flows, jobs, events, and integrations.
   - Surface contradictions between user input, reference material, documentation, code, or concern knowledge before drafting.

3. Bound product intent:
   - Capture user stories, success criteria, constraints, non-goals, and affected concerns.
   - Mention suspected pages, surfaces, or entry points only as product context.
   - Leave final modules, APIs, routes, schemas, implementation strategy, and verification strategy to Plan artifacts.
   - Ask before finalizing product decisions that materially affect scope, sequencing, risk, or ownership.

4. Write the PRD:
   - Ensure `docs/prd/` exists.
   - Use a concise kebab-case filename such as `docs/prd/improve-checkout-retries.md`, unless the user provides a name.
   - If the file exists, ask before overwriting unless the user explicitly requested an update.
   - Use [references/prd-template.md](references/prd-template.md) and fill every section.
   - Scale PRD depth to feature complexity while keeping every section useful.

5. Report result:
   - Provide the absolute PRD path.
   - Summarize blocking questions, recorded assumptions, and recommend `create-epics`.

## Validation Checklist

- [ ] Product problem, users, goals, constraints, non-goals, and references are captured.
- [ ] Relevant concern knowledge, active work, docs, modules, routes, and tests were inspected.
- [ ] Contradictions or ambiguous decisions were resolved with the user.
- [ ] Suspected pages or non-UI surfaces are product context, not final design.
- [ ] Affected concerns, assumptions, and open questions are explicit.
- [ ] The PRD can feed `create-epics` without rediscovering core behavior.
