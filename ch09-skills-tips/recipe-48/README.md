# Recipe 48: namespace 設計

複数の skill / subagent / plugin を同時に使うときの命名規約と priority 階層のサンプル。

## 構成

```text
recipe-48/
├── my-team-plugin/                          # Plugin (acme-dev-tools)
│   ├── .claude-plugin/
│   │   └── plugin.json                      # name: acme-dev-tools (namespace prefix)
│   ├── skills/
│   │   ├── review-code/SKILL.md             # /acme-dev-tools:review-code
│   │   ├── deploy/SKILL.md                  # /acme-dev-tools:deploy
│   │   └── test-runner/SKILL.md             # /acme-dev-tools:test-runner
│   ├── hooks/hooks.json
│   └── scripts/lint-check.sh
└── README.md
```

## ポイント

- `plugin.json` の `name` (`acme-dev-tools`) がそのまま skill の namespace prefix になる
- 同名 skill が project `.claude/skills/review-code/` にあっても、プラグインは別 namespace なので衝突しない
- Personal `~/.claude/skills/` の同名 skill は project より優先される (priority 階層)
- 組織 prefix (`acme-`) を全 plugin に適用すると、社内 skill が `/acme-*` で揃う
