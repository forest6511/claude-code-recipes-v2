# Recipe 80: Monitor tool + /loop で能動監視・自己ペーシング

Hooks では実現できない「Claude のアクションと無関係に背景で動き続け、外部 event 起点で Claude を起こす」用途を Monitor tool と /loop で実装する。

## ファイル構成

- `.claude/loop.md` — bare `/loop` 実行時に組み込みメンテナンスプロンプトを上書きするカスタム指示。release ブランチの PR ヘルスチェックの例

## 使い方

```bash
# Claude Code セッション内で
> /loop                                                 # loop.md を実行（自己ペーシング）
> /loop 5m check the deploy                             # 固定 5 分間隔
> /loop check whether CI passed                         # 自己ペーシング (Monitor tool 自動切替の可能性)
> /loop 20m /review-pr 1234                             # 別スラッシュコマンドの定期実行
> infra/ci.log を tail して ERROR が出たら教えて        # Monitor tool で event 駆動

# 停止
Esc                                                     # 次回発火待ちの loop をクリア
> stop the deploy check loop                            # 名前で明示停止

# 管理
> what scheduled tasks do I have?                       # CronList
> cancel the deploy check job                           # CronDelete
```

## バージョン要件

- `/loop`: Claude Code v2.1.72+
- Monitor tool: Claude Code v2.1.98+

## 利用不可な環境

- Amazon Bedrock / Google Vertex AI / Microsoft Foundry: Monitor 不可、自己ペーシング `/loop` は 10 分固定にフォールバック、bare `/loop` は usage メッセージのみ
- `DISABLE_TELEMETRY=1` または `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1`: Monitor 無効化
- `CLAUDE_CODE_DISABLE_CRON=1`: スケジューラ全体無効化

## 参照

- `~/.claude/docs/claude-code/tools-reference.md` Monitor tool 節 (L74-91)
- `~/.claude/docs/claude-code/scheduled-tasks.md` 全文
- `~/.claude/docs/claude-code/commands.md` `/loop` 行 (L56)
