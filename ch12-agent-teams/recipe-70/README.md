# レシピ70: バックグラウンド実行

サブエージェントや Bash タスクをバックグラウンドで実行し、メイン会話をブロックせずに長時間処理を進めるパターンの例です。`background: true` 指定、`Ctrl+B`、事前承認モデル、SubagentStop Hooks 通知を扱います。

## ファイル一覧

- `.claude/agents/long-test-runner.md`: `background: true` を持つ長時間テスト実行サブエージェント定義
- `.claude/settings.json`: SubagentStop で macOS 通知を送る Hook 設定例
- `prompts/background-usage.txt`: バックグラウンド実行の使い方と結果確認のプロンプト例
- `prompts/monitoring-patterns.txt`: Agent Teams での監視パターン（キーバインド一覧）

## 使い方

### 自動でバックグラウンド起動する

`.claude/agents/long-test-runner.md` を配置すると、`long-test-runner` を起動するたびに毎回バックグラウンド実行になります。

```text
> long-test-runner サブエージェントで E2E テストを実行してください
```

### 走行中に背景化する

`background: true` を設定していないサブエージェントでも、走行中に `Ctrl+B` を押すとその時点でバックグラウンドに切り替えられます。Bash タスクも同様です。

### 全体で無効化する

```bash
export CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1
```

`background: true` も `Ctrl+B` も `run_in_background` パラメータも含めて、すべての背景化機能が無効になります。CI のヘッドレス環境向け。

## 進捗確認

- `/agents` の Running タブに走行中のバックグラウンドサブエージェントが表示される
- `Shift+Down` でサブエージェントをサイクル
- `Enter` で個別セッションを開いて中間出力を確認
- `@agent-<name>` の typeahead で追加メッセージを送信

## 関連レシピ

- レシピ55「Taskツールの仕組みと独立コンテキスト」
- レシピ63「テスト実行とレポート集約（バックグラウンド）」
- レシピ85「Notification通知 + sessionTitle」
- レシピ88「Stop Hooks」
