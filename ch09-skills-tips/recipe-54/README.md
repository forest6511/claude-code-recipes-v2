# Recipe 54: Plugin Marketplace で自作 Skills を配布

GitHub リポジトリで Plugin Marketplace を運用し、自作 skill をチーム・コミュニティに配布するサンプル。

## 構成

```text
recipe-54/my-marketplace/
├── .claude-plugin/
│   └── marketplace.json                              # marketplace カタログ
└── plugins/
    └── quality-review-plugin/
        ├── .claude-plugin/
        │   └── plugin.json                           # plugin manifest
        └── skills/
            └── quality-review/
                └── SKILL.md                          # 配布する skill 本体
```

## 動作確認手順

```bash
# Claude Code 内で実行
/plugin marketplace add ./my-marketplace
/plugin install quality-review-plugin@acme-tools

# 利用
/quality-review
```

## ポイント

- `marketplace.json` は marketplace のルート `.claude-plugin/` に置く
- `pluginRoot` を指定すると `source` を相対名で書ける (`"plugins/"` 接頭辞を省略可能)
- `version` を `marketplace.json` または `plugin.json` に設定すると、変更時のみアップデートが配信される
- `version` を省略すると git commit SHA が version 扱いとなり、commit ごとに新版扱い
- marketplace の `name` には `claude-code-marketplace` 等の予約名は使えない
