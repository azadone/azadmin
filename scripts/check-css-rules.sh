#!/usr/bin/env bash
set -eu

css_dir="${1:-assets/css}"
status=0

if [ ! -d "$css_dir" ]; then
  printf 'CSS directory not found: %s\n' "$css_dir" >&2
  exit 1
fi

printf 'Checking CSS under %s\n' "$css_dir"

px_matches="$(grep -RInE --include='*.css' '[0-9]*\.?[0-9]+px' "$css_dir" || true)"
if [ -n "$px_matches" ]; then
  invalid_px="$(printf '%s\n' "$px_matches" | grep -Ev '(^|[^[:alnum:]_-])(border|border-(block|inline)(-(start|end))?|outline)(-[[:alnum:]-]+)?[[:space:]]*:[^;]*1px([^0-9.]|$)' || true)"
  if [ -n "$invalid_px" ]; then
    printf '\nForbidden px value found:\n%s\n' "$invalid_px" >&2
    status=1
  fi
fi

physical="$(grep -RInEi --include='*.css' '(left|right)' "$css_dir" || true)"
if [ -n "$physical" ]; then
  printf '\nPhysical direction word found:\n%s\n' "$physical" >&2
  status=1
fi

max_width_media="$(grep -RInE --include='*.css' '@media[^\{]*max-width' "$css_dir" || true)"
if [ -n "$max_width_media" ]; then
  printf '\nForbidden max-width media query found:\n%s\n' "$max_width_media" >&2
  status=1
fi

raw_rem="$(grep -RInE --include='*.css' '[0-9]*\.?[0-9]+rem' "$css_dir"   | grep -v '/abstracts/variables.css:'   | grep -Ev '@media[[:space:]]*\(min-width:[[:space:]]*(48|64|90)rem\)' || true)"
if [ -n "$raw_rem" ]; then
  printf '\nRaw rem value outside variables.css or canonical media query:\n%s\n' "$raw_rem" >&2
  status=1
fi

if [ "$status" -ne 0 ]; then
  exit "$status"
fi

printf 'CSS rules passed.\n'
