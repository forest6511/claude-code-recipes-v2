# レシピ90: Spec駆動開発ワークフロー

要件抽出（インタビュー）→ 設計確定（Plan Mode）→ 実装（フレッシュセッション）の 3 段で SPEC.md を中継する Skills セット。

## ファイル一覧

- `.claude/skills/spec-create/SKILL.md`: `AskUserQuestion` で要件をインタビューし `specs/{slug}.md` に書き出す
- `.claude/skills/spec-status/SKILL.md`: `specs/*.md` の `- [x]` / `- [ ]` を集計し、未確定論点が残るファイルを警告

## 使い方

1. `/spec-create ユーザー認証` で SPEC.md を生成（インタビュー実施）
2. 別セッションを `claude --permission-mode plan` で起動し、`@specs/...md` を入力に Plan Mode で計画
3. 承認後に Normal Mode、または新セッションで実装。受け入れ基準を 1 つずつ `[x]` 化
4. `/spec-status` で進捗集計

詳細は本書のレシピ90を参照。
