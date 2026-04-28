#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
# 無限ループ防止: stop_hook_active が true のときは早期 exit (公式 hooks.md Stop hook 仕様)
active=$(echo "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

# git diff で AM (追加・変更) 済みファイルを取得し、未対応 lint エラーがあるかを判定
files=$(git diff --name-only HEAD --diff-filter=AM 2>/dev/null || true)
[ -z "$files" ] && exit 0

violations=""
while IFS= read -r f; do
  case "$f" in
    *.ts|*.tsx|*.js|*.jsx)
      out=$(npx eslint "$f" --format compact 2>&1) || violations="${violations}${out}"$'\n'
      ;;
  esac
done <<< "$files"

if [ -n "$violations" ]; then
  jq -n --arg msg "$violations" \
    '{decision: "block", reason: ("Pending lint violations before commit:\n" + $msg)}'
fi

exit 0
