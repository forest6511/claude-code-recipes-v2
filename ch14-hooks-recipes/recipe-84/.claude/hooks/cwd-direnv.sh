#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
new_cwd=$(echo "$input" | jq -r '.new_cwd // empty')
old_cwd=$(echo "$input" | jq -r '.old_cwd // empty')
[ -z "$new_cwd" ] && exit 0

# direnv が入っていれば export を CLAUDE_ENV_FILE に流す
if command -v direnv >/dev/null 2>&1 && [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  (cd "$new_cwd" && direnv export bash 2>/dev/null) >> "$CLAUDE_ENV_FILE" || true
fi

# 移動先の watch 対象を返す (既存 matcher の watch list に追加される)
watch=$(find "$new_cwd" -maxdepth 2 -type f \( -name '.env*' -o -name '.tool-versions' \) 2>/dev/null | jq -R . | jq -s .)
jq -n --argjson paths "$watch" '{watchPaths: $paths}'
exit 0
