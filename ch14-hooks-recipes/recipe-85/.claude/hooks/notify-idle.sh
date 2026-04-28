#!/usr/bin/env bash
set -euo pipefail
input=$(cat)
message=$(echo "$input" | jq -r '.message // empty')
session=$(echo "$input" | jq -r '.session_id // "unknown"')

WEBHOOK="${SLACK_WEBHOOK_URL:-}"
[ -z "$WEBHOOK" ] && exit 0

# 短い session_id を使ってメンション
short=$(echo "$session" | cut -c1-8)
payload=$(jq -n --arg msg "$message" --arg id "$short" \
  '{text: ("[Claude " + $id + "] idle: " + $msg)}')

curl -sS -X POST -H 'Content-Type: application/json' --data "$payload" "$WEBHOOK" >/dev/null || true
exit 0
