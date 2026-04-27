# レシピ61: 大規模リファクタリング + レガシーコード分析

数十ファイルにまたがる大規模リファクタリングを、レガシーコードの隠れた前提を発掘した上で安全に進めるための 4 フェーズパイプライン。

## ファイル一覧

| ファイル | 説明 |
|---------|------|
| `.claude/agents/legacy-analyzer.md` | フェーズ 1 用の読み取り専用分析エージェント（plan モード強制） |
| `.claude/agents/refactor-implementer.md` | フェーズ 3 用の実装エージェント（worktree 隔離） |
| `prompts/phase2-plan.txt` | 計画フェーズのプロンプト例 |
| `prompts/phase4-verify.txt` | 検証フェーズのプロンプト例 |

## 4 フェーズ・パイプライン

```
[Phase 1] legacy-analyzer (plan mode, Haiku, read-only)
   ↓ findings.md
[Phase 2] メイン会話を plan モードへ → 段階分割計画
   ↓ ステップ仕様
[Phase 3] refactor-implementer ×N (isolation: worktree, Sonnet)
   ↓ worktree-step-1, worktree-step-2, ...
[Phase 4] メイン会話で順次マージ + 全体テスト
```

## 使い方

```bash
# エージェント定義を対象プロジェクトに配置
cp -r .claude /path/to/your-project/

# Phase 1: 既存コードの分析
> src/auth モジュールの現状を legacy-analyzer で調査してください

# Phase 2: 計画立案（プランモードで起動）
claude --permission-mode plan
> [phase2-plan.txt の内容を貼り付け]

# Phase 3: 各ステップを worktree 隔離下で実装
> 計画のステップ 1 を refactor-implementer に実装させてください
> ステップ 1 と独立しているステップ 2 を別の worktree で並列実行してください

# Phase 4: 検証と統合
> [phase4-verify.txt の内容を貼り付け]
```

## 設計のポイント

- **役割分離**: 分析者と実装者を別エージェントにする。同一エージェントだと編集の誘惑で分析が歪む
- **plan モード強制**: `permissionMode: plan` で書き込み系を物理的に発動させない
- **worktree 隔離**: `isolation: worktree` で複数ステップを並列化し、失敗を低コストで巻き戻す
- **計画フェーズで並列性を作り込む**: 同じファイルを触る 2 ステップを並列化するとマージで必ず衝突する
- **caracterization test 追加フェーズの挿入**: 回帰テストが薄い領域はリファクタ前にテスト追加ステップを入れる

## 関連レシピ

- レシピ60「並列実行で大規模コードベースを高速調査」
- レシピ56「エージェント種別の使い分け」
- レシピ59「Context engineering」
- レシピ64「サブエージェント駆動のコードレビュー」
- レシピ68「native isolation: worktree でブランチ分離」
