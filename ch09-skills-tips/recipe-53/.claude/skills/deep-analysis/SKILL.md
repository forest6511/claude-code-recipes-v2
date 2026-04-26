---
name: deep-analysis
description: 大規模コードベースの設計分析、パフォーマンスボトルネック調査、複雑なリファクタリング計画。深い推論が必要な分析タスクで起動
when_to_use: アーキテクチャ分析、複雑なバグ調査、設計判断
model: claude-opus-4-7
effort: xhigh
allowed-tools: Read Grep Glob Bash
---

# Deep Analysis

最も深い推論が必要なタスク向けの skill。`model: claude-opus-4-7` と `effort: xhigh` を強制することで、セッションが Sonnet/Haiku で動いていても、この skill だけは Opus 4.7 + xhigh effort で実行される。

## 手順

1. 対象を Glob と Grep で網羅的に走査する
2. 設計上の関係性 (依存、結合、責務分離) を抽出する
3. ボトルネック・矛盾・リスクを Critical/High/Medium に分類して報告する

## 注意

- セッションが終わると model / effort 設定は元に戻る
- xhigh は Opus 4.7 限定。Opus 4.6 で使うと自動的に high にフォールバックする
