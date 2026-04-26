# Recipe 53: モデル別動作差異 + Haiku 4.5 + effort

skill frontmatter で `model:` と `effort:` を指定することで、セッションの設定とは独立に skill ごとの実行環境を制御するサンプル。

## 構成

```text
recipe-53/.claude/skills/
├── deep-analysis/SKILL.md    # model: opus-4-7 + effort: xhigh (深い推論)
├── quick-summary/SKILL.md    # model: haiku-4-5 (高速・低コスト、effort 非対応)
└── daily-standup/SKILL.md    # effort: low のみ (model はセッション継承)
```

## ポイント

- `model:` フィールド: skill 実行中のモデルを上書き、ターン終了で元に戻る
- `effort:` フィールド: low / medium / high / xhigh / max (Opus 4.7 のみ全サポート)
- Haiku 4.5 は effort を**サポートしない** (frontmatter で書いても無視)
- xhigh は Opus 4.7 専用、Opus 4.6 / Sonnet 4.6 では high にフォールバック
- 優先順位: 環境変数 > frontmatter > 設定ファイル > model default
- skill / subagent frontmatter の effort はその skill / subagent が active な間だけ適用
