#!/usr/bin/env bash
set -euo pipefail

ROUTINE_ID="${ROUTINE_ID:?Set ROUTINE_ID}"
TOKEN="${ROUTINE_TOKEN:?Set ROUTINE_TOKEN}"

curl -X POST "https://api.anthropic.com/v1/claude_code/routines/${ROUTINE_ID}/fire" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
  -H "anthropic-version: 2023-06-01" \
  -H "Content-Type: application/json" \
  -d "{\"text\": \"$1\"}"
