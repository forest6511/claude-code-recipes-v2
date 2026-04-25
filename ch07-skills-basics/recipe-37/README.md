# レシピ37: $ARGUMENTSで動的パラメータを受け取る

`$ARGUMENTS` 系の引数展開と `` !`command` `` の前処理を組み合わせて、動的に動作する Skill を作るためのサンプル。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/fix-issue/SKILL.md` | `$ARGUMENTS` で Issue 番号を受け取る最小例 |
| `.claude/skills/migrate-component/SKILL.md` | `$0` `$1` `$2` の位置引数でフレームワーク移行を指示 |
| `.claude/skills/migrate-component-named/SKILL.md` | `arguments` フィールドで名前付き引数 (`$component` 等) を宣言 |
| `.claude/skills/pr-summary/SKILL.md` | `` !`gh pr diff` `` でPR差分を Skill 読み込み時に注入 |
| `.claude/skills/release-notes/SKILL.md` | `arguments` と `` !`command` `` を組み合わせた実践例 |

## 呼び出し例

```text
> /fix-issue 123
> /migrate-component SearchBar React Vue
> /migrate-component-named SearchBar React Vue
> /pr-summary
> /release-notes 1.2.0
```

## 置換タイミング

| 記法 | タイミング | 用途 |
|------|----------|------|
| `` !`command` `` / ` ```! ` ブロック | Skill 読み込み時（前処理） | コマンド出力を本文に焼き込む |
| `$ARGUMENTS` / `$0` / `$name` / `${CLAUDE_SESSION_ID}` / `${CLAUDE_SKILL_DIR}` | Skill 実行時 | 引数とセッション変数の埋め込み |
