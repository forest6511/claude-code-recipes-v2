# レシピ38: context:forkでサブエージェント実行

`context: fork` でサブエージェントの独立コンテキストに重い処理を逃がし、メインにはサマリだけ返すサンプル。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/deep-research/SKILL.md` | Explore エージェントで認証フロー等を徹底調査 |
| `.claude/skills/security-scan/SKILL.md` | カスタム `security-auditor` エージェントで OWASP 監査 |
| `.claude/skills/pr-summary-fork/SKILL.md` | `` !`gh pr diff` `` を fork 先で消費して要約 |
| `.claude/agents/security-auditor.md` | セキュリティ監査専用カスタムサブエージェント定義 |

## 呼び出し例

```text
> /deep-research 認証フロー
> /security-scan src/auth/
> /pr-summary-fork
```

## agent 種別

| agent 値 | 特徴 |
|---------|------|
| `Explore` | 読み取り専用、Haiku ベース・低レイテンシ |
| `Plan` | 計画モード中の調査用（読み取り専用、メインのモデル継承） |
| `general-purpose`（デフォルト） | 全ツール、複雑な多段階タスク |
| カスタム名 (`security-auditor` 等) | `.claude/agents/<name>.md` で定義した専門エージェント |
