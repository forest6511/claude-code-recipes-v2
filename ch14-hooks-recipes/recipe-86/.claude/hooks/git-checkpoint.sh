#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
session=$(echo "$input" | jq -r '.session_id // "noid"')
short=$(echo "$session" | cut -c1-8)

# git リポジトリ外なら何もしない
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

# 変更がなければ stash 不要
if git diff --quiet HEAD 2>/dev/null; then
  exit 0
fi

# 直近 stash と同一かチェック (連続発火での重複作成防止)
last=$(git stash list -n 1 --format='%s' 2>/dev/null | grep -oE "claude-checkpoint-${short}" || true)
if [ -n "$last" ]; then
  exit 0
fi

# untracked も含めて stash (--include-untracked で .claude/logs 等の未追跡も保存)
msg="claude-checkpoint-${short}-$(date -u +%Y%m%dT%H%M%SZ)"
git stash push --include-untracked --keep-index --message "$msg" >/dev/null 2>&1 || exit 0

# stash 復元 (作業ツリーに戻す)。Claude の Edit/Write はこの後実行される
git stash apply --quiet >/dev/null 2>&1 || true

exit 0
