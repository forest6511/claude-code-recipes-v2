# レシピ89: MCP+Skills+Hooks 品質ゲートパイプライン

PostToolUse Hook（編集直後の format/lint）、Stop Hook + Skills（ターン終了時の typecheck/test/audit）、Code Review managed service + REVIEW.md（PR 提出時の最終レビュー）を 3 層に重ねる構成のサンプルです。

## ファイル一覧

- `.claude/settings.json`: Layer 1（PostToolUse の Edit|Write matcher で Prettier+ESLint）と Layer 2（Stop の prompt 型 hook で品質ゲート未実行時にブロック）
- `.claude/skills/quality-gate/SKILL.md`: `disable-model-invocation: true` で `/quality-gate` 専用 Skills として明示起動
- `REVIEW.md`: Code Review managed service への severity 定義・nit cap・必須チェック項目
- `.github/workflows/severity-gate.yml`: check run 完了時に `bughunter-severity` を読み出し、Important が 1 件以上なら CI を fail させる severity ゲート

## 使い方

1. Claude Code v2.1 系で `.claude/settings.json` を読み込ませる（プロジェクトスコープ推奨）
2. `/quality-gate` で Skills を明示起動。コード変更ありのターン終了で Stop Hook が起動を促す
3. PR 提出後、Code Review が REVIEW.md に従ってインライン指摘。`severity-gate.yml` が Important 件数で CI を gate

詳細は本書のレシピ89を参照。
