# PRD Template

Use this Markdown structure for PRD files.

```markdown
# <Feature Name> PRD

## Problem Statement

Describe the problem from the user's perspective.

## Solution

Describe the solution from the user's perspective.

## Success Criteria

List concrete outcomes that define success for the feature.

## User Stories

Provide enough numbered user stories to cover primary, edge, and failure flows in this format:

1. As an <actor>, I want a <feature>, so that <benefit>

## Pages & Navigation

List every page/route in the application. For each page provide:

- **Route** - the URL path (e.g., `/dashboard`, `/orders/:id`)
- **Goal** - one sentence describing what the user accomplishes on this page
- **Key UI elements** - the major sections or components (e.g., form, table, sidebar filter)
- **Navigates to** - which other pages this page links to

If the feature has no UI, replace this section with `## Surfaces & Entry Points` and list APIs, CLIs, background jobs, events, integrations, or other interaction surfaces.

## Implementation Decisions

Document build/modify modules, interface changes, technical clarifications, architecture decisions, schema changes, API contracts, and key interaction decisions.
Avoid code snippets; mention concrete modules or areas when useful.

## Testing Decisions

Document what makes a good test, prioritizing external behavior over implementation details. Identify what modules to test and relevant prior-art tests in the repo.

## Assumptions

List non-blocking assumptions made while writing the PRD.

## Open Questions

List unresolved questions that remain after drafting, especially questions that may affect scope, sequencing, or implementation details.

## Dependencies

List product, design, engineering, data, third-party, or operational dependencies.

## Risks

List risks, edge cases, rollout concerns, migration concerns, or privacy/security concerns that could affect implementation.

## Out Of Scope

List items explicitly excluded from this PRD.

## Further Notes

Add any additional constraints or context needed for implementation.
```
