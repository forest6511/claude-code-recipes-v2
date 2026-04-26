---
name: headless-template
description: CI/cron 向け headless 実行用 Skill のテンプレート
disable-model-invocation: true
context: fork
agent: general-purpose
---

タスク: $ARGUMENTS

## 出力ルール
- 結果は次の JSON 構造でメインに返す:

  {
    "status": "success" | "failure",
    "summary": { "critical": N, "high": N, "medium": N, "low": N },
    "details": [{ "severity": "...", "file": "...", "message": "..." }],
    "next_steps": ["..."]
  }

- 自然言語の説明は `next_steps` 配列内のみに含める
- summary が無い種別の Skill では空オブジェクト `{}` を返す
