# レシピ41: テスト駆動開発（TDD）Skills

Red-Green-Refactor サイクルを Skill 本体で固定し、フェーズ境界でユーザー確認を挟む TDD ワークフロー。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/skills/tdd/SKILL.md` | 汎用 TDD サイクル (npm test / pytest / go test 対応) |
| `.claude/skills/tdd-typescript/SKILL.md` | TypeScript / Vitest 特化版 (型チェック込み) |

## 共通設計

- `disable-model-invocation: true` で誤発火を防ぐ（ユーザーが `/tdd` で明示起動）
- `allowed-tools` はテストランナーのサブコマンド限定 (`Bash(npm test:*)` 等)
- Phase 1 / 2 / 3 の終了条件をテスト状態で機械的に管理

## 呼び出し例

```text
> /tdd ユーザー登録時のメール検証
> /tdd-typescript パスワードハッシュ化ユーティリティ
```
