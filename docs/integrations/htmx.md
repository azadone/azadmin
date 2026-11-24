# HTMX Integration Principles

AzAdmin core components do not depend on HTMX, but their markup contracts are designed to work well with server-rendered fragment replacement.

## Requirements

- Server-rendered HTML works without a build step.
- Forms remain valid when HTMX is absent.
- Component state is represented through HTML attributes, native state, and explicit classes rather than inaccessible hidden JavaScript state.
- Loading, error, disabled, success, empty, and validation states are defined.
- Fragments can be replaced independently.
- Replaced fragments do not require full-page initialization.
- IDs and targets remain stable and predictable.
- Focus and keyboard behavior remain correct after a swap.
- Optional AzAdmin JavaScript must tolerate inserted fragments and avoid global one-time initialization assumptions.

## Usage-layer attributes

HTMX attributes belong to application code:

```html
<form
  class="az-form"
  hx-post="users"
  hx-target="#users-table"
  hx-swap="outerHTML"
  hx-indicator="#users-loading"
>
  <!-- Semantic form controls -->
</form>
```

The same form must still submit normally when HTMX is not loaded.
