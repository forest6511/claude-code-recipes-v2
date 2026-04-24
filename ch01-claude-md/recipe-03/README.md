# Recipe 03: .claude/rules/で条件付きルールを設定する

`.claude/rules/` ディレクトリで path-scoped なプロジェクトルールを配置する例。

## ファイル構成

- `.claude/rules/general.md` — paths なしの無条件ルール
- `.claude/rules/typescript.md` — `src/**/*.ts` / `src/**/*.tsx` 対象
- `.claude/rules/testing.md` — `tests/**/*.test.ts` / `**/*.spec.ts` 対象
- `.claude/rules/frontend/components.md` — サブディレクトリ配置 + `src/components/**/*.tsx` 対象
- `.claude/settings.local.json` — `InstructionsLoaded` Hook でロード状況をログ記録

## 関連レシピ

- レシピ01 effective-claude-md
- レシピ02 claude-md-hierarchy
- レシピ04 monorepo-claude-md
