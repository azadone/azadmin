# AzAdmin Project Overview

## Identity

- Project: AzAdmin
- Repository: `git@github.com:azadone/azadmin.git`
- License: MIT
- Core architecture: Framework-agnostic
- Implementation approach: HTML-first, CSS-powered, Zero-JS-first

## Responsibility of the core repository

The core repository provides semantic markup contracts, modern CSS, optional minimal enhancements, layouts, components, pages, documentation, and integration guidance.

It must not become dependent on a particular frontend or backend framework.

## Official integration strategy

Future React, Vue, Angular, Bootstrap, and Tailwind implementations should be separate repositories or packages that consume the core. They must not fork or duplicate the core implementation.

## Original implementation policy

Every AzAdmin implementation is written from scratch. Other interfaces may be studied to identify requirements and common UX patterns, but their code, markup structure, stylesheet, scripts, proprietary assets, and distinctive component implementation must not be copied.
