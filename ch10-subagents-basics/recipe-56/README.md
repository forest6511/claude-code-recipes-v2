# レシピ56: エージェント種別の使い分け

組み込みサブエージェント Explore / Plan / general-purpose の選択基準と、ヘルパー (statusline-setup, Claude Code Guide) や fork との関係を扱う中級レシピです。

## 含まれるサンプル

- `.claude/settings.json` — `CLAUDE_CODE_FORK_SUBAGENT=1` を有効化する project 設定例。`/fork` コマンドが利用可能になり、Claude が general-purpose を起動する場面で代わりに fork が起動するようになる。実験的機能で v2.1.117 以降が必要

## 動作確認

このディレクトリでセッションを開始した状態で:

```text
@agent-Explore find every file mentioning the legacy session token
```

または fork:

```text
/fork draft unit tests for the parser changes so far
```

## 関連レシピ

- レシピ55「Taskツールの仕組みと独立コンテキスト」
- レシピ57「カスタムエージェント + initialPrompt + /agents tabbed」
- レシピ58「サブエージェントの権限制御とツール制限」
