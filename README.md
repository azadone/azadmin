# AzAdmin

> HTML-first. CSS-powered. JavaScript only when necessary.

AzAdmin is a modular, framework-agnostic, RTL-ready admin UI built from scratch with semantic HTML and modern CSS.

The project follows a **Zero-JS-first** architecture: each component is implemented with native HTML and CSS whenever possible, and minimal dependency-free JavaScript is added only when the browser platform cannot provide the required behavior responsibly.

> **Project status:** early development. The repository currently contains the project foundation and implementation standards; production components will be added incrementally.

## Why AzAdmin

AzAdmin is intended to be a reusable admin UI core rather than a template tied to one frontend framework. The same semantic markup and CSS contracts should be usable in static HTML, server-rendered applications, HTMX interfaces, WebAssembly applications, and future framework adapters.

## Core principles

- Semantic and accessible HTML
- Real mobile-first CSS
- One markup structure for LTR, RTL, light, dark, and high-contrast modes
- Logical CSS properties instead of physical left/right declarations
- `rem`-based scalable design tokens
- CSS Grid for structural layout
- Minimum justified DOM depth
- Native HTML/CSS before JavaScript
- Progressive enhancement
- Independent server-rendered fragments
- Clean state contracts for HTMX and WebAssembly
- No copied source code, markup, stylesheet, JavaScript, asset, or proprietary component structure
- No frontend-framework lock-in

## Zero-JS-first

AzAdmin does not claim that every advanced interface can be implemented without JavaScript. It follows a stricter decision model:

1. Use semantic native HTML.
2. Use modern CSS.
3. Add minimal, dependency-free JavaScript only when native behavior cannot satisfy accessibility, focus management, keyboard interaction, data interaction, or required browser support.

Examples of preferred native patterns include:

- `<details><summary>` for disclosures and FAQs
- Shared `name` attributes for exclusive accordion groups
- CSS Grid for structural layouts
- Scroll snap and anchors for simple carousels
- `:target` for simple tabs or state
- Logical properties and `:dir()` for direction-aware behavior
- `color-mix()` for derived palette values

## Framework-agnostic core

The core does not depend on React, Vue, Angular, Bootstrap, Tailwind, jQuery, or a specific backend framework. This does **not** mean AzAdmin cannot be used with them.

Future official integrations should be published as separate repositories or packages that consume the core contracts rather than forking or duplicating the core:

- `azadmin-react`
- `azadmin-vue`
- `azadmin-angular`
- `azadmin-bootstrap`
- `azadmin-tailwind`

## Server-rendered and HTMX-ready

AzAdmin components are designed to support server rendering:

- HTML returned by a server works without a build step.
- Components do not depend solely on hidden JavaScript state.
- Forms remain valid without HTMX.
- Loading, error, disabled, success, and empty states are explicit.
- HTML fragments are independently replaceable.
- Fragment swaps do not require full-page initialization.
- IDs, targets, and state attributes are predictable.
- Focus, validation, and keyboard behavior remain accessible.

HTMX attributes belong to the application integration layer. Core components remain valid without HTMX.

See [HTMX integration principles](docs/integrations/htmx.md).

## WebAssembly-ready contracts

AzAdmin does not depend on a specific WebAssembly runtime. It exposes stable HTML contracts so a WebAssembly application can:

- Change attributes
- Toggle state classes
- Replace fragments
- Dispatch and receive custom events
- Control component state
- Render server or client data
- Use the CSS system without rewriting it

See [WebAssembly integration principles](docs/integrations/webassembly.md).

## Responsive system

AzAdmin uses one fixed mobile-first breakpoint model:

| Layer | Rule |
|---|---|
| Mobile | Default declarations; no media query |
| Tablet | `@media (min-width: 48rem)` |
| Desktop | `@media (min-width: 64rem)` |
| Wide desktop | `@media (min-width: 90rem)` |

`max-width` media-query conditions and component-specific breakpoints are prohibited.

## Direction and themes

One HTML structure supports both directions and all themes:

```html
<html lang="en" dir="ltr" data-az-theme="light">
```

```html
<html lang="fa" dir="rtl" data-az-theme="dark">
```

Direction may also be applied to a nested subtree. No separate RTL HTML file or RTL stylesheet is required.

## Naming contracts

| Concern | Contract |
|---|---|
| CSS classes | `az-*` |
| CSS custom properties | `--az-*` |
| Data attributes | `data-az-*` |
| Custom events | `az:*` |
| Source filenames | Standard descriptive names such as `button.css`, `sidebar.css`, and `theme.js` |

## Repository structure

```text
assets/
├── css/
│   ├── abstracts/
│   ├── base/
│   ├── components/
│   ├── layout/
│   ├── pages/
│   ├── themes/
│   └── main.css
├── js/
│   ├── core/
│   ├── components/
│   └── main.js
├── icons/
└── images/
components/
layouts/
pages/
examples/
docs/
scripts/
```

## Getting started

The core has no required build step.

```bash
git clone git@github.com:azadone/azadmin.git
cd azadmin
```

Open `index.html` directly for the current foundation smoke page.

Run project checks:

```bash
./scripts/check-project.sh
```

## Documentation

- [Documentation map](docs/README.md)
- [Project overview](docs/architecture/project-overview.md)
- [Frontend implementation rules](docs/architecture/frontend-implementation-rules.md)
- [Git workflow](docs/workflow/git-workflow.md)
- [Documentation workflow](docs/workflow/documentation-workflow.md)
- [Step 0001 archive](docs/archive/0001-project-foundation.md)

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request. Every meaningful implementation step must include documentation, checks, and an archive note.

## Security

Report security problems privately as described in [SECURITY.md](SECURITY.md). Do not publish an exploitable vulnerability as a public issue.

## License

AzAdmin is released under the [MIT License](LICENSE).
