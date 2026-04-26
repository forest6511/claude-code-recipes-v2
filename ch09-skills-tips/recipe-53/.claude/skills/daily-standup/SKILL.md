---
name: daily-standup
description: 毎日の進捗報告を生成する。リポジトリの変更履歴と Issue から自動でまとめる
when_to_use: 朝会、デイリースタンドアップ、進捗共有
effort: low
allowed-tools: Read Bash(git log:*) Bash(gh issue list:*)
---

# Daily Standup

進捗報告のためのテンプレート skill。`effort: low` で軽く動かす想定。session の model 設定を継承する (frontmatter に `model` を書いていないため、Opus / Sonnet どちらでも動く)。

## 手順

1. `git log --since='24 hours ago' --oneline` で 直近のコミットを取得
2. `gh issue list --assignee @me --state open` で未完了タスクを取得
3. 「昨日やったこと / 今日やること / ブロッカー」の 3 カテゴリで報告

## 注意

- Haiku 4.5 で動かすと `effort: low` は無視される (Haiku は effort 非対応)
- そのため Sonnet 以上を session の model に設定して使う運用が望ましい
