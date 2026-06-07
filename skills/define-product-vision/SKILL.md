---
name: define-product-vision
description: Define the project-level product vision by turning product intent, problems, or business requests into one durable `docs/vision.md` file. Use when starting Cortex planning, establishing the shared product direction, or updating the single product vision before change or epic planning.
---

# Define Product Vision

## Core Rule

Maintain exactly one Product Vision per project at `docs/vision.md`. It is the stable project-level source of truth for why the product exists, who it serves, what outcomes matter, and what constraints shape delivery. The required flow is `define-product-vision -> plan-change optional -> suggest-epics optional -> create-epic -> validate-epic -> suggest-stories optional -> add-story or add-bugfix -> validate-work-plan`; use `plan-change` for concrete incoming requests with unclear placement and `suggest-epics` when the user needs brainstorming, vision slicing, or gap discovery. Epics and standalone changes drive specific changes; the Product Vision should change only when the durable product direction changes. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Gather product intent:
   - Ask for the problem or opportunity, target users, durable success outcome, constraints, non-goals, deadlines, known solution ideas, and whether the Product Vision covers only the MVP or future phases too.
   - Ask whether meeting notes, stakeholder briefs, designs, pictures, previous conversations, inspiration products, or other references should inform the Product Vision.
   - Ask what concerns may be affected: product, platform, engineering, architecture, security, operations, or infrastructure.
   - If the request is vague, ask the smallest set of questions needed to make planning possible.

2. Inspect existing context:
   - Read the existing `docs/vision.md` when present.
   - Read `docs/knowledge/` and active epics when present.
   - Read project documentation when present.
   - Explore relevant routes/pages, domain models, API boundaries, auth or permission patterns, tests, adjacent UI flows, jobs, events, and integrations.
   - Surface contradictions between user input, reference material, documentation, code, or concern knowledge before drafting.
   - If `docs/vision.md` already exists and the request does not change durable project direction, leave it intact and recommend `plan-change`, `suggest-epics`, or `create-epic` instead.

3. Bound product intent:
   - Capture vision, problem, audience, goals, success signals, principles, constraints, non-goals, assumptions, open questions, and references.
   - Keep the Product Vision strategic. Do not add user stories, EARS acceptance criteria, detailed feature scope, suspected surfaces, implementation strategy, verification strategy, dependencies, rollout, or risk registers.
   - Leave epic options to `suggest-epics`, delivery scope to `create-epic`, and executable acceptance and verification detail to story or bugfix artifacts.
   - Ask before finalizing product decisions that materially affect direction, priority, risk, or ownership.

4. Check vision quality before planning:
   - Check the bounded Product Vision for logical inconsistencies, ambiguous product terms, conflicting constraints, unclear audience, unclear success signals, and hidden implementation commitments.
   - For design-informed inputs, separate required product direction from suggested implementation details and record unapproved behavior as an assumption or open question.
   - Resolve blocking gaps before recommending `plan-change`, `create-epic`, or `suggest-epics`; record non-blocking gaps as assumptions or open questions in the Product Vision.

5. Write the Product Vision:
   - Ensure `docs/` exists.
   - Create or update only `docs/vision.md`; do not create feature-specific vision files or additional product vision documents.
   - If `docs/vision.md` exists, preserve stable content and make the smallest update needed for the changed product direction.
   - Use [references/product-vision-template.md](references/product-vision-template.md) and fill every section.
   - Scale Product Vision depth to project complexity while keeping every section useful.

6. Report result:
   - Provide the absolute Product Vision path.
   - Summarize vision quality findings, blocking questions, recorded assumptions, and recommend `plan-change` for a concrete incoming request, `create-epic` when the user already knows the target outcome, or `suggest-epics` when epic options need to be discovered.

## Validation Checklist

- [ ] Product vision, problem, audience, goals, success signals, constraints, non-goals, and references are captured.
- [ ] Exactly one Product Vision path is used: `docs/vision.md`.
- [ ] Vision quality checked inconsistencies, ambiguity, conflicting constraints, unclear audience, unclear success signals, and hidden implementation commitments.
- [ ] Relevant concern knowledge, active work, docs, modules, routes, and tests were inspected.
- [ ] Contradictions or ambiguous decisions were resolved with the user.
- [ ] Downstream epic, story, bugfix, implementation, and verification details are excluded.
- [ ] Assumptions and open questions are explicit.
- [ ] The Product Vision can feed `plan-change`, `create-epic`, or `suggest-epics` without rediscovering core behavior.
