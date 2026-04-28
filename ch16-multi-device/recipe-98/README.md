# レシピ98: Computer Use 基礎

組み込み `computer-use` MCP サーバを使い、Claude にネイティブアプリ操作を委ねる構成のサンプル。

## 必要要件

- macOS (CLI 版は macOS 限定。Linux / Windows は Desktop 版を使う)
- Pro または Max プラン (Team / Enterprise は不可)
- Claude Code v2.1.85+
- 対話セッション (`-p` ヘッドレス不可)
- claude.ai アカウント認証 (Bedrock/Vertex/Foundry 単独利用なら別途 claude.ai アカウント必要)

## 有効化手順

1. `claude --version` で v2.1.85+ を確認
2. `/status` で Pro / Max プラン確認
3. `/mcp` で computer-use を Enable に変更（プロジェクトごとに保存される）
4. 初回操作時に macOS 権限プロンプト → Accessibility と Screen Recording を許可
5. Screen Recording 許可後は Claude Code の再起動が必要なことがある

## 操作の流れ

1. ユーザーが GUI 操作を含むタスクを依頼
2. Claude がアプリ単位の承認プロンプトを出す (Allow for this session / Deny)
3. 承認したアプリ群以外は自動で非表示、ターミナルだけ表示維持
4. Claude がスクリーンショットを取り、クリック / 入力 / スクロールで操作
5. ターン終了で他アプリ自動復帰
6. 緊急停止は `Esc` キー (どこからでも有効)、または `Ctrl+C` (ターミナル)

## 警告アプリの一覧

- **Equivalent to shell access**: Terminal / iTerm / VS Code / Warp 等
- **Can read or write any file**: Finder
- **Can change system settings**: System Settings

## 出典

- 公式 docs: https://code.claude.com/docs/en/computer-use
- Safety guide: https://support.claude.com/en/articles/14128542
