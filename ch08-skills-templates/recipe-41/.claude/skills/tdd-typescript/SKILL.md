---
name: tdd-typescript
description: TypeScript プロジェクトでの TDD サイクル
disable-model-invocation: true
argument-hint: [機能の説明]
allowed-tools: Read Edit Write Grep Glob Bash(npm test *) Bash(npx vitest *) Bash(npx tsc *)
---

実装したい機能: $ARGUMENTS

TDD サイクルに従い、TypeScript / Vitest 前提で進めます。

## Phase 1: Red
- `*.test.ts` をテスト対象と同じディレクトリに作成
- `describe` ブロックで仕様を、`it` で個別ケースを記述
- `npx vitest run <test-file>` で対象テストだけ実行し、失敗メッセージを確認

## Phase 2: Green
- 対象テストを通す最小実装のみ書く
- `npx tsc --noEmit` で型エラーがないことを確認
- `npx vitest run` で全テストが通ることを確認

## Phase 3: Refactor
- 共通化できる箇所をユーティリティ関数に抽出
- `any` を排除、`unknown` から型ガードで絞る
- リファクタ後に `npx vitest run` を再実行し Green 維持
