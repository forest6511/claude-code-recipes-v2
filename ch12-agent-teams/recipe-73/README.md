# レシピ73: Votingパターン（合意形成）

独立した複数エージェントに同じ問題を解かせ、結果の一致度から信頼性を測る合意形成パターンです。多数決・全会一致・重み付け投票を使い分け、合意不成立時のエスカレートまで含めて設計します。

## ファイル一覧

- `prompts/parallel-vote.txt` — サブエージェント 3 件並列の独立投票
- `prompts/adversarial-debate.txt` — Agent Teams 5 仮説の敵対的議論
- `prompts/vote-output-schema.txt` — 投票結果の JSON スキーマ
- `prompts/voting-strategy.txt` — 多数決 / 全会一致 / 重み付けの戦略選択
- `prompts/escalation-rule.txt` — 合意不成立時のエスカレート規則
- `.claude/hooks/log-vote.sh` — `SubagentStop` で各投票を JSON Lines にログ
- `.claude/settings.json` — `SubagentStop` Hook 登録

## 投票方式

- **多数決**: 3 件中 2 件以上の同意で採用
- **全会一致**: 全件同意で採用、それ以外はエスカレート
- **重み付け**: confidence × 票で順位付け

## 適用領域

- バグ調査 (複数仮説からの根本原因特定)
- コードレビュー (severity 判定の偽陽性削減)
- 設計判断のクロスチェック (高リスク決定前)

## 不向きな問題

- 価値判断 (アーキテクチャ選択など正解がない問題)
- カテゴリ事前定義が困難な自由記述問題

## 関連レシピ

- レシピ60「並列実行で大規模コードベースを高速調査」
- レシピ65「Agent Teams基礎」
- レシピ72「Map-Reduceパターン（分散実行と統合）」
- レシピ75「Agent Teams の evals / observability を計測する」
