# CLAUDE.md

## プロジェクト概要
- このリポジトリは、スマホで開発できるテンプレートを提供する。
- READMEやIssueから、どのような機能・アプリを作るかClaude Codeが判断する。

## 開発ルール
- **共通ルール**: 変数命名、コードスタイル、コメントの書き方はプロジェクト内で統一する。
- **テスト駆動開発（TDD）** を基本とする。
- **Issue Driven 開発**: すべての開発はIssueから開始し、Issueに紐づけて進める。
- **MCPツールの使用必須**: 開発作業は基本的にMCPのツールを使用する。
- **Formatter/Linter実行**: コード整形や静的解析はClaude CodeのHooksから自動実行すること。
- **CLAUDE.mdの改善**: 開発を始める際には、READMEやIssueを参照して、そのプロジェクト用にCLAUDE.mdを必要に応じて改善する。

## 構成
- `.github/workflows/claude.yml` : Claude Codeを動作させるワークフロー
- `README.md` : プロジェクト概要と開発ガイド
- `CLAUDE.md` : Claude Codeへの指示
- `.claude/commands/` : カスタムスラッシュコマンド定義
- `.claude/agents/` : 専門サブエージェント定義
- `.claude/hooks/` : コード検証・整形スクリプト
- `docs/COMMANDS.md` : スラッシュコマンド詳細ガイド
- `docs/AGENTS.md` : サブエージェント詳細ガイド

## 設定・制約
- 依存ライブラリの追加は最小限にとどめる。
- トリガー条件やワークフローの変更も最小限にする。

## カスタムスラッシュコマンド
以下のスラッシュコマンドが利用可能です：
- `/setup-project` - プロジェクトの初期セットアップ
- `/code-review` - コード品質分析とレビュー
- `/debug-help` - デバッグ支援とエラー分析
- `/refactor` - コードリファクタリングと改善
- `/test-gen` - テストコード生成
- `/docs-gen` - ドキュメント生成

## 専門サブエージェント
専門分野に特化したサブエージェントが利用可能です：
- `rust-expert` - Rust開発専門家
- `web-developer` - Web開発専門家
- `mobile-developer` - モバイルアプリ開発専門家
- `devops-engineer` - DevOpsとインフラ専門家
- `data-scientist` - データサイエンスと機械学習専門家
- `security-expert` - セキュリティと脆弱性専門家

## 使用方法
### スラッシュコマンドの使用
```
@claude /setup-project
@claude /code-review src/main.rs
@claude /test-gen --unit --integration
```

### サブエージェントの呼び出し
```
@claude rust-expert: 所有権エラーを修正してください
@claude web-developer: レスポンシブデザインを実装してください
@claude security-expert: 脆弱性を検査してください
```

## テスト・検証
- `@claude` コメント付きIssue/PRで動作確認する。
- 実行結果はGitHub Actionsのログで確認する。
- TDDに従い、まずテストを書いてから機能を実装する。