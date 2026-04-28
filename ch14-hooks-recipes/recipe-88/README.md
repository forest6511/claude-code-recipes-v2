# Recipe 88: Stop Hooks

Stop / SubagentStop / StopFailure の 3 イベントの責務分担と quality gate 構成の総括。

## ファイル構成

- `.claude/settings.json` — Stop hook の quality gate 登録
- `.claude/hooks/quality-gate.sh` — テスト失敗 / 未コミット変更 / TODO/FIXME を機械検査して decision: "block" 、stop_hook_active で無限ループ防止
- `.claude/hooks/log-stop-failure.sh` — StopFailure を JSONL ログ + rate_limit はデスクトップ通知
- `.claude/hooks/subagent-summary.sh` — subagent 内 Stop hook (自動的に SubagentStop 変換) で last_assistant_message を summary 蓄積
- `.claude/hooks/log-subagent-result.sh` — メイン会話側 SubagentStop で agent_type 別ログ
- `.claude/agents/code-reviewer.md` — Stop hook frontmatter の subagent (実行時 SubagentStop 変換例)
- `examples/settings-subagent-stop.json` — SubagentStop matcher 振り分け
- `examples/settings-stop-failure.json` — StopFailure の 7 エラー種別 matcher
- `examples/settings-stop-llm.json` — prompt 型 Stop hook (LLM 意味判定)

## 設計の要点

- 3 イベント (Stop / SubagentStop / StopFailure) は排他、user interrupt では発火しない
- stop_hook_active で無限ループ防止が必須 (decision: "block" → 再開 → block の連鎖)
- subagent 内 frontmatter の `Stop` は自動的に SubagentStop に変換 (公式 hooks.md Hooks in skills and agents 節)
- StopFailure は decision control なし、記録 / 通知専用
- StopFailure の matcher 値: rate_limit / authentication_failed / billing_error / invalid_request / server_error / max_output_tokens / unknown
- prompt 型 Stop hook は内部で再発火制御を Claude Code 側が処理、stop_hook_active チェック不要

## 参照

- `~/.claude/docs/claude-code/hooks.md` Stop 節 (L1675-1711)、SubagentStop 節 (L1539-)、StopFailure 節 (L1713-1739)、Hooks in skills and agents 節
