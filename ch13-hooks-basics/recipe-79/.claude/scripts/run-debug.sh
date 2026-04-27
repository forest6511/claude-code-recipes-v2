#!/usr/bin/env bash
# Hook の matcher 評価まで含めた verbose log を取りつつ Claude を起動する
export CLAUDE_CODE_DEBUG_LOG_LEVEL=verbose
LOG_DIR="$HOME/.claude/debug"
mkdir -p "$LOG_DIR"
# --debug-file で書き出し先を固定（タイムスタンプ付き）
LOG_FILE="$LOG_DIR/hooks-$(date -u +%Y%m%dT%H%M%SZ).log"
echo "Logging to: $LOG_FILE"
claude --debug hooks --debug-file "$LOG_FILE"
