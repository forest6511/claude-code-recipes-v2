# Recipe 30: TypeScriptでMCP + Plugin bin/

TypeScript で実装した MCP サーバーを Claude Code Plugin としてパッケージし、`bin/` でシェルから直接呼び出せる CLI も同時提供する構成。

## ファイル構成

- `src/server.ts` — MCP サーバー本体（`@modelcontextprotocol/sdk` + zod）
- `bin/company-kb` — Plugin PATH に追加される CLI ラッパー
- `.mcp.json` — MCP サーバー定義（`${CLAUDE_PLUGIN_ROOT}` 変数展開）
- `.claude-plugin/plugin.json` — プラグインマニフェスト
- `package.json` / `tsconfig.json` — ビルド設定（`prepare` で自動 `tsc`）

## ビルド

```bash
npm install
npm run build
```

## 参考

- 書籍本文: レシピ30「TypeScriptでMCP + Plugin bin/」
- 公式: `~/.claude/docs/claude-code/plugins-reference.md`
