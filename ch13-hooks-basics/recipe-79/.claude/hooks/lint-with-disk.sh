#!/usr/bin/env bash
# 大量の lint 出力を意図的にファイルへ書き、preview と path だけを Claude に返す
set -euo pipefail
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$file" ] && exit 0
[[ "$file" =~ \.(ts|tsx|js)$ ]] || exit 0

LOG_DIR="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/logs"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/eslint-$(date -u +%Y%m%dT%H%M%SZ).log"

# 全エラーを ファイルに永続化（数万行になることがある）
npx eslint "$file" --format json > "$LOG" 2>&1 || true

# Claude には件数と path のみ伝える（1 万文字制限を意識）
err_count=$(jq '[.[].messages[]] | length' "$LOG" 2>/dev/null || echo 0)
if [ "$err_count" -gt 0 ]; then
  jq -n --arg log "$LOG" --argjson n "$err_count" \
    '{systemMessage: ("ESLint: \($n) violations. Full log: \($log)")}'
  exit 0
fi
exit 0
