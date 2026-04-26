# レシピ40: コードレビューSkills

汎用コードレビュー、セキュリティ専門レビュー、レビュー結果から PR description を生成する複合 Skill の3パターン。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/code-review/SKILL.md` | 5観点 × 4重要度の汎用コードレビュー |
| `.claude/skills/security-review/SKILL.md` | OWASP Top 10 マッピングのセキュリティ専用レビュー |
| `.claude/skills/review-and-summarize/SKILL.md` | レビュー → 通過時に PR description ドラフト生成 |

## 共通設計

- `context: fork` + `agent: Explore` で diff をメイン会話から隔離
- `allowed-tools` は読み取り系 + `git diff:*` `git log:*` のみ
- 重要度は Critical / High / Medium / Low の4段階で統一

## 呼び出し例

```text
> /code-review
> /code-review src/auth/login.ts
> /security-review src/auth/
> /review-and-summarize
```
