# WebAssembly Integration Principles

AzAdmin does not depend on a particular WebAssembly runtime, language, or DOM binding.

## HTML contract

A WebAssembly application should be able to:

- Change `data-az-*` state attributes
- Toggle documented `az-*` state classes
- Replace complete HTML fragments
- Dispatch and receive `az:*` custom events
- Render values without modifying component CSS
- Control themes and direction through document or subtree attributes

Example:

```html
<body
  class="az-app"
  data-az-sidebar-state="collapsed"
  data-az-theme="dark"
>
```

The integration controls state; CSS controls presentation. Core behavior must not require a particular runtime-specific wrapper.
