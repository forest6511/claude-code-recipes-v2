---
name: release-prep
description: バージョンバンプと CHANGELOG エントリを生成する
disable-model-invocation: true
context: fork
agent: Explore
argument-hint: [version]
allowed-tools: Read Edit Bash(git log *) Bash(git tag *)
---

リリースバージョン: $version

## タスク
1. 直近タグから HEAD までのコミットを `git log <last-tag>..HEAD --oneline` で取得
2. Conventional Commits の type ごとに分類 (feat/fix/refactor/docs/chore)
3. CHANGELOG.md に以下の形式で追記:

   ## [v$version] - YYYY-MM-DD

   ### Added
   ### Changed
   ### Fixed
   ### Documentation

4. `package.json` / `pyproject.toml` / `go.mod` のバージョン文字列を更新
5. 変更したファイル一覧をユーザーに報告
6. `git tag` 実行はユーザーに任せる
