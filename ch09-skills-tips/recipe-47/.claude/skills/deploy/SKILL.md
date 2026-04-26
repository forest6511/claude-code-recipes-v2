---
name: deploy
description: 本番環境へデプロイ。事前にテスト/ビルドを実行し、デプロイ先に push して結果を検証する
disable-model-invocation: true
allowed-tools: Bash(./scripts/deploy.sh *)
---

# Deploy Skill

本番環境へのデプロイを手動 `/deploy` でのみ起動する。Claude が自動起動することはない。

## 手順

1. テストスイートを実行
2. アプリケーションをビルド
3. デプロイ先に push
4. デプロイ後の health check を実施
