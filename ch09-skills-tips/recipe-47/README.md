# Recipe 47: Progressive Disclosure + Marketplace discovery

Skills の description が常時 context にロードされる仕組みと、SKILL.md 本体・supporting files の遅延読み込みを組み合わせて、context 圧を skill 数に比例させない設計を示すサンプル。

## 構成

```text
.claude/
├── settings.json                          # Skill permission + char budget
├── settings.json.team-marketplace.example # 共有 marketplace の登録例
└── skills/
    └── code-review/
        ├── SKILL.md       # description + 起動指示 (常時 listing にロード)
        ├── reference.md   # 詳細観点 (必要な時だけ Read)
        └── examples.md    # 出力例 (必要な時だけ Read)
```

## ポイント

- SKILL.md の description は要点のみ、詳細は reference.md / examples.md に分離
- listing budget が context window の 1% で足りない場合 `SLASH_COMMAND_TOOL_CHAR_BUDGET` で拡張
- 副作用ある skill は `disable-model-invocation: true` で listing から外す
