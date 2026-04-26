# レシピ44: セキュリティスキャンSkills

コード SAST / 依存関係 CVE / 機密情報 / IaC の4観点を専門 Skill に分割し、集約 Skill (`security-scan-all`) で統合する構成。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/security/sast/SKILL.md` | Semgrep でコード SAST、OWASP Top 10 マッピング |
| `.claude/skills/security/deps/SKILL.md` | npm audit / pip-audit / govulncheck / cargo audit による CVE 検出 |
| `.claude/skills/security/secrets/SKILL.md` | gitleaks で機密情報スキャン (作業ツリー or 履歴) |
| `.claude/skills/security/iac/SKILL.md` | checkov / tfsec / kube-linter で IaC 設定スキャン |
| `.claude/skills/security/scan-all/SKILL.md` | 4観点の集約スキャン + 統一フォーマット出力 |
| `.github/workflows/security-gate.yml` | CI 上で headless 起動して Critical/High でブロックするゲート |

## 共通設計

- 全 Skill が `disable-model-invocation: true` + `context: fork` + `general-purpose`
- 結果は Critical / High / Medium / Low の4段階で正規化
- `Bash` 全許可は避け、各ツール CLI を allowed-tools に明示列挙

## 呼び出し例

```text
> /security-sast src/
> /security-deps
> /security-secrets --git-history
> /security-iac infra/terraform
> /security-scan-all
```
