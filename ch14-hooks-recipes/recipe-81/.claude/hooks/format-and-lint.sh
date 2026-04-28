#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$file" ] && exit 0
[ ! -f "$file" ] && exit 0

case "$file" in
  *.ts|*.tsx|*.js|*.jsx)
    npx prettier --write "$file" >/dev/null 2>&1 || true
    if ! err=$(npx eslint "$file" --format compact 2>&1); then
      jq -n --arg msg "$err" '{decision: "block", reason: $msg}'
    fi
    ;;
  *.py)
    ruff format "$file" >/dev/null 2>&1 || true
    if ! err=$(ruff check "$file" 2>&1); then
      jq -n --arg msg "$err" '{decision: "block", reason: $msg}'
    fi
    ;;
  *.go)
    gofmt -w "$file"
    if ! err=$(go vet "$file" 2>&1); then
      jq -n --arg msg "$err" '{decision: "block", reason: $msg}'
    fi
    ;;
  *.rs)
    rustfmt "$file" >/dev/null 2>&1 || true
    ;;
esac

exit 0
