#!/usr/bin/env bash
set -eu

root="${1:-.}"

matches="$(grep -RInE --include='*.html' "(src|href)=[\"'](/|\\.\\./)" "$root" || true)"

if [ -n "$matches" ]; then
  printf 'Forbidden root-relative or parent-directory asset path found:\n%s\n' "$matches" >&2
  exit 1
fi

printf 'HTML path rules passed.\n'
