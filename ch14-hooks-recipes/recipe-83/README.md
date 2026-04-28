# Recipe 83: 環境変数・機密情報の漏洩を防止する

機密情報の漏洩経路を「ファイル」「内容」「コマンド」の 3 経路に分け、それぞれに専用 Hook を当てる多層防御構成。CLAUDE.md と Hook の二段構えで「予防 + 強制」を分離。

## ファイル構成

- `.claude/settings.json` — `.env` / `credentials.json` / `*.pem` / `*.key` への編集を全面拒否
- `.claude/hooks/block-secret-files.sh` — 機密ファイル編集を `permissionDecision: "deny"` でブロック
- `.claude/hooks/scan-secret-patterns.sh` — 書き込み内容に AWS / GitHub / OpenAI / Anthropic / Slack / PEM のトークンパターンが含まれていないか検査
- `.claude/hooks/block-secret-bash.sh` — Bash で `echo $AWS_SECRET_ACCESS_KEY` や `cat .env` をブロック
- `examples/settings-bash-scan.json` — Bash + Edit/Write の両方を検査する登録例
- `CLAUDE.md` — 機密情報取り扱いの方針 (Hook の前にまず Claude にルールを伝える)

## 設計の要点

- 機密ファイルは「許可リスト内側持ち」が逆効果のため全面拒否
- 機密パターン正規表現は誤検出を抑えるため各サービス固有の prefix と長さで絞る (汎用検出は trufflehog/gitleaks に委ねる)
- Bash の `echo $SECRET` 系は最も無自覚な漏洩経路、専用 Hook で塞ぐ
- fingerprint 形式 `${VAR:0:4}...(len=${#VAR})` をデバッグ標準にする
- Hook 内で `set -x` を使わない (展開された値が hook ログに残る)

## 参照

- `~/.claude/docs/claude-code/hooks.md` PreToolUse 節、PreToolUse decision control 節
- `~/.claude/docs/claude-code/permissions.md` Tool-specific permission rules (Edit ルールが Write/MultiEdit にも適用)
