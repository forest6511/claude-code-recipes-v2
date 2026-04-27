#!/usr/bin/env bash
set -euo pipefail
LOG_DIR="${CLAUDE_PROJECT_DIR}/evals/logs"
mkdir -p "$LOG_DIR"

input=$(cat)
event=$(echo "$input" | jq -r '.hook_event_name')
session_id=$(echo "$input" | jq -r '.session_id')
ts=$(date -u +%FT%TZ)

case "$event" in
  SubagentStop)
    agent_id=$(echo "$input" | jq -r '.agent_id')
    agent_type=$(echo "$input" | jq -r '.agent_type')
    transcript=$(echo "$input" | jq -r '.agent_transcript_path')
    jq -nc --arg ts "$ts" --arg ev "$event" --arg sid "$session_id" \
      --arg aid "$agent_id" --arg at "$agent_type" --arg tr "$transcript" \
      '{ts:$ts, event:$ev, session_id:$sid, agent_id:$aid, agent_type:$at, transcript:$tr}' \
      >> "$LOG_DIR/trials.jsonl"
    ;;
  TaskCompleted)
    task_id=$(echo "$input" | jq -r '.task_id')
    teammate=$(echo "$input" | jq -r '.teammate_name // "unknown"')
    team=$(echo "$input" | jq -r '.team_name // "unknown"')
    jq -nc --arg ts "$ts" --arg ev "$event" --arg sid "$session_id" \
      --arg tid "$task_id" --arg tm "$teammate" --arg tn "$team" \
      '{ts:$ts, event:$ev, session_id:$sid, task_id:$tid, teammate:$tm, team:$tn}' \
      >> "$LOG_DIR/trials.jsonl"
    ;;
esac
exit 0
