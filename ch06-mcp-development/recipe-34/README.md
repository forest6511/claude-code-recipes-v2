# Recipe 34: PAL MCP / Codex-via-MCP でマルチモデル統合

Claude Code から他モデル（Gemini / GPT / Codex / Grok 等）へ MCP 経由で問い合わせる構成サンプル。

## ファイル構成

- `.env.example` — PAL MCP Server 用の API キー設定テンプレート
- `.mcp.json` — PAL + Codex の 2 サーバーを統合登録
- `CLAUDE.md` — モデル使い分け方針（プロジェクトに配置すると Claude が自動参照）

## セットアップ概要

```bash
# PAL MCP Server (旧称: Zen MCP Server)
git clone https://github.com/BeehiveInnovations/pal-mcp-server.git
cd pal-mcp-server && cp .env.example .env && ./run-server.sh

# Codex CLI
npm install -g @openai/codex
codex login
```

その後、`.mcp.json` のパスを実環境に合わせて更新し Claude Code を起動。

## 参考

- 書籍本文: レシピ34「PAL MCP / Codex-via-MCPでマルチモデル統合」
- PAL MCP Server: https://github.com/BeehiveInnovations/pal-mcp-server
- Codex CLI: https://github.com/openai/codex（`codex mcp-server` で stdio MCP サーバー起動）
