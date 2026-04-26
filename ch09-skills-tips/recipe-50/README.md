# Recipe 50: トークン最小化 + 段階的読み込みアーキテクチャ

Skills が大きな知識ベースを抱えても context を圧迫しない構造の例。SKILL.md は entry point + ナビゲーション、詳細は reference/ や examples/ に分離して on-demand Read する設計。

## 構成

```text
recipe-50/.claude/skills/api-doc-writer/
├── SKILL.md                           # entry point (約 50 行、起動時に必ずロード)
├── reference/
│   ├── openapi-3.1-cheatsheet.md      # 詳細仕様 (Claude が必要と判断したときだけ Read)
│   ├── security-schemes.md
│   └── error-responses.md
├── examples/
│   ├── crud-endpoints.md
│   └── paginated-list.md
└── scripts/
    └── validate-openapi.sh            # 実行のみ、context にロードされない
```

## 設計のポイント

- SKILL.md は 500 行以下、起動時に context 投入されるため最小限
- description は「何を / いつ」を front-load (1536 文字キャップ内)
- when_to_use で追加のトリガー語を補足
- 詳細・例・スクリプトはすべて分離。SKILL.md からリンクで明示
- `${CLAUDE_SKILL_DIR}` を使ってスクリプトを呼ぶ (current working directory に依存しない)
