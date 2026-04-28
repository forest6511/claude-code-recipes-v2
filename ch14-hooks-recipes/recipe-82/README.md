# Recipe 82: 危険コマンドブロック + Auto Mode retry

PreToolUse + `if` フィールドで Bash サブコマンド変種を捕捉し、`permissionDecision: "deny"` で危険コマンドをブロック。Auto Mode の classifier 誤判定は PermissionDenied hook の `retry: true` で回復させる 2 層構成。

## ファイル構成

- `.claude/settings.json` — 危険パターン 3 種 (rm -rf / git push --force / curl | bash) を別 handler に分けて登録
- `.claude/hooks/block-rm-rf.sh` — allow リスト (./dist /build /node_modules) 内側持ちで rm -rf を deny
- `.claude/hooks/block-force-push.sh` — main/master/production への force push を `permissionDecision: "deny"` でブロック
- `.claude/hooks/block-curl-pipe-bash.sh` — `curl ... | bash` パイプパターンをブロック
- `.claude/hooks/auto-mode-recover.sh` — PermissionDenied で「path outside」系の誤判定だけ `retry: true` を返す
- `.claude/hooks/log-denials.sh` — Auto Mode の denial を JSONL 蓄積 (環境設定見直しの素材)
- `examples/block-force-push-exitcode.sh` — exit 2 形式の比較例
- `examples/settings-permission-denied.json` — PermissionDenied hook の登録例

## 設計の要点

- `if: "Bash(rm -rf *)"` は VAR=value 接頭辞や `&&` 連結後のサブコマンドにもマッチ (公式 hooks.md L298 仕様)
- deny リストではなく allow リストを内側に持つ (新しい変種に対し fail-closed)
- `permissionDecision: "deny"` (JSON) と exit 2 (stderr) は要件で使い分け
- PermissionDenied は Auto Mode 限定、PreToolUse の deny / 手動 deny / permissions deny rules では発火しない
- Auto Mode は連続 3 回 / 累積 20 回の denial で pause (公式 permission-modes.md L192)

## 参照

- `~/.claude/docs/claude-code/hooks.md` How a hook resolves 節 (L60-140)、PermissionDenied 節 (L1404-1448)
- `~/.claude/docs/claude-code/permission-modes.md` Eliminate prompts with auto mode 節 (L136-200)
- `~/.claude/docs/claude-code/auto-mode-config.md`
- `~/.claude/docs/claude-code/permissions.md` Tool-specific permission rules
