# Recipe 28: 複数MCPサーバー + Code execution with MCP パターン

4 つの MCP サーバー（DBHub PostgreSQL / Notion / Context7 / Fetch）を同時接続し、Code execution with MCP パターンで中間結果をスクリプト内に閉じ込めてトークン消費を抑える設定例。

## ファイル構成

- `.mcp.json` — 4 サーバー同時接続の設定
- `.claude/settings.json` — Tool Search 強制有効化 + MCP 出力上限引き上げ
- `scripts/bulk-sync.ts` — Code execution with MCP パターンの TypeScript 実装例

## セットアップ

```bash
npm init -y
npm install @modelcontextprotocol/sdk
npm install --save-dev tsx typescript @types/node
export DATABASE_URL="postgresql://claude_readonly:...@localhost:5432/mydb"
npx tsx scripts/bulk-sync.ts
```

## 参考

- 書籍本文: レシピ28「複数MCPサーバー + Code execution with MCP パターン」
- Anthropic Engineering Blog: Code execution with MCP (2025-11)
