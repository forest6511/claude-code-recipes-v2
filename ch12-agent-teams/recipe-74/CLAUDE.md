## サブエージェント振り分けルール

- ログ集計・grep・形式変換は @agent-log-scanner
- API 実装・テスト記述は @agent-api-builder
- 設計判断・プランレビュー・「アプローチをレビューして」は @agent-architecture-advisor

「この変更で問題ないか」「設計の妥当性を見て」は必ず Advisor を呼ぶこと。
Builder で代用しない。
