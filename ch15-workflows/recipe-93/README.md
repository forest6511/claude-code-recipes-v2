# レシピ93: Remote Control + /team-onboarding でチーム開発

事前ハンドオフ (`/team-onboarding`) と実時間ハンドオフ (Remote Control) の 2 段でチーム開発を回す構成。

## ファイル一覧

- `.claude/settings.json`: チーム共通の permissions.allow / env / model 設定。新人が承認ダイアログで止まらない最小許可リスト

## 使い方

1. 経験者が `/team-onboarding` でセットアップガイドを生成し、レビュー後 `docs/team-onboarding.md` に commit
2. 共通設定 (`.claude/settings.json`) を本サンプルに合わせて配置
3. 新人がペアプロ希望時に `claude --remote-control "..."` でセッションを公開、経験者が `claude.ai/code` から合流
4. サーバーモードでチームのヘルプ要求を 1 か所で受ける場合は `claude remote-control --capacity 4 --spawn worktree`
5. `/config` で push 通知を有効化、`/mobile` でモバイルアプリ連携

詳細は本書のレシピ93を参照。
