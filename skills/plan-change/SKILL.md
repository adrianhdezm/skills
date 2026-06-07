---
name: plan-change
description: Decide the correct Cortex planning path for one concrete incoming change request. Use when a request may be too small for an epic, may belong to an active epic, may be a bugfix, or may require a new epic before story or bugfix planning.
---

# Plan Change

## Core Rule

Route exactly one concrete change request to the correct Cortex planning path before writing story, bugfix, or epic artifacts. Prefer the smallest durable artifact that preserves planning quality: an epic-scoped story or bugfix when the change belongs to an active epic, a standalone change when it is self-contained and outside active epic scope, or a new epic when coordination or risk requires one. If the request changes durable product direction, recommend `define-product-vision` before routing continues; do not treat Product Vision updates as a `plan-change` route. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load routing context:
   - Read `docs/vision.md` when present.
   - Read active epics under `docs/epics/active/`, including existing `story_*.md` and `bugfix_*.md` files when they affect fit.
   - Read existing standalone changes under `docs/standalone-changes/active/`.
   - Inspect relevant `docs/knowledge/`, code, tests, docs, issues, logs, or designs enough to classify the request.

2. Classify the request:
   - Use story routing for planned value, desired behavior, product/system improvement, docs behavior, migration behavior, or operational capability.
   - Use bugfix routing for defective behavior, regression, failing test, incident follow-up, or incorrect current behavior that needs root cause and regression preservation.
   - If the request mixes unrelated value and defect work, stop and ask the user to choose one concrete change first.

3. Decide placement:
   - Route to an active epic when the request directly advances that epic's outcome, scope, acceptance strategy, rollout, or defect correction.
   - Route to `docs/standalone-changes/active/` when the request is small or independent, does not fit a current active epic, does not require multiple coordinated stories or bugfixes, and does not materially change Product Vision direction.
   - Route to `create-epic` when the request needs multiple coordinated work items, a rollout or backout plan, cross-cutting ownership, material risk tracking, sequencing across areas, or a new end-to-end delivery outcome.
   - If the request changes durable product direction, audience, goals, success signals, principles, constraints, or non-goals before planning can be safe, stop routing and recommend `define-product-vision`.

4. Produce the routing decision:
   - State the route: `create-epic`, `add-story`, or `add-bugfix`.
   - If Product Vision work is needed first, state that no route is selected yet and recommend `define-product-vision`.
   - State placement when the route is `add-story` or `add-bugfix`: active epic path or standalone change path.
   - List active epics checked and why each is a fit or not a fit.
   - Record Product Vision impact, risk level, assumptions, open questions, and why an epic is or is not needed.
   - If the user asked to proceed and no blocking ambiguity remains, continue with the selected skill workflow.

5. Report result:
   - Provide the recommended next skill and target path shape.
   - Summarize classification, placement, active epic fit, Product Vision impact, assumptions, and any blocking questions.

## Routing Checklist

- [ ] Exactly one concrete incoming change was routed.
- [ ] Story versus bugfix classification is explicit.
- [ ] Active epic fit was checked before choosing standalone placement.
- [ ] Product Vision impact was checked before story, bugfix, or epic routing, and `define-product-vision` was recommended instead of routed when Product Vision work was needed first.
- [ ] Epic need was evaluated against coordination, rollout, risk, sequencing, and outcome scope.
- [ ] Standalone routing includes the reason no active epic or new epic is needed.
- [ ] The next skill and target path shape are explicit.
