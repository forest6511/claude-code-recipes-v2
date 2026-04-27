# レシピ78: マッチャーパターンでツールをフィルタリング

公式 `hooks.md` の Matcher patterns 節が定義する 3 評価ルール（完全一致 / `|` 区切り完全一致リスト / JavaScript 正規表現）と、event ごとの matcher 対象フィールドを使い分ける最小例セットです。

## ファイル一覧

- `.claude/settings.json` — 基本: tool 名での完全一致と `|` 区切り
- `examples/settings-mcp.json` — MCP ツール (`mcp__server__.*` 必須)
- `examples/settings-regex.json` — 正規表現 anchor (`^Notebook` / `^(...)$`)
- `examples/settings-non-tool.json` — SessionStart / ConfigChange / Notification など非 tool 系
- `examples/settings-multi-group.json` — 同 event 内の複数 matcher group は OR

## matcher 評価ルール (3 種)

- `"*"` / `""` / 省略 → 全マッチ
- 英数字・`_`・`|` のみ → 完全一致または `|` 区切りリスト
- それ以外の文字を含む → JavaScript 正規表現

## MCP tool マッチングの落とし穴

- `mcp__memory` は完全一致扱いで誰にもマッチしない
- サーバー全体は `mcp__memory__.*` (末尾 `.*` 必須)

## 関連

- レシピ76「20+ Hooks イベント完全マップ」
- レシピ77「settings.jsonでHooks定義 + Conditional Hooks」
- レシピ79「Hooksのデバッグ + 大出力ディスク永続化」
