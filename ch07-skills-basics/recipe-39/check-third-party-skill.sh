#!/usr/bin/env bash
# サードパーティ Skill の導入前チェッカー
# Usage: bash check-third-party-skill.sh path/to/skill-dir

SKILL_DIR="$1"

# 1. allowed-tools の過剰権限チェック
echo "=== allowed-tools ==="
grep -A1 "allowed-tools" "$SKILL_DIR"/SKILL.md

# 2. シェル前処理 (!command) の確認
echo "=== !command preprocessing ==="
grep -nE '^!`|^```!' "$SKILL_DIR"/SKILL.md

# 3. disable-model-invocation の有無
echo "=== invocation control ==="
grep -E "disable-model-invocation|user-invocable" "$SKILL_DIR"/SKILL.md
