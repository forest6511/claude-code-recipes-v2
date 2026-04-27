# Recipe 79: Hooksのデバッグ + 大出力ディスク永続化

`/hooks` → `/doctor` → `claude --debug hooks` の順で問題を切り分け、大出力 Hook はディスク永続化と `asyncRewake` を組み合わせて context を圧迫しない設計にする。

## ファイル構成

- `.claude/scripts/run-debug.sh` — `CLAUDE_CODE_DEBUG_LOG_LEVEL=verbose` + `--debug-file` でタイムスタンプ付きログを書き出す起動ラッパー
- `.claude/hooks/lint-with-disk.sh` — ESLint 出力をファイルに永続化し、Claude には件数と path だけ返すサンプル Hook
- `.claude/settings.json` — `asyncRewake: true` で長時間 Hook を背景化し、失敗時のみ Claude を起こす設定例

## 使い方

```bash
chmod +x .claude/scripts/run-debug.sh .claude/hooks/lint-with-disk.sh

# debug ログを取りながら起動
./.claude/scripts/run-debug.sh

# 別ターミナルでログを尾追い
tail -f ~/.claude/debug/hooks-*.log | grep -E "DEBUG.*hook"
```

## 参照

- `~/.claude/docs/claude-code/hooks.md` Debug hooks 節
- `~/.claude/docs/claude-code/debug-your-config.md` Check hooks 節
