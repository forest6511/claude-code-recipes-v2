#!/usr/bin/env bash
# Reduce 結果のパターンを CLAUDE.md に追記する
set -euo pipefail

input=$(cat)
patterns=$(echo "$input" | jq -r '.task_subject // empty')

if [[ "$patterns" == "reduce-pattern" ]]; then
  description=$(echo "$input" | jq -r '.task_description // empty')
  printf "\n## レビューで頻出するパターン\n\n%s\n" "$description" >> CLAUDE.md
fi
exit 0
