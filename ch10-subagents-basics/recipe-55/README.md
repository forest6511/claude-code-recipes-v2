# レシピ55: Taskツールの仕組みと独立コンテキスト

組み込みサブエージェントの起動と、独立コンテキストの境界を理解するための入門レシピです。

## 含まれるサンプル

- `.claude/agents/file-summarizer.md` — 読み取り専用ツールに絞った最小カスタムサブエージェント。Haiku モデルで動作し、長大なファイル/ログを 5〜10 個の箇条書きに要約する

## 動作確認

このディレクトリをプロジェクトルートとして Claude Code を起動した状態で、以下のように呼び出します。

```text
file-summarizer サブエージェントを使って tests/output.log を要約して
```

または明示的にメンションで起動:

```text
@agent-file-summarizer summarize tests/output.log
```

## 関連レシピ

- レシピ56「エージェント種別の使い分け」
- レシピ57「カスタムエージェント + initialPrompt + /agents tabbed」
- レシピ58「サブエージェントの権限制御とツール制限」
