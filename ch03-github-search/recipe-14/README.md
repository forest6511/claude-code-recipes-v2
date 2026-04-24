# レシピ14: Brave Search MCPでWeb検索結果を活かす

Claude Code からリアルタイム Web 検索を使う Brave Search MCP の登録例。

## 使い方

```bash
# 1. Brave Search API キーを取得
# https://brave.com/search/api/ で登録（無料: 月 2,000 リクエスト）
export BRAVE_API_KEY="BSA..."

# 2. プロジェクトスコープで登録（.mcp.json に書き出し、チーム共有）
claude mcp add --transport stdio --scope project \
  --env BRAVE_API_KEY=${BRAVE_API_KEY} \
  brave-search -- npx -y @modelcontextprotocol/server-brave-search

# 3. 接続確認
# > /mcp

# 4. 検索プロンプト
# > Next.js 15 App Router のキャッシュ戦略を調べて
```

## スコープの使い分け

- `--scope local`（既定）: 現プロジェクトで自分だけが使う
- `--scope project`: `.mcp.json` 経由でチーム共有
- `--scope user`: 全プロジェクトで自分が使う

## `.mcp.json` の例

```json
{
  "mcpServers": {
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_API_KEY}"
      }
    }
  }
}
```

## 関連

- レシピ18 複数リポジトリ横断調査
- レシピ27 Context7 MCP で公式ドキュメント参照
- レシピ29 カスタム MCP サーバー設計
