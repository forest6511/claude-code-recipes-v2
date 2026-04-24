# Recipe 02: CLAUDE.md階層設計

本レシピのサンプル。Claude Code の 4 スコープ (Managed / User / Project / Local) のうち、プロジェクト配下で配置するファイルを示す。

## ファイル構成

- `CLAUDE.md` — team-shared 方針（バージョン管理下）
- `CLAUDE.local.md` — 個人のみのプロジェクト設定（`.gitignore` に追加する想定）
- `.claude/settings.local.json` — `claudeMdExcludes` の設定例

## 関連レシピ

- レシピ01 effective-claude-md
- レシピ03 path-scoped-rules
- レシピ04 monorepo-claude-md
