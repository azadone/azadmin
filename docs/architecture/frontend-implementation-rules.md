# AzAdmin Frontend Implementation Rules

This document defines mandatory implementation rules for every AzAdmin layout, component, page, example, and official integration.

## 1. Implementation priority

When multiple approaches can produce the same result, use this order:

1. Semantic native HTML
2. Modern CSS
3. Minimal progressive-enhancement JavaScript
4. An external dependency only when the feature cannot be implemented responsibly inside the core

AzAdmin is HTML-first, CSS-powered, and Zero-JS-first.

## 2. Semantic HTML

Semantic HTML is mandatory.

Use the element that communicates the actual meaning of the content:

- `<header>` for introductory or navigational content belonging to a page or section
- `<nav>` for meaningful navigation groups
- `<main>` for the document's unique primary content
- `<section>` for a thematic group that normally has a heading
- `<article>` for self-contained content that can stand independently
- `<aside>` for complementary content
- `<footer>` for closing metadata or navigation
- `<form>`, `<fieldset>`, and `<legend>` for forms
- `<button>` for actions
- `<a>` for navigation
- `<table>` only for genuine tabular data
- `<dl>`, `<dt>`, and `<dd>` for term/description or label/value data
- `<details>` and `<summary>` for native disclosures

Do not use clickable `<div>` or `<span>` elements as buttons or links. Do not introduce a wrapper when an existing semantic element can provide the required layout or state hook.

## 3. Real mobile-first CSS

Mobile-first is an implementation rule, not a marketing claim.

The default declarations in every CSS file, outside all media queries, are the mobile implementation. Only three larger layers may add or override declarations, and every responsive media query must use `min-width`.

| Layer | Rule | Approximate reference |
|---|---|---:|
| Mobile | Default styles; no media query | Below 48rem |
| Tablet | `@media (min-width: 48rem)` | About 768 px |
| Desktop | `@media (min-width: 64rem)` | About 1024 px |
| Wide desktop | `@media (min-width: 90rem)` | About 1440 px |

Required pattern:

```css
.az-component {
  /* Mobile defaults */
}

@media (min-width: 48rem) {
  .az-component {
    /* Tablet additions or overrides */
  }
}

@media (min-width: 64rem) {
  .az-component {
    /* Desktop additions or overrides */
  }
}

@media (min-width: 90rem) {
  .az-component {
    /* Wide desktop additions or overrides */
  }
}
```

Rules:

- Never use `max-width` in a media-query condition.
- Never create component-specific breakpoints.
- Never write desktop defaults and then undo them for mobile.
- Do not duplicate declarations that do not change at larger layers.
- A logical content cap such as `max-inline-size` is allowed; the prohibition applies to physical sizing and `max-width` media conditions.

Canonical breakpoint tokens must exist in `variables.css` for documentation and settings metadata, although standard media-query conditions repeat the canonical values because custom properties cannot be used directly in them.

## 4. Units

All scalable measurements use `rem`, including:

- Typography
- Margin, padding, and gap
- Inline and block dimensions
- Minimum and maximum dimensions
- Border radius
- Component and icon dimensions
- Breakpoints
- Position offsets
- Shadow offsets and blur values where practical

Do not change the root font size. Do not set `html { font-size: 62.5%; }` or a fixed pixel value. The browser and user remain in control of the root font size.

### Only pixel exception

Only a one-pixel hairline is allowed, and only for borders or outlines:

```css
.az-card {
  border: 1px solid var(--az-color-border);
}

.az-button:focus-visible {
  outline: 1px solid var(--az-color-focus);
}
```

No other `px` value is allowed.

## 5. Design tokens

Reusable values belong in `assets/css/abstracts/variables.css`. Component files consume variables instead of scattering raw numeric values.

Token categories include:

- Primitive and semantic colors
- Surfaces, text, and borders
- Font families, sizes, weights, line heights, and letter spacing
- Spacing scale
- Component, control, container, header, and sidebar dimensions
- Border widths and corner radii
- Shadows and z-index layers
- Motion duration and easing
- Density
- Breakpoints
- Focus indicators
- Touch targets
- Loading, error, success, and warning states

Preferred:

```css
.az-card {
  padding: var(--az-space-4);
  gap: var(--az-space-3);
  border-radius: var(--az-radius-md);
}
```

Raw `rem` values belong in `variables.css`, not throughout component files. Canonical media-query conditions are the documented exception.

## 6. Layout model

Use CSS Grid for structural, page-level, and two-dimensional layout:

- Application shell
- Dashboard grids
- Page sections
- Form layouts
- Card collections
- Header structures
- Hero sections
- Footers
- Sidebar/content arrangements

Use Flexbox only for simple one-dimensional alignment:

- Icon and label
- Button group
- Inline metadata
- Avatar and user name
- Small action cluster

For complex responsive arrangements, prefer `grid-template-areas` so the visual arrangement can change without changing semantic HTML order.

Do not manually reverse Grid or data order for RTL. Logical alignment and writing direction must handle that behavior.

## 7. Minimum justified DOM

Every HTML element must have a semantic, accessibility, styling, or behavioral reason to exist.

Before adding a wrapper, ask:

- Does it add semantic meaning?
- Does it define a required grid or formatting context?
- Does it provide an accessibility relationship or target?
- Does it carry a component state or stable hook?
- Is it required for native HTML behavior?
- Can the parent become the Grid container?
- Can a pseudo-element replace a decorative node?

The objective is minimum justified DOM, not minimum DOM at the expense of semantics or accessibility.

## 8. Native HTML/CSS before JavaScript

| Requirement | Preferred no-JavaScript pattern |
|---|---|
| Accordion or FAQ | `<details><summary>` |
| Exclusive accordion group | Multiple `<details>` elements with the same `name` |
| Simple mobile navigation | Focusable checkbox + `<label>` + `:checked` relationship |
| Carousel or slider | CSS scroll snap + anchors + `:target` where useful |
| Simple tabs | `:target` |
| Direction-aware decoration | Logical CSS and `:dir()` only when required |
| Derived tint or shade | `color-mix(in srgb, var(--az-color) ... )` |
| Disclosure state | Native open/closed elements before custom state machines |

Every exclusive accordion group uses a shared `name` value. Do not recreate this behavior with JavaScript.

A checkbox-driven mobile menu is acceptable only when keyboard access, focus visibility, logical source order, and hidden-state focus behavior remain correct. Otherwise, minimal JavaScript is justified.

JavaScript is allowed only when native HTML and CSS cannot provide the required combination of accessibility, focus management, keyboard behavior, data interaction, progressive enhancement, and required browser support. The reason must be documented in the related step note.

## 9. Modern viewport units

When viewport-relative sizing is required, use modern viewport units:

- `dvh` for the current dynamic viewport height
- `svh` for the smallest viewport height
- `lvh` for the largest viewport height
- Corresponding `dvw`, `svw`, and `lvw` units where appropriate

Use progressive fallbacks:

```css
.az-app {
  min-block-size: 100vh;
  min-block-size: 100svh;
  min-block-size: 100dvh;
}
```

Use viewport units for layout, not normal text sizing. Consider safe-area environment variables for full-screen mobile interfaces.

## 10. Full RTL support

The default document direction is `dir="ltr"`, but all CSS must work when `dir="rtl"` is applied to the document or any nested subtree.

No separate RTL stylesheet and no duplicate RTL markup are allowed.

Never use physical directional properties:

- `left`, `right`
- `margin-left`, `margin-right`
- `padding-left`, `padding-right`
- `border-left`, `border-right`
- `text-align: left`, `text-align: right`
- `float: left`, `float: right`

Use logical equivalents:

- `inset-inline-start`, `inset-inline-end`
- `margin-inline`, `margin-inline-start`, `margin-inline-end`
- `padding-inline`, `padding-inline-start`, `padding-inline-end`
- `border-inline-start`, `border-inline-end`
- `text-align: start`, `text-align: end`
- `inline-size`, `block-size`
- `min-inline-size`, `max-inline-size`
- `min-block-size`, `max-block-size`
- `border-start-start-radius`, `border-start-end-radius`
- `border-end-start-radius`, `border-end-end-radius`

Uniform `border-radius` is direction-neutral and allowed. Asymmetric corners use logical corner properties.

### Directional UI glyphs

Do not use textual glyphs such as `‹`, `›`, `«`, `»`, parentheses, or brackets as directional UI arrows or separators. Unicode bidirectional mirroring can produce double-mirroring and unpredictable output.

A directional glyph is allowed only when it belongs to the actual text content. UI direction indicators must use a logical CSS shape or a controlled SVG/icon.

Do not reverse arrays, use duplicate markup, or manually invert Grid order merely to support RTL.

## 11. Mixed RTL/LTR content

Do not write a single flowing UI sentence when an RTL label is combined with an LTR value that may wrap.

For compact metadata, specifications, cards, and mobile layouts, split label and value into separate elements:

```html
<div class="az-spec">
  <span class="az-spec__label">گشتاور مجاز</span>
  <span class="az-spec__value">
    <span class="az-num">160 Nm</span>
  </span>
</div>
```

The numeric/code utility is:

```css
.az-num {
  direction: ltr;
  unicode-bidi: isolate;
  font-family: var(--az-font-family-mono);
  font-size: 0.9em;
}
```

Use `.az-num` for measurements, part numbers, product codes, serial numbers, version strings, telephone numbers, compact dates, and technical ranges.

The value element receives its own absolute font-size token. It must not scale accidentally when the label size changes. `.az-num` is the intentional relative-size exception because it aligns monospace content with its immediate value context.

## 12. Semantic block qualification

Use `<article>` only when content is self-contained and meaningful independently.

Use `<section>` only when content is a thematic grouping and normally has a meaningful heading.

Use `<nav>` only for a meaningful navigation group, not every list of links.

Use `<aside>` only for complementary content whose removal does not break the main flow.

Use `<main>` once for the page's unique primary content.

Use `<div>` only when no semantic element accurately describes the node and a grouping element is still necessary.

Every `section`, `nav`, and `aside` must have an accessible name, preferably through a visible heading and `aria-labelledby`. Use `aria-label` only when a visible heading is genuinely inappropriate.

## 13. Brand palette

When a palette is introduced, identify the primary color before implementation.

The primary color must appear on the largest stable branded surface, normally the main navigation or another persistent interface surface. Secondary and dark support colors must not visually replace the primary brand.

Use support colors for the footer, small accents, active indicators, emphasis, and semantic states.

Do not invent random one-off colors. Derive controlled tints and shades from the approved palette with `color-mix()` and expose them through semantic tokens.

## 14. Touch targets

Every interactive target must provide a minimum hit area of `3rem × 3rem`.

This applies to buttons, icon buttons, navigation links, menu triggers, pagination controls, checkbox/radio labels, tabs, carousel controls, disclosure summaries, and clickable card actions.

The visible icon may be smaller than `3rem`; the interactive hit area may not.

## 15. Paths and stylesheet boundaries

Use simple relative asset paths.

Allowed:

```html
<link rel="stylesheet" href="assets/css/main.css">
<img src="assets/images/example.webp" alt="">
```

Avoid leading `/` and `../` for project assets.

Every new component or substantial page section receives its own CSS source file. Files are composed through `main.css`; do not create a monolithic stylesheet.

## 16. Required checks

Run before delivery:

```bash
grep -RInE --include='*.css' '[0-9]*\.?[0-9]+px' assets/css
grep -RInEi --include='*.css' '(left|right)' assets/css
grep -RInE --include='*.css' '@media[^\{]*max-width' assets/css
grep -RInE --include='*.css' '[0-9]*\.?[0-9]+rem' assets/css
grep -RInE --include='*.html' '(src|href)="(/|\.\./)' .
```

Review every pixel result. Only `1px` border or outline declarations are allowed. Raw `rem` values should normally appear only in `variables.css`, with canonical media-query conditions as the documented exception.

The repository scripts under `scripts/` automate the enforceable parts of these rules.

## 17. Pre-delivery checklist

### Responsive architecture

- [ ] Default declarations outside media queries are the mobile implementation.
- [ ] Only the canonical `48rem`, `64rem`, and `90rem` `min-width` layers are used.
- [ ] No `max-width` media-query condition exists.
- [ ] No component-specific breakpoint exists.
- [ ] Larger layers contain only necessary additions and overrides.

### Units and tokens

- [ ] All scalable measurements use design tokens backed by `rem`.
- [ ] The root `html` font size is unchanged.
- [ ] Component spacing, typography, dimensions, and radii use `var(--az-...)`.
- [ ] The only `px` declarations are one-pixel borders or outlines.
- [ ] Pixel grep results have been reviewed.
- [ ] Modern viewport units are used where viewport-relative layout is required.

### Direction and RTL

- [ ] The component works with `dir="rtl"` on the document.
- [ ] The component works with `dir="rtl"` on only its subtree.
- [ ] All directional declarations are logical.
- [ ] Asymmetric radii use logical corner properties.
- [ ] No physical `left` or `right` declaration exists.
- [ ] Physical-direction grep results have been reviewed.
- [ ] Directional UI indicators do not use bidi-mirroring text glyphs.
- [ ] Grid follows direction naturally without manual reversal.
- [ ] Mixed RTL/LTR label/value items use separate elements.
- [ ] Numeric and coded values are isolated with `.az-num`.

### HTML and accessibility

- [ ] Markup is semantic.
- [ ] Every block passes the semantic qualification test.
- [ ] No untitled `<section>` should be a `<div>`.
- [ ] Every `section`, `nav`, and `aside` has an accessible name.
- [ ] `<article>` is used only for self-contained content.
- [ ] `<nav>` is reserved for meaningful navigation groups.
- [ ] Actions use `<button>` and navigation uses `<a>`.
- [ ] Touch targets are at least `3rem × 3rem`.
- [ ] Keyboard focus states are visible.
- [ ] Source order remains meaningful without CSS.

### Layout and DOM

- [ ] CSS Grid is used for structural layout.
- [ ] Flexbox is limited to simple one-dimensional alignment.
- [ ] Complex responsive arrangements use `grid-template-areas` where appropriate.
- [ ] Every wrapper has a semantic, accessibility, styling, or behavioral reason.
- [ ] No wrapper can be removed by placing Grid on its parent.
- [ ] DOM depth is minimal without damaging semantics or accessibility.

### JavaScript

- [ ] Native HTML/CSS was considered before JavaScript.
- [ ] `<details>/<summary>` was considered for disclosures.
- [ ] Exclusive accordion groups use a shared `name`.
- [ ] Checkbox/label was considered for a simple mobile menu.
- [ ] Scroll snap and anchors were considered for a carousel.
- [ ] `:target` was considered for simple tabs or state.
- [ ] Any JavaScript necessity is documented.
- [ ] JavaScript is minimal, modular, dependency-free, and removable.
- [ ] Useful baseline behavior remains without JavaScript.

### Files and paths

- [ ] Every new component or substantial section has its own CSS file.
- [ ] CSS files are composed through `main.css`.
- [ ] Asset paths are simple and relative.
- [ ] Asset paths avoid a leading `/` and `../`.
- [ ] Documentation links the implementation to its MOC and archive step.

### Visual system

- [ ] The approved primary color is identifiable on the main persistent branded surface.
- [ ] Secondary colors do not overpower the primary color.
- [ ] Tints and shades use approved tokens and `color-mix()`.
- [ ] No random one-off color was introduced.

### Documentation and delivery

- [ ] The related Obsidian step note is updated.
- [ ] Parent, Previous, Next, Architecture, Workflow, and Related links are present.
- [ ] Branch, commit, and pull-request names are documented.
- [ ] Known limitations are recorded.
- [ ] All required checks have been run and reviewed.
