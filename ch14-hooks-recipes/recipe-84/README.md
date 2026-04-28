# Recipe 84: ファイル変更時自動テスト + FileChanged/CwdChanged

外部プロセス由来のファイル変更 (CI runner / 別ターミナル / Docker volume / IDE format-on-save) と、Claude の cd によるディレクトリ移動を捕まえる FileChanged + CwdChanged の組み合わせ。direnv との標準連携パターン。

## ファイル構成

- `.claude/settings.json` — `.env|.envrc|.tool-versions` と `package.json|pnpm-lock.yaml|yarn.lock` の watch
- `.claude/hooks/reload-env.sh` — FileChanged で env ファイル変更時に `CLAUDE_ENV_FILE` 経由で次の Bash に伝搬
- `.claude/hooks/cwd-direnv.sh` — CwdChanged で direnv export を `CLAUDE_ENV_FILE` に流し、移動先の `.env*` を `watchPaths` で動的追加
- `.claude/hooks/notify-deps-change.sh` — 依存関係マニフェストの外部変更を `additionalContext` で Claude に通知
- `examples/settings-cwd-changed.json` — CwdChanged 登録例

## 設計の要点

- FileChanged の matcher は `|` 区切り literal filename (regex 不可)、Hook 起動後の filter 段階のみ通常 matcher ルール
- `CLAUDE_ENV_FILE` は SessionStart / CwdChanged / FileChanged の 3 event 限定で利用可能
- `watchPaths` は動的レイヤー、settings.json の matcher 由来 watch は静的に常時有効
- CwdChanged は matcher 非対応で必ず発火、軽量な hook のみ
- FileChanged / CwdChanged は decision control なし (async event)、ブロックは PreToolUse 側で

## 参照

- `~/.claude/docs/claude-code/hooks.md` FileChanged 節 (L1889-1928)、CwdChanged 節 (L1856-1887)、Persist environment variables 節 (L811)
