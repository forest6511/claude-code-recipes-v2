# Recipe 51: Skills のサイレント失敗と対処

Skill が起動しない、起動しても効果が出ない、ログにエラーが出ない、というサイレント失敗のデバッグ手順とよくある失敗パターンのサンプル。

## 構成

```text
recipe-51/
├── .claude/
│   └── skills/
│       └── debug-skills/SKILL.md       # サイレント失敗の体系的デバッグ手順
├── common-mistakes/
│   ├── before/SKILL.md                 # 失敗パターンの実例 (YAML構文エラー、name制約違反、context:fork 誤用、!`command` フォールバック欠落)
│   └── after/SKILL.md                  # 修正例
└── README.md
```

## チェック観点

1. ディレクトリ構造: `.claude/skills/<name>.md` ではなく `.claude/skills/<name>/SKILL.md`
2. `/skills` コマンドで一覧確認
3. listing budget 不足で description が切られていないか
4. `disable-model-invocation: true` で description が context から除外されていないか
5. `name` の制約: lowercase / 数字 / ハイフンのみ、最大 64 文字
6. YAML フロントマターの構文エラー (コロン値はクォート必須)
7. `context: fork` を使っていて明示的タスクがあるか
8. `` !`command` `` の前処理結果がエラーメッセージのままになっていないか
