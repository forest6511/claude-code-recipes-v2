# Claude Code 実践レシピ100本 — v5 サンプルコードリポジトリ

[書籍名] **Claude Code 実践レシピ100本 〜MCP / Skills / Hooks / サブエージェント実践ガイド〜**

本リポジトリは、書籍『Claude Code 実践レシピ100本』の **第2版（v5）** に対応するサンプルコード集です。

## リポジトリの位置づけ

- **v2 (このリポ)** — 第2版（v5）向け。MCP / Skills / Hooks / サブエージェント / Agent Teams / Channels / Computer Use / Routines など最新機能を反映した100レシピ
- **v1** — [forest6511/claude-code-recipes](https://github.com/forest6511/claude-code-recipes) — 初版（v4）向け。2026-02 出版時点のサンプルコード

初版書籍をお持ちの読者は **v1 リポ**、第2版の読者は本リポ（v2）を参照してください。

## ディレクトリ構成

v5 全16章 + 付録A / C のサンプルコードを章ごとに格納しています。各レシピは `recipe-NN/` サブディレクトリに配置されます。

### 第1部 基盤編
- [`ch01-claude-md/`](./ch01-claude-md/) — CLAUDE.md & 設定最適化（レシピ01-06）
- [`ch02-context-cost/`](./ch02-context-cost/) — コンテキスト管理 & コスト最適化（レシピ07-13）

### 第2部 MCP実践レシピ
- [`ch03-github-search/`](./ch03-github-search/) — GitHub & Web検索連携（レシピ14-18）
- [`ch04-playwright/`](./ch04-playwright/) — ブラウザ自動化 — Playwright MCP（レシピ19-22）
- [`ch05-database/`](./ch05-database/) — DB & 外部サービス連携（レシピ23-28）
- [`ch06-mcp-development/`](./ch06-mcp-development/) — カスタムMCP開発（レシピ29-34）

### 第3部 Skills実践レシピ
- [`ch07-skills-basics/`](./ch07-skills-basics/) — Skills設計と基本（レシピ35-39）
- [`ch08-skills-templates/`](./ch08-skills-templates/) — 実践Skillsテンプレート集（レシピ40-46）
- [`ch09-skills-tips/`](./ch09-skills-tips/) — Skills TIPS & 上級テクニック（レシピ47-54）

### 第4部 サブエージェント実践レシピ
- [`ch10-subagents-basics/`](./ch10-subagents-basics/) — サブエージェントの基礎と設計（レシピ55-59）
- [`ch11-subagent-dev/`](./ch11-subagent-dev/) — サブエージェント駆動開発（レシピ60-64）
- [`ch12-agent-teams/`](./ch12-agent-teams/) — Agent Teams & 設計パターン（レシピ65-75）

### 第5部 Hooks実践レシピ
- [`ch13-hooks-basics/`](./ch13-hooks-basics/) — Hooksの仕組みと基礎（レシピ76-80）
- [`ch14-hooks-recipes/`](./ch14-hooks-recipes/) — Hooks活用（レシピ81-88）

### 第6部 統合ワークフロー & マルチデバイス
- [`ch15-workflows/`](./ch15-workflows/) — 統合ワークフロー & 高度な運用（レシピ89-95）
- [`ch16-multi-device/`](./ch16-multi-device/) — マルチデバイス運用とクラウド自動化（レシピ96-100）

### 付録
- [`appendix-a-mcp-reference/`](./appendix-a-mcp-reference/) — MCPサーバーリファレンス
- [`appendix-c-troubleshooting/`](./appendix-c-troubleshooting/) — トラブルシューティング辞典

## v4 → v5 の主な変更点

v4（初版、2026-02）から v5（第2版、2026 年内出版予定）への刷新内容:

- **REWRITE 8本** — モデル選択戦略 / Progressive Disclosure / Context engineering / native isolation: worktree / 70/20/10 Advisor / 20+ Hook イベント / Remote Control 統合
- **NEW 11本** — Fast Mode / Zen MCP / Plugin Marketplace 配布 / Agent Teams evals・observability / Monitor + /loop / Ultraplan + Ultrareview / Harness Engineering / Channels × 2 / Computer Use × 2 / Routines
- **DROP 2本** — Claude Code as MCP server、`!command` 単独レシピ（Hooks UserPromptSubmit に統合）

## 使い方

各章ディレクトリ内の `recipe-NN/` を参照してください。書籍本文のキャプション（例: `ファイル: ch07-skills-basics/recipe-37/SKILL.md`）が本リポの実ファイルを指しています。

書籍本文と本リポのコードは、機械的な整合検証（行単位 diff + 識別子実在チェック）を通過したものだけを公開しています。

## ライセンス

MIT License — 詳細は [LICENSE](./LICENSE) を参照してください。

## 関連リンク

- [v1 サンプルコード（初版）](https://github.com/forest6511/claude-code-recipes)
- [Amazon Kindle 初版](https://www.amazon.co.jp/dp/B0GMQ18MFR) — 第2版リンクは出版後に追記

---

**Status**: v2 は 2026-04-24 時点でディレクトリ骨格のみ。v4 既存 KEEP レシピの移行と v5 新規レシピの追加は段階的に進行します。
