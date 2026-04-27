#!/usr/bin/env bash
set -euo pipefail
TASK_ID="$1"
TASK_FILE="evals/tasks/${TASK_ID}.yaml"
TRIAL_DIR="evals/trials/${TASK_ID}/$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$TRIAL_DIR"

DESC=$(yq -r '.task.desc' "$TASK_FILE")
PROMPT="${DESC} を agent team で解いてください。3 teammate 構成 (Opus architect / Sonnet implementer / Sonnet tester)。完了したら Clean up the team を実行してください。"

claude -p "$PROMPT" \
  --output-format json \
  > "$TRIAL_DIR/result.json"

jq -r '.session_id' "$TRIAL_DIR/result.json" > "$TRIAL_DIR/session_id.txt"
echo "Trial saved to $TRIAL_DIR"
