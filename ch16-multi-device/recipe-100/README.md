# レシピ100: Routines で雲定期実行 + alert triage

Anthropic 雲インフラ上で動く Claude Code routine の構成サンプル。スケジュール / API / GitHub の 3 種類の trigger を組み合わせ、自律的なバックログ整理 / alert triage / PR レビューを動かす。

## 必要要件

- Pro / Max / Team / Enterprise プランで Claude Code on the web が有効
- claude.ai アカウント認証
- GitHub App install (GitHub trigger 利用時)
- routine 操作対象の MCP connectors (Linear / Slack 等) を事前接続

## ファイル一覧

- `routines/alert-triage/PROMPT.md`: alert triage routine の prompt テンプレート
- `routines/backlog-grooming/PROMPT.md`: 毎営業日夜実行の backlog 整理 prompt
- `examples/trigger-alert.sh`: API trigger を curl で叩くサンプル

## 使い方

1. claude.ai/code/routines で New routine
2. `routines/<name>/PROMPT.md` の中身を貼り付け
3. リポジトリ / 環境 / connectors を選択
4. trigger を選択 (Schedule / API / GitHub event の 1 つ以上)
5. Save → `Run now` で動作確認

API trigger を発火するには:
```
ROUTINE_ID=trig_01XXX ROUTINE_TOKEN=sk-ant-oat01-xxx \
  ./examples/trigger-alert.sh "Sentry alert SEN-4521 fired in prod"
```

## 安全装置

- デフォルトで `claude/` プレフィックスブランチのみ push 可能 (Allow unrestricted で解除)
- connector は「現在接続中すべて」が初期値、不要分は外す
- API token は表示直後に secret store へ保存 (再表示不可、Regenerate で rotate)
- 1 時間より短い schedule は拒否される
- `experimental-cc-routine-2026-04-01` ベータヘッダー必須

## 出典

- 公式 docs: https://code.claude.com/docs/en/routines
- API リファレンス: https://platform.claude.com/docs/en/api/claude-code/routines-fire
