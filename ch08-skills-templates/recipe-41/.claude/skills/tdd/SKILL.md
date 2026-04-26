---
name: tdd
description: テスト駆動開発のRed-Green-Refactorサイクルで実装を進める
disable-model-invocation: true
argument-hint: [機能の説明]
allowed-tools: Read Edit Write Grep Glob Bash(npm test *) Bash(pytest *) Bash(go test *)
---

実装したい機能: $ARGUMENTS

TDD のサイクルに従い、各フェーズでユーザーの確認を待って次へ進みます。

## Phase 1: Red — 失敗するテストを書く
1. 機能の最小単位を1つ選び、それに対するテストを書く
2. テストを実行し、期待通りに失敗することを確認する (`npm test` / `pytest` / `go test`)
3. 失敗メッセージと、次に Green で実装すべき最小スコープをユーザーに報告

## Phase 2: Green — テストを通す最小実装
1. Phase 1 のテストを通すための最小限のコードだけ書く
2. テストを実行し、対象テストが通ることを確認する
3. 既存テストが壊れていないことも合わせて確認
4. 結果をユーザーに報告

## Phase 3: Refactor — 重複の除去と命名の調整
1. Phase 2 で書いたコードと既存コードの間に重複がないか調査
2. 命名・関数長・責務分離を見直す
3. 各リファクタ後にテストを実行し、Green を維持
4. 完了をユーザーに報告し、次の機能単位に進むか確認

## 守るべきルール
- フェーズの順序は厳守。Green の前に余計な実装を進めない
- 各フェーズの最後に必ずテストを実行し、状態を報告する
- ユーザーから「次へ」と指示がない限り次のフェーズに進まない
