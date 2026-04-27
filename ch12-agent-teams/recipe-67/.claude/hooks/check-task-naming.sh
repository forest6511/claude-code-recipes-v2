#!/usr/bin/env bash
set -e

input=$(cat)
subject=$(echo "$input" | jq -r '.task_subject // empty')
description=$(echo "$input" | jq -r '.task_description // empty')

if [[ -z "$description" ]]; then
  echo "task_description が空です。タスクには説明を必ず含めてください" >&2
  exit 2
fi

if [[ ${#subject} -lt 10 ]]; then
  echo "task_subject が短すぎます ($subject)。10 文字以上で命名してください" >&2
  exit 2
fi

exit 0
