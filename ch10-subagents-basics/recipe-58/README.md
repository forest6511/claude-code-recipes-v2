# レシピ58: サブエージェントの権限制御とツール制限

`tools` allowlist / `disallowedTools` denylist / `permissionMode` / PreToolUse Hooks / `permissions.deny` を組み合わせた多層防御を扱う中級レシピです。

## 含まれるサンプル

- `.claude/agents/safe-researcher.md` — 読み取り専用調査エージェント (`tools: Read, Grep, Glob, Bash` で書き込み系を除外)
- `.claude/agents/no-writes.md` — `disallowedTools: Write, Edit` でメイン継承から書き込みだけ除外
- `.claude/agents/db-reader.md` — frontmatter Hooks で SELECT クエリのみ許可
- `.claude/agents/coordinator.md` — `tools: Agent(worker, researcher)` で起動できるサブエージェント種別を制限
- `scripts/validate-readonly-query.sh` — Hook 用バリデーション (jq で `tool_input.command` 抽出、書き込みキーワード検出で exit 2)
- `.claude/settings.json` — `permissions.deny: Agent(...)` で特定サブエージェントの起動を禁止

## 動作確認

```bash
chmod +x scripts/validate-readonly-query.sh

# Hook 単体テスト (JSON 入力)
echo '{"tool_input":{"command":"SELECT * FROM users LIMIT 10"}}' | scripts/validate-readonly-query.sh
echo "exit code: $?"  # → 0

echo '{"tool_input":{"command":"DELETE FROM users"}}' | scripts/validate-readonly-query.sh
echo "exit code: $?"  # → 2 (blocked)
```

## 関連レシピ

- レシピ55「Taskツールの仕組みと独立コンテキスト」
- レシピ57「カスタムエージェント + initialPrompt + /agents tabbed」
- レシピ59「Context engineering」
- レシピ06「パーミッション設計」
