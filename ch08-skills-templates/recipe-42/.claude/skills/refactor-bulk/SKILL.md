---
name: refactor-bulk
description: ディレクトリ全体に対するパターン適用型のリファクタ
context: fork
agent: general-purpose
disable-model-invocation: true
argument-hint: [ディレクトリパス] [パターン名]
allowed-tools: Read Edit Grep Glob Bash(npm test *) Bash(pytest *) Bash(go test *)
---

対象ディレクトリ: $0
適用するリファクタパターン: $1

## タスク
1. ディレクトリ配下の全ファイルから、指定パターン (`$1`) の適用候補を網羅的に列挙
2. 候補を変更が小さいものから大きいものへ並べ、影響範囲を見積もる
3. 1ファイル単位でリファクタを実行し、各ファイル変更後にテストを実行
4. 全候補処理後、変更ファイル一覧と各テスト結果を要約してメインに返す
