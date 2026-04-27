# レシピ77: settings.jsonでHooks定義 + Conditional Hooks

公式 `hooks.md` の Configuration 節が定義する 3 階層構造（hook event → matcher group → hook handler）と、`if` フィールドによる Conditional Hooks の最小例セットです。

## ファイル一覧

- `.claude/settings.json` — 基本: PostToolUse + Edit|Write matcher で lint
- `examples/settings-conditional.json` — `if` フィールドで `Bash(git push *)` と `Bash(rm -rf *)` を分岐
- `examples/settings-path-ref.json` — `$CLAUDE_PROJECT_DIR` でパスを安全に参照

## 設定の置き場所

- `~/.claude/settings.json` — 自分の全プロジェクト
- `.claude/settings.json` — 単一プロジェクト（git 共有可）
- `.claude/settings.local.json` — 単一プロジェクト（gitignore）
- Managed policy settings — 組織全体
- Plugin の `hooks/hooks.json` — プラグイン有効時
- Skill / agent frontmatter の `hooks:` — コンポーネント有効時のみ

## handler 種別

- `command`: シェル実行（汎用）
- `http`: HTTP POST（外部 validator）
- `mcp_tool`: 接続済み MCP サーバーへ直接呼び出し
- `prompt`: Claude モデルに 1 回問い合わせ
- `agent`: サブエージェント spawn（実験的）

## 関連

- レシピ06「パーミッション設計」
- レシピ76「20+ Hooks イベント完全マップ」
- レシピ78「マッチャーパターンでツールをフィルタリング」
- レシピ79「Hooksのデバッグ + 大出力ディスク永続化」
