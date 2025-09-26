# CLAUDE.md

## プロジェクト概要
- このリポジトリは、スマホで開発できるテンプレートを提供する。
- READMEやIssueから、どのような機能・アプリを作るかClaude Codeが判断する。

## 開発ルール
- **共通ルール**: 変数命名、コードスタイル、コメントの書き方はプロジェクト内で統一する。
- **Spec Kit + TDD統合開発**: 仕様駆動開発とテスト駆動開発を組み合わせた開発フローを採用する。
- **Issue Driven 開発**: すべての開発はIssueから開始し、Issueに紐づけて進める。
- **MCPツールの使用必須**: 開発作業は基本的にMCPのツールを使用する。
- **Formatter/Linter実行**: コード整形や静的解析はClaude CodeのHooksから自動実行すること。
- **プロジェクト憲法遵守**: 開発原則の一貫した適用と品質ゲートの確実な実行。
- **CLAUDE.mdの改善**: 開発を始める際には、READMEやIssueを参照して、そのプロジェクト用にCLAUDE.mdを必要に応じて改善する。

### Spec Kit + TDD 開発フロー
1. **仕様作成** (`/specify`) - 自然言語から正式仕様を作成
2. **計画立案** (`/plan`) - 技術選定と実装計画
3. **タスク生成** (`/tasks`) - TDD準拠のタスクリスト作成
4. **TDD実装** (`/implement`) - Red-Green-Refactorサイクル
5. **品質確認** (`/code-review`, `/constitution`) - 品質とプロジェクト憲法への準拠確認

## 構成
- `.github/workflows/claude.yml` : Claude Codeを動作させるワークフロー
- `README.md` : プロジェクト概要と開発ガイド
- `CLAUDE.md` : Claude Codeへの指示
- `.claude/commands/` : カスタムスラッシュコマンド定義
- `.claude/agents/` : 専門サブエージェント定義
- `.claude/hooks/` : コード検証・整形スクリプト
- `.specify/` : Spec Kit設定・テンプレート・実行スクリプト

### ドキュメント
- `docs/COMMANDS.md` : スラッシュコマンド詳細ガイド
- `docs/AGENTS.md` : サブエージェント詳細ガイド
- `docs/SPEC_KIT_TDD_WORKFLOW.md` : Spec Kit + TDD統合ワークフロー
- `docs/GITHUB_ACTIONS_SETUP.md` : GitHub Actions設定ガイド

## 設定・制約
- 依存ライブラリの追加は最小限にとどめる。
- トリガー条件やワークフローの変更も最小限にする。

## カスタムスラッシュコマンド
以下のスラッシュコマンドが利用可能です：

### プロジェクト管理
- `/project-management:setup-project` - プロジェクトの初期セットアップ

### Spec Kit統合コマンド（仕様駆動開発）
- `/spec-kit:specify` - 自然言語から仕様作成
- `/spec-kit:plan` - 仕様から実装計画作成
- `/spec-kit:clarify` - 仕様の対話的明確化
- `/spec-kit:tasks` - TDD準拠のタスクリスト生成
- `/spec-kit:implement` - TDDサイクルでの実装
- `/spec-kit:analyze` - 既存仕様の分析
- `/spec-kit:constitution` - プロジェクト憲法管理

### 開発支援
- `/development:code-review` - コード品質分析とレビュー
- `/development:debug-help` - デバッグ支援とエラー分析
- `/development:refactor` - コードリファクタリングと改善
- `/development:test-gen` - テストコード生成
- `/documentation:docs-gen` - ドキュメント生成

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
@claude /project-management:setup-project
@claude /development:code-review src/main.rs
@claude /development:test-gen --unit --integration
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