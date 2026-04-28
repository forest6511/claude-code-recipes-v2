# Recipe 85: Notification通知 + sessionTitle

Notification の 4 種類 (permission_prompt / idle_prompt / auth_success / elicitation_dialog) を matcher で振り分け、UserPromptSubmit の hookSpecificOutput.sessionTitle で自動セッション命名を組み合わせる構成。

## ファイル構成

- `.claude/settings.json` — permission_prompt と idle_prompt の matcher 振り分け
- `.claude/hooks/notify-permission.sh` — macOS osascript デスクトップ通知 + サウンド
- `.claude/hooks/notify-idle.sh` — Slack incoming webhook (SLACK_WEBHOOK_URL 環境変数)
- `.claude/hooks/auto-title.sh` — UserPromptSubmit でプロンプト先頭 50 文字を sessionTitle に設定 (マーカーファイルで最初の 1 回のみ)
- `examples/settings-auto-title.json` — UserPromptSubmit 登録例
- `examples/notify-with-title.sh` — 通知メッセージにセッションタイトルを併記する例

## 設計の要点

- Notification は decision control なし、すでに発火した通知への副作用追加用
- 4 種類の notification_type で緊急度を分ける (permission > idle > auth_success > elicitation_dialog)
- sessionTitle は Notification ではなく **UserPromptSubmit の hookSpecificOutput**
- UserPromptSubmit は matcher 非対応で毎ターン発火、マーカーファイルで上書き防止
- webhook URL は環境変数で渡す (.env 編集禁止と整合、レシピ83 参照)

## 参照

- `~/.claude/docs/claude-code/hooks.md` Notification 節 (L1450-1503)、UserPromptSubmit decision control 節 (L883-905)
- `~/.claude/docs/claude-code/hooks-guide.md` Show desktop notifications 節
