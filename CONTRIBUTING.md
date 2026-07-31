# Contributing to AzAdmin

Thank you for helping build AzAdmin.

## Before contributing

Read:

- `README.md`
- `docs/architecture/frontend-implementation-rules.md`
- `docs/workflow/git-workflow.md`
- `docs/workflow/documentation-workflow.md`
- `CODE_OF_CONDUCT.md`

## Original implementation requirement

Do not copy source code, HTML structure, CSS, JavaScript, proprietary assets, or unique component markup from another admin panel. Screenshots may be used only to identify requirements and compare general UX patterns. Every AzAdmin implementation must be written from scratch.

## Branch naming

Use one focused branch:

```text
feature/<scope>
fix/<scope>
refactor/<scope>
docs/<scope>
chore/<scope>
test/<scope>
```

Examples:

```text
feature/vertical-sidebar
feature/design-token-foundation
fix/mobile-navigation-focus
chore/project-foundation
```

## Commit messages

Use Conventional Commits:

```text
feat: add vertical sidebar layout
fix: correct mobile navigation focus order
docs: document HTMX fragment contract
refactor: simplify semantic color tokens
chore: initialize project foundation
```

## Required implementation standards

Every contribution must:

- Use semantic HTML
- Begin with mobile defaults outside media queries
- Use only the canonical `48rem`, `64rem`, and `90rem` `min-width` layers
- Avoid `max-width` media-query conditions
- Use design tokens backed by `rem`
- Keep the browser root font size unchanged
- Use logical CSS properties
- Support LTR and RTL from one markup structure
- Use CSS Grid for structural layout
- Keep DOM depth justified and minimal
- Prefer native HTML/CSS to JavaScript
- Preserve keyboard and screen-reader behavior
- Provide touch targets of at least `3rem × 3rem`
- Use simple relative asset paths
- Keep each substantial component or page section in its own CSS file

## Documentation requirement

Every meaningful step must include or update an archive note under:

```text
docs/archive/
```

The note records scope, architecture decisions, changed files, tests, branch, commit, pull request title, limitations, and the next step.

A linked Obsidian version is also maintained for the project second brain.

## Checks

Run:

```bash
./scripts/check-project.sh
```

Resolve every failure before requesting review.

## Pull requests

A pull request should:

- Solve one focused problem
- Explain why the change is necessary
- Include screenshots for visual changes
- Document JavaScript only when it is justified
- Include RTL, theme, responsive, and accessibility checks
- Update the archive note
- Avoid unrelated formatting changes

## Review criteria

Reviewers verify:

- Semantics
- Accessibility
- Mobile-first behavior
- Logical direction support
- Token usage
- DOM depth
- JavaScript necessity
- HTMX fragment safety
- WebAssembly-compatible state contracts
- Original implementation compliance
