#!/usr/bin/env bash
set -eu

project_root="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$project_root"

./scripts/check-css-rules.sh assets/css
./scripts/check-html-paths.sh .

required_files="
README.md
LICENSE
CHANGELOG.md
CONTRIBUTING.md
CODE_OF_CONDUCT.md
SECURITY.md
.editorconfig
.gitattributes
.gitignore
index.html
assets/css/main.css
assets/css/abstracts/variables.css
docs/archive/0001-project-foundation.md
"

for file in $required_files; do
  if [ ! -f "$file" ]; then
    printf 'Required file is missing: %s\n' "$file" >&2
    exit 1
  fi
done

printf 'Project foundation checks passed.\n'
