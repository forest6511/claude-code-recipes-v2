# Recipe 33: Tool Search

サーバー作者向けの Tool Search 対応指針サンプル。

## ファイル構成

- `server_instructions.py` — FastMCP サーバーで `instructions` を設定する例
- `naming-pattern.md` — `<service>_<resource>_<action>` 命名規則の具体例
- `large-output-tool.ts` — `_meta["anthropic/maxResultSizeChars"]` で大出力ツールを宣言
- `settings-deny-toolsearch.json` — Tool Search を組織レベルで無効化する設定例

## 参考

- 書籍本文: レシピ33「Tool Search」
- 公式: `~/.claude/docs/claude-code/mcp.md` の "Scale with MCP Tool Search" 節
