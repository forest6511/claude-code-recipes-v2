# レシピ92: Issue駆動開発ワークフロー

GitHub Issue を入力に、優先度判定・実装・PR 作成までを通す Skills セット。

## ファイル一覧

- `.claude/skills/list-issues/SKILL.md`: Open Issue を `gh issue list` で取得し優先度付け
- `.claude/skills/work-issue/SKILL.md`: Issue 番号 $ARGUMENTS からブランチ作成・実装・PR 作成

## 使い方

1. `/list-issues` で Open Issue を P0-P4 で並び替え
2. `/work-issue 142` で Issue #142 を実装し PR 作成（`Closes #142` 込み）
3. ヘッドレス並列処理: `gh issue list --label auto-fixable --json number --jq '.[].number' | while read num; do claude --bare -p "#$num を /work-issue で..." ...; done`

詳細は本書のレシピ92を参照。
