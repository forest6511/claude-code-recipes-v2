# レシピ96: Channels で Telegram/Discord から Claude を駆動

公式 channel プラグイン（Telegram / Discord / iMessage / fakechat）を使い、外出先からローカル Claude Code セッションへメッセージを流し込む構成のサンプル。

## 必要要件

- Claude Code v2.1.80+ (Channels は research preview)
- claude.ai アカウントでのログイン (API キー / Console 認証は不可)
- Bun (`bun --version` で確認、未導入なら https://bun.sh )
- Team / Enterprise の場合は管理者が `channelsEnabled: true` を設定

## 使い方 (Telegram の場合)

1. BotFather (`https://t.me/BotFather`) に `/newbot` でボット作成、トークンを取得
2. `/plugin install telegram@claude-plugins-official` でプラグイン導入
3. `/reload-plugins` で configure コマンド有効化
4. `/telegram:configure <token>` でトークン保存 (`~/.claude/channels/telegram/.env`)
5. `claude --channels plugin:telegram@claude-plugins-official` で再起動
6. ボットに任意のメッセージを送信、返ってきたペアリングコードを `/telegram:access pair <code>` で承認
7. `/telegram:access policy allowlist` で送信者を絞る

Discord も同様 (`/plugin install discord@claude-plugins-official` + `/discord:configure` + `/discord:access pair`)。

## セキュリティ注意

- `policy allowlist` 必須 (デフォルトで誰でも送れる状態は避ける)
- `--channels` を渡さない起動では届かないので、信用境界を起動オプションで管理
- 自分の bot が公開ボットであることを忘れない (送信元 ID の allowlist 制御がすべて)

詳細は本書のレシピ96を参照。

## 出典

- 公式 docs: https://code.claude.com/docs/en/channels
- 公式プラグイン: https://github.com/anthropics/claude-plugins-official/tree/main/external_plugins
