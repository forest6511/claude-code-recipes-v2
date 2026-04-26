---
name: security-iac
description: Terraform / CloudFormation / Kubernetes manifest の不適切設定を検出する
disable-model-invocation: true
context: fork
agent: general-purpose
allowed-tools: Read Glob Bash(checkov *) Bash(tfsec *) Bash(kube-linter *)
argument-hint: [対象ディレクトリ]
---

対象: $ARGUMENTS（未指定の場合は `infra/`）

## タスク
1. ファイル種別を Glob で判定:
   - `*.tf` → Terraform → `tfsec` または `checkov -d $ARGUMENTS --framework terraform`
   - `*.yaml` (Kubernetes manifest) → `kube-linter lint $ARGUMENTS`
   - `template.yaml` (CloudFormation) → `checkov -d $ARGUMENTS --framework cloudformation`
2. 各ツールの結果を CIS Benchmark 区分にマッピング
3. ファイルパス → ルール ID → 推奨修正 → CIS カテゴリで出力
