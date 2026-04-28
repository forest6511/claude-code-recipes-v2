# Recipe 86: コード変更前にGitチェックポイントを作成

PreToolUse + Edit/Write/MultiEdit で `git stash --keep-index` による低破壊性 checkpoint。SessionStart/SessionEnd で Git 履歴に明示的なセッション境界を残すオプション併用。公式 `/checkpoint` のセッション内ロールバックと使い分け。

## ファイル構成

- `.claude/settings.json` — PreToolUse + Edit\|Write\|MultiEdit の checkpoint 登録
- `.claude/hooks/git-checkpoint.sh` — `stash push --keep-index` + 連続発火重複防止 (session_id prefix で判定)
- `.claude/hooks/session-start-commit.sh` — SessionStart で pre-session snapshot commit
- `.claude/hooks/session-end-commit.sh` — SessionEnd で post-session snapshot commit
- `.claude/hooks/list-checkpoints.sh` — stash + session boundary commit を一覧
- `examples/settings-bash-checkpoint.json` — Bash(rm *) / git reset --hard / git checkout 直前にも checkpoint
- `examples/settings-session-boundary.json` — SessionStart/SessionEnd の登録例

## 設計の要点

- `stash push --keep-index` で staging を保ち working tree のみ stash、HEAD を進めない最低破壊性
- 連続発火での重複防止は session_id prefix の stash message 比較で実現
- `git diff --quiet HEAD` 早期 return + `git rev-parse --git-dir` リポジトリ判定の 2 段ガード
- `if: "Bash(rm *)"` 等は Common fields 仕様で 1 ルールずつ別 handler
- 公式 `/checkpoint` (checkpointing.md) はセッション内ロールバック、Hook 方式は Git 履歴に明示的に残す用途

## 復元手順

```bash
.claude/hooks/list-checkpoints.sh                    # 一覧
git stash apply stash@{N}                            # stash から復元
git reset --hard <claude-session-start commit>       # session 境界に巻き戻し
```

## 参照

- `~/.claude/docs/claude-code/hooks.md` PreToolUse 節、Common fields 節 (if フィールド仕様)、SessionStart/SessionEnd 節
- `~/.claude/docs/claude-code/checkpointing.md`
