#!/usr/bin/env bash
set -euo pipefail
echo "=== claude-checkpoint stashes ==="
git stash list 2>/dev/null | grep -E 'claude-checkpoint' || echo "(none)"
echo
echo "=== claude-session boundary commits ==="
git log --oneline --grep='^claude-session-' -20 2>/dev/null || echo "(none)"
