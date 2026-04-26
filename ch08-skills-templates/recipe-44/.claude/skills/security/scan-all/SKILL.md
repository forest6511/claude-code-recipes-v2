---
name: security-scan-all
description: コード/依存/機密情報/IaC の4観点でセキュリティを総合スキャンする
disable-model-invocation: true
context: fork
agent: general-purpose
allowed-tools: Read Grep Glob Bash(semgrep *) Bash(npm audit *) Bash(pip-audit *) Bash(govulncheck *) Bash(cargo audit *) Bash(gitleaks *) Bash(checkov *) Bash(tfsec *) Bash(kube-linter *)
---

リポジトリ全体に対し以下の4スキャンを順次実行し、結果を統合します。

## スキャン項目
1. **SAST (コード)**: Semgrep で OWASP Top 10 マッピング
2. **依存関係**: 言語に応じた audit ツールで CVE 検出
3. **機密情報**: gitleaks で作業ツリーをスキャン (履歴は別途実行)
4. **IaC**: Terraform / Kubernetes manifest があれば checkov / kube-linter

## 出力形式
全スキャン結果を以下の統一フォーマットで集約します。

### 重要度別サマリ
- Critical: 件
- High: 件
- Medium: 件
- Low: 件

### 詳細 (重要度順)
| 重要度 | カテゴリ | ファイル:行 | 問題 | 推奨修正 |
| ... |

### マージブロッカー判定
Critical/High が 0 件なら GO。それ以上なら STOP し、対応必須項目を強調表示。
