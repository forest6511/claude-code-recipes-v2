---
name: security-deps
description: 依存ライブラリの既知脆弱性 (CVE) を検出する
disable-model-invocation: true
context: fork
agent: general-purpose
allowed-tools: Read Bash(npm audit *) Bash(pip-audit *) Bash(go list *) Bash(govulncheck *) Bash(cargo audit *)
---

リポジトリ言語を自動判定し、適切なツールでスキャンします。

## 言語別コマンド
- Node.js: `npm audit --json`
- Python: `pip-audit --format json`
- Go: `govulncheck ./...`
- Rust: `cargo audit --json`

## タスク
1. ルートに `package.json` / `pyproject.toml` / `go.mod` / `Cargo.toml` のいずれが存在するか確認
2. 該当言語のスキャンコマンドを実行
3. 検出結果を以下に分類:
   - **Critical**: CVSS 9.0+, 修正パッチあり、運用に exploit 可能
   - **High**: CVSS 7.0-8.9
   - **Medium**: CVSS 4.0-6.9
   - **Low**: CVSS < 4.0 または exploit 困難
4. パッケージ名 → CVE 番号 → 推奨アップグレード先 → 重要度の4要素で出力
