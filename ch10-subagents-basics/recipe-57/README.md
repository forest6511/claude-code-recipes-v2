# レシピ57: カスタムエージェント + initialPrompt + /agents tabbed

プロジェクト固有のサブエージェント定義、`initialPrompt` でセッション開始時の自動プロンプト、`.claude/settings.json` でのデフォルトエージェント指定を扱う中級レシピです。

## 含まれるサンプル

- `.claude/agents/api-reviewer.md` — 通常のサブエージェント呼び出し用 API レビュアー (Sonnet, 読み取り専用 + git)
- `.claude/agents/api-reviewer-session.md` — `claude --agent` でメインセッションエージェントとして起動する版。`initialPrompt` で `git diff` 取得 + 自動レビューを開始
- `.claude/settings.json` — プロジェクトのデフォルトエージェントに `api-reviewer-session` を指定

## 動作確認

通常呼び出し:

```text
@agent-api-reviewer review the changes in src/routes/users.ts
```

メインセッションとして起動:

```bash
claude --agent api-reviewer-session
```

`initialPrompt` が自動送信され、`git diff origin/main...HEAD` の差分から API レビューが開始されます。

## 関連レシピ

- レシピ55「Taskツールの仕組みと独立コンテキスト」
- レシピ56「エージェント種別の使い分け」
- レシピ58「サブエージェントの権限制御とツール制限」
- レシピ59「Context engineering」
