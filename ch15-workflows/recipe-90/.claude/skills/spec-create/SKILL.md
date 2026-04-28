---
name: spec-create
description: 新機能の SPEC.md を AskUserQuestion 経由のインタビューで作成する。$ARGUMENTS は機能の概要文
disable-model-invocation: true
allowed-tools: AskUserQuestion Read Write Glob Grep
---
# Spec の作成

$ARGUMENTS で渡された概要をもとに、`AskUserQuestion` ツールで詳細をインタビューしてから `specs/{slug}.md` を生成する。

進め方:

1. 既存実装の調査: 関連しそうな領域を Glob/Grep で確認し、既存パターンに合わせる前提を作る
2. インタビュー: `AskUserQuestion` で技術選定・UI/UX・エッジケース・非機能要件を聞く。明らかな質問は飛ばし、分岐が大きい論点に絞る
3. 保存: `templates/spec.md` の構成で `specs/{kebab-slug}.md` に書き出す
4. 要約: 出力ファイルパスと、未確定で残った論点を 5 行以内で報告する
