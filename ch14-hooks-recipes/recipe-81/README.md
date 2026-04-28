# Recipe 81: コミット前に自動lint/formatを実行する

PostToolUse + Edit|Write matcher で編集直後に format + lint を走らせ、エラーは `decision: "block"` で Claude にフィードバックして自動修正させる。最終的なコミット直前ゲートは Stop hook で別途用意する 2 段階構成。

## ファイル構成

- `.claude/settings.json` — Prettier 単体パターン (公式 hooks-guide.md L171-193 準拠)、TS/JS のみ if フィルタ
- `.claude/hooks/lint-after-edit.sh` — TS/Python/Go の lint を言語別に走らせる hook
- `.claude/hooks/format-and-lint.sh` — format + lint を 1 つの pipeline にまとめた hook (format は冪等、lint だけ block)
- `.claude/hooks/pre-commit-gate.sh` — Stop hook 用のコミット前最終ゲート (git diff 経由)
- `examples/settings-combined.json` — format-and-lint.sh を呼ぶ PostToolUse 登録例 (timeout 60、statusMessage)
- `examples/settings-stop-gate.json` — pre-commit-gate.sh を呼ぶ Stop hook 登録例

## 使い方

```bash
chmod +x .claude/hooks/*.sh

# format-and-lint パターンを採用するなら
cp examples/settings-combined.json .claude/settings.json

# Stop hook ゲートを併用するなら .claude/settings.json にマージ
```

## 設計の要点

- `if` フィールドで拡張子フィルタ → matcher (tool 名) では絞れない言語別フィルタを実現
- `decision: "block"` は PostToolUse で「実行ブロック」ではなく「Claude へのフィードバック」
- format は `|| true` で握りつぶす (冪等)、lint だけブロック対象 (意味判定要)
- `timeout: 60` でデフォルト 600 秒を短縮 (編集のたびに 10 分待ちを防止)

## 参照

- `~/.claude/docs/claude-code/hooks-guide.md` Auto-format code after edits 節 (L171-193)
- `~/.claude/docs/claude-code/hooks.md` Decision control 節 (L661-680)、Common fields 節 (L286-310)
