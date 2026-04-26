# レシピ43: GitワークフローSkills

コミットメッセージ・PR description・ブランチ命名・リリース準備の4 Skill。すべて提案出力までで止まり、副作用のあるコマンドは Skill 内で実行しない。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/commit-message/SKILL.md` | Conventional Commits 形式メッセージの生成 |
| `.claude/skills/pr-description/SKILL.md` | ブランチ差分から PR description ドラフト生成 |
| `.claude/skills/new-branch/SKILL.md` | 機能説明からブランチ名を命名規約に沿って提案 |
| `.claude/skills/release-prep/SKILL.md` | バージョンバンプ + CHANGELOG エントリ |

## 共通設計

- 4つすべて `disable-model-invocation: true` で明示起動限定
- `git commit` / `git push` / `gh pr create` / `git tag <name>` の副作用コマンドは
  `allowed-tools` に含めない（読み取り系のみ）
- `pr-description` と `release-prep` は `context: fork` で diff/ログ全体を fork に逃がす

## 呼び出し例

```text
> /commit-message
> /pr-description
> /new-branch ユーザー認証のOAuth対応
> /release-prep 1.2.0
```
