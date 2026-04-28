#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$file" ] && exit 0

case "$file" in
  *.ts|*.tsx|*.js|*.jsx)
    output=$(npx eslint "$file" --format compact 2>&1) || {
      jq -n --arg msg "$output" \
        '{decision: "block", reason: ("ESLint violations:\n" + $msg)}'
      exit 0
    }
    ;;
  *.py)
    output=$(ruff check "$file" 2>&1) || {
      jq -n --arg msg "$output" \
        '{decision: "block", reason: ("Ruff violations:\n" + $msg)}'
      exit 0
    }
    ;;
  *.go)
    output=$(go vet "$file" 2>&1) || {
      jq -n --arg msg "$output" \
        '{decision: "block", reason: ("go vet violations:\n" + $msg)}'
      exit 0
    }
    ;;
esac

exit 0
