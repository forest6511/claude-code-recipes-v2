# レシピ46: Headless実行用Skills + /autofix-pr cap

CI/cron での非対話実行 (`claude -p`) と `/autofix-pr` 制約付きラッパーのサンプル。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/headless-template/SKILL.md` | JSON 構造化出力のテンプレート Skill |
| `.claude/skills/autofix-bounded/SKILL.md` | `/autofix-pr` の制約付きラッパー (最大コミット数・スコープ限定) |
| `.github/workflows/quality-gate.yml` | scan 失敗時のみ autofix を起動する2段ジョブ |

## 共通設計

- 全 Skill が `disable-model-invocation: true` で CI 上の意図しない自動起動を防止
- `effort: medium` 推奨 (CI でのコスト管理)
- 出力は JSON 構造化、`jq` でパース可能

## CI 起動例

```bash
claude -p "/security-scan-all" --output-format json
claude -p "/autofix-bounded lint と型エラーのみ"
```
