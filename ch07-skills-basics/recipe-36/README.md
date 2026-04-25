# レシピ36: 初めてのカスタムSkillsを作る

最初の Skill を1本通すためのサンプル。個人スコープとプロジェクトスコープの両方を示す。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/explain-code/SKILL.md` | 個人スコープ向けのコード説明 Skill。description ベースの自動起動を確認するための例 |
| `.claude/skills/pr-checklist/SKILL.md` | プロジェクトスコープ向けの PR 作成前チェックリスト Skill。`disable-model-invocation: true` で手動起動限定 |

## 使い方

```bash
# 個人スコープに置く（全プロジェクトで利用可能）
mkdir -p ~/.claude/skills/explain-code
cp .claude/skills/explain-code/SKILL.md ~/.claude/skills/explain-code/SKILL.md

# プロジェクトスコープに置く（このリポジトリ内のみ）
mkdir -p .claude/skills/pr-checklist
cp .claude/skills/pr-checklist/SKILL.md .claude/skills/pr-checklist/SKILL.md
```

```text
# Claude Code 内で呼び出し
> /explain-code src/auth/login.ts
> /pr-checklist
```

## 設計のポイント

- `explain-code`: `disable-model-invocation` を未設定にし、description マッチによる自動起動を許可
- `pr-checklist`: `disable-model-invocation: true` で手動呼び出し専用にし、誤検知を防止
- 両者とも `name` を frontmatter に明示し、`/`メニューと一覧表示で識別しやすくする
