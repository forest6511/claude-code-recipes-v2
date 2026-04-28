# レシピ94: Ultraplan + Ultrareview で雲計画・独立レビュー

雲側に計画 (`/ultraplan`) とレビュー (`/ultrareview`) を分離し、ターミナルを実装に専念させる構成のサンプル。

## ファイル一覧

- `.claude/settings.json`: チーム共通の前提設定。`git status` / `git diff` / `gh pr view` の確認系を自動承認に入れて新人の引っかかりを減らす最小例

## 使い方

1. Claude Code v2.1.91+ にアップデート (`claude update`)
2. `/login` で claude.ai アカウント認証 (Ultrareview は API キー単独不可)
3. `/extra-usage` で extra usage を有効化 (Ultrareview の課金前提)
4. 計画フェーズ: `/ultraplan <要件>` で雲セッション起動 → `/tasks` で進捗確認 → ブラウザでレビュー → 実装先選択 (Web / Terminal)
5. 実装フェーズ: ローカルで通常通り編集
6. レビューフェーズ: ブランチで `/ultrareview` (引数なし) または PR 上で `/ultrareview <PR-number>`

詳細は本書のレシピ94を参照。

## 注意

- Bedrock / Vertex / Foundry 経由では使えない (両機能とも Anthropic クラウド前提)
- Ultrareview は ZDR 組織では提供されない
- Remote Control (レシピ93) と Ultraplan は `claude.ai/code` の表示枠を取り合うため排他
