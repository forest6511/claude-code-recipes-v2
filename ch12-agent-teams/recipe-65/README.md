# レシピ65: Agent Teams基礎

Agent Teams（実験的機能）を有効化し、リーダー1名・チームメイト複数名・共有タスクリスト・メッセージングという最小構成でチームを起動する例です。

## ファイル一覧

- `settings.json`: Agent Teams を有効化するプロジェクト設定例
- `prompts/team-creation.txt`: 3人構成のチームを作成するプロンプト例

## 前提条件

- Claude Code v2.1.32 以降
- in-process モードのみで利用する場合は追加ツール不要
- split panes モードを使う場合は `tmux` または iTerm2 + `it2` CLI が必要

## 使い方

1. `settings.json` をプロジェクトの `.claude/settings.json` に配置するか、`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` を環境変数として設定する
2. リーダーセッションで `claude` を起動する
3. `prompts/team-creation.txt` の内容をリーダーに送り、3人のチームメイト構成でチームを作る
4. Shift+Down でチームメイト間をサイクルし、Enter でセッションに入って状況を確認する
5. 作業終了時はリーダーに `Clean up the team` と依頼する

## 表示モード

`teammateMode` の値は次の3つです。

- `auto`（デフォルト）: tmux セッション内で起動した場合のみ split panes、それ以外は in-process
- `in-process`: 全チームメイトをメインターミナル内に配置する
- `tmux`: split panes を強制する。tmux または iTerm2 が必要

## 関連レシピ

- レシピ55「Taskツールの仕組みと独立コンテキスト」
- レシピ60「並列実行で大規模コードベースを高速調査」
- レシピ67「共有タスクリストと自律スケジューリング」
- レシピ74「70/20/10 Advisor でチームコスト最適化」
