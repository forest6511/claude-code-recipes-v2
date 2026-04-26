# Recipe 52: フロントマター Hooks で Skills ライフサイクル

SKILL.md frontmatter の `hooks:` フィールドで、その skill が active な間だけ発動するスコープ付き hook を定義するサンプル。

## 構成

```text
recipe-52/
└── .claude/
    └── skills/
        ├── implement-feature/SKILL.md   # PostToolUse: ファイル変更後に自動テスト
        ├── daily-report/SKILL.md        # PreToolUse + once: 初回のみセキュリティスキャン
        └── monitored-deploy/SKILL.md    # PreToolUse + PostToolUse + Stop: デプロイ全工程の監査
```

## ポイント

- スキル有効中のみ hooks が発動し、終了時に自動クリーンアップ
- 全イベント (PreToolUse / PostToolUse / Stop / SessionEnd 等) に対応
- `async: true`: バックグラウンド実行で skill 本体をブロックしない (公式 hooks.md L2402)
- `once: true`: skill frontmatter 限定で有効、1 回実行後に削除 (公式 hooks.md "Only honored for hooks declared in skill frontmatter")
- subagent では `Stop` が自動で `SubagentStop` に変換される
