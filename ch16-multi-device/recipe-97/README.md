# レシピ97: Channel Permission Relay でスマホから承認

双方向チャネルに `claude/channel/permission` capability を加え、Claude Code の権限プロンプトを外側へ転送して遠隔承認するサンプル。

## 必要要件

- Claude Code v2.1.81+ (permission relay は v2.1.80 では動作しない)
- claude.ai アカウント認証
- Bun (`bun --version` で確認)
- 双方向チャネル（reply tool を持つこと）

## ファイル一覧

- `webhook-channel/webhook.ts`: フル webhook チャネル (reply tool + sender gating + permission relay)
- `webhook-channel/.mcp.json`: bun でサーバ起動するための MCP 設定

## 動作確認

3 ターミナルで実行する。

1. **Claude Code セッション**:
   ```
   cd webhook-channel
   claude --dangerously-load-development-channels server:webhook
   ```
2. **outbound watcher** (別ターミナル):
   ```
   curl -N localhost:8788/events
   ```
3. **inbound message** (別ターミナル):
   ```
   curl -d "list the files in this directory" -H "X-Sender: dev" localhost:8788
   ```

ローカル端末に permission ダイアログが開き、同時に `/events` ストリームへ「Claude wants to run Bash: ... Reply 'yes <id>' or 'no <id>'」が流れる。承認するには:

```
curl -d "yes <id>" -H "X-Sender: dev" localhost:8788
```

ローカルダイアログが閉じ、ツール実行が続行。

## セキュリティ

- **sender allowlist 必須**: permission relay は強い権限（リモートからツール実行を承認）なので、信頼できる sender のみ許可
- **request_id 5 文字 lowercase (l 除く)**: スマホでの誤読防止 (1/I と混同しない、autocorrect 対応)
- **対象外の操作**: project trust dialog, MCP server consent dialog はリレーされない (対面承認固定)

## 出典

- 公式 docs: https://code.claude.com/docs/en/channels-reference#relay-permission-prompts
