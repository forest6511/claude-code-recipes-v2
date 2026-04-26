# レシピ42: リファクタリングSkills

「振る舞いを変えない」を前提に、6種類のリファクタパターンに限定した Skill。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/refactor/SKILL.md` | ファイル/関数単位の inline リファクタ |
| `.claude/skills/refactor-bulk/SKILL.md` | ディレクトリ全体のパターン適用型リファクタ (`context: fork`) |

## 適用パターン

1. 関数の抽出
2. 変数の改名
3. 重複の除去
4. 条件式の簡略化
5. マジックナンバー定数化
6. デッドコード削除

## 呼び出し例

```text
> /refactor src/auth/session.ts
> /refactor-bulk src/users "マジックナンバー定数化"
```
