# Step 0001 — Project Foundation

## Status

Completed

## Date

2026-07-31

## Objective

Create the initial framework-agnostic AzAdmin repository foundation and establish the standards required before visual component development.

## Branch

```text
chore/project-foundation
```

## Commit

```text
chore: initialize AzAdmin project foundation
```

## Pull request title

```text
chore: initialize AzAdmin project foundation
```

## Scope completed

- Added the public project README
- Added MIT license
- Added changelog, contribution, conduct, and security policies
- Added EditorConfig, Git attributes, and ignore rules
- Added semantic zero-build smoke page
- Created CSS, JavaScript, asset, component, layout, page, example, documentation, and script directories
- Added framework-agnostic architecture documentation
- Added frontend implementation rules
- Added HTMX and WebAssembly integration principles
- Added Git and documentation workflows
- Added GitHub issue and pull-request templates
- Added automated project checks

## Architecture decisions

- The core remains framework-agnostic.
- The project is HTML-first, CSS-powered, and Zero-JS-first.
- CSS classes use `az-*`.
- CSS custom properties use `--az-*`.
- Data attributes use `data-az-*`.
- Custom events use `az:*`.
- One markup structure supports LTR, RTL, and themes.
- Mobile defaults exist outside media queries.
- Only `48rem`, `64rem`, and `90rem` `min-width` layers are allowed.
- Scalable measurements use design tokens backed by `rem`.
- Only one-pixel borders and outlines may use `px`.
- Logical CSS properties are mandatory.
- CSS Grid is the structural layout system.
- DOM depth must be justified and minimal.
- Native HTML and CSS take priority over JavaScript.
- HTMX and WebAssembly compatibility are first-class contracts.
- No code or distinctive structure is copied from other admin panels.
- Framework adapters will be separate repositories or packages.

## JavaScript classification

No runtime JavaScript is required in this step. `assets/js/main.js` is an intentionally empty future progressive-enhancement entry point and is not loaded by `index.html`.

## Checks

- CSS pixel rule: passed
- Physical left/right rule: passed
- `max-width` media-query rule: passed
- HTML asset-path rule: passed
- Required project files: passed

## Known limitations

- No visual design system or component has been implemented yet.
- Design tokens are placeholders only.
- Browser support policy will be finalized before the first public beta.

## Next step

Step 0002 — Design Token Foundation
