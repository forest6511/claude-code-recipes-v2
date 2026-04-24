#!/bin/bash
# PostCompact Hooks: compact_summary を .claude/logs/ に保存する
input=$(cat)

TRIGGER=$(echo "$input" | jq -r '.trigger')
SESSION_ID=$(echo "$input" | jq -r '.session_id')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

LOG_DIR=".claude/logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/compact-${TIMESTAMP}-${TRIGGER}.md"
echo "# Compact Summary ($TIMESTAMP, trigger=$TRIGGER, session=$SESSION_ID)" > "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "$input" | jq -r '.compact_summary' >> "$LOG_FILE"

exit 0
