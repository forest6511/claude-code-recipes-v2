---
name: work-issue
description: GitHub Issue 番号 $ARGUMENTS を起点に、ブランチ作成・実装・PR 作成まで通す
disable-model-invocation: true
allowed-tools: Bash(gh issue view *) Bash(gh pr create *) Bash(git *) Edit Read Glob Grep
---
# Issue 駆動開発

## 手順

1. `gh issue view $ARGUMENTS --json number,title,body,labels` で内容を取得し、ゴール・受け入れ基準・関連ファイルの仮説をまとめる
2. ブランチ命名: `feature/issue-$ARGUMENTS-{kebab-summary}` または `fix/issue-$ARGUMENTS-{kebab-summary}`
3. `git checkout -b ...` でブランチ作成
4. 実装: 既存パターンを Glob/Grep で確認した上で最小差分で着手。コミットメッセージに `#$ARGUMENTS` を含める
5. 品質チェック: `/quality-gate` を呼ぶ（レシピ89）。失敗があれば直してから次へ
6. `git push -u origin <branch>` の後、`gh pr create --title "..." --body "$(printf 'Closes #%s\n\n実装の概要\n' "$ARGUMENTS")"` で PR 作成（bash の `"..."` 内では `\n` はリテラル化されるので、`printf` で実改行を作る）
7. PR URL を出力して終わり

## 中断条件

- Issue の本文に「設計を相談したい」「決め打ちで実装しないで」等の指示があれば、Step 4 に進まずユーザー確認を求める
- 影響範囲が複数モジュールに広がる場合は、レシピ90 の `/spec-create` を呼んで SPEC.md を先に作る
