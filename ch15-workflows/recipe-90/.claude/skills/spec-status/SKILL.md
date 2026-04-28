---
name: spec-status
description: specs/ 配下の全 SPEC について受け入れ基準のチェック状況を集計する
disable-model-invocation: true
allowed-tools: Read Glob Grep Bash(grep *) Bash(wc *)
---
# Spec status

specs/*.md を読み、以下の集計を返す。

1. 各ファイルの受け入れ基準を [x] / [ ] でカウント
2. 完了率 (= [x] / 合計) を百分率で並べる
3. 「未確定の論点」セクションが残っているファイルを警告として列挙
4. SPEC が無いのに実装が進んでいる領域を Grep で検出（オプション）

出力は 2 列のテーブル (Spec ファイル名 / 完了率) と、警告の箇条書きを返す。
