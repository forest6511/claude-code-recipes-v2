# Recipe 49: MCP サーバー連携で Skills の機能拡張

Skills が MCP サーバーのツールを活用するためのサンプル。`allowed-tools` での MCP ツール許可、`mcp__<server>__<tool>` 命名規約、ワイルドカード許可、subagent 隔離での MCP 専有実行を扱う。

## 構成

```text
recipe-49/
├── .claude/
│   └── skills/
│       ├── issue-triage/SKILL.md         # GitHub MCP を使った Issue 分類
│       └── visual-test/SKILL.md          # Playwright MCP を使ったビジュアルテスト
└── README.md
```

## ポイント

- `allowed-tools` の MCP ツール表記は `mcp__<server>__<tool>` 形式（double underscore 区切り）
- `mcp__github__*` のワイルドカードでサーバー単位の一括許可も可能（最小権限原則のため必要なツールだけ列挙が推奨）
- SKILL.md 本文では `GitHub:get_issue` のような読みやすい表記でも構わない（強制ではない）
- `context: fork` で skill を subagent に逃がすと、MCP ツール呼び出しが大量レスポンスを返してもメインコンテキストが汚染されない
