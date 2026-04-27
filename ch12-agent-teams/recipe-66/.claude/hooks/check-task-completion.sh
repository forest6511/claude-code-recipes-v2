#!/usr/bin/env bash
set -e

input=$(cat)
teammate=$(echo "$input" | jq -r '.teammate_name // empty')

if [[ "$teammate" == backend* ]]; then
  if ! npx tsc --noEmit 2>&1; then
    echo "型エラーがあります。フロント実装に進む前に修正してください" >&2
    exit 2
  fi
fi
exit 0
