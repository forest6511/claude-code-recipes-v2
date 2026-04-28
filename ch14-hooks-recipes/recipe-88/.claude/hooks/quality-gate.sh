#!/usr/bin/env bash
set -euo pipefail
input=$(cat)

# 無限ループ防止: stop_hook_active=true なら早期 exit (公式 hooks.md L1683)
active=$(echo "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

issues=""

# 1. テスト失敗をチェック
if [ -f package.json ] && grep -q '"test"' package.json; then
  if ! npm test --silent >/tmp/claude-stop-test.log 2>&1; then
    fails=$(tail -5 /tmp/claude-stop-test.log | tr '\n' ' ')
    issues+=$'Tests failing: '"${fails}"$'\n'
  fi
fi

# 2. 未コミット変更を確認
if git rev-parse --git-dir >/dev/null 2>&1; then
  if ! git diff --quiet HEAD 2>/dev/null; then
    count=$(git diff --name-only HEAD | wc -l | tr -d ' ')
    issues+=$'Uncommitted changes: '"${count}"$' files\n'
  fi
fi

# 3. TODO / FIXME 検出 (Claude が残した未完了マーカー)
todo_count=$(git diff HEAD 2>/dev/null | grep -cE '^\+.*\b(TODO|FIXME|XXX)\b' || echo 0)
if [ "$todo_count" -gt 0 ]; then
  issues+=$'TODO/FIXME added in this session: '"${todo_count}"$' lines\n'
fi

# 問題があれば block
if [ -n "$issues" ]; then
  jq -n --arg msg "$issues" '{
    decision: "block",
    reason: ("Quality gate failed:\n" + $msg + "Please address these before stopping.")
  }'
fi

exit 0
