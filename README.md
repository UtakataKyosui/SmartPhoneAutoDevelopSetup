# SmartPhoneAutoDevelopSetup

スマホでClaude Code Actionsを動かして自動開発するためのテンプレートリポジトリ。
Spec Kit + TDD統合開発フローを採用し、Issue Drivenで品質の高いソフトウェア開発を実現します。

## 🚀 特徴

- **スマホ対応開発環境**: スマートフォンからClaude Code Actionsで開発可能
- **Spec Kit + TDD統合**: 仕様駆動開発とテスト駆動開発を組み合わせた開発フロー
- **Issue Driven開発**: すべての開発はIssueから開始し、体系的に管理
- **自動化されたワークフロー**: GitHub Actionsによる自動レビュー・テスト・デプロイ
- **豊富なスラッシュコマンド**: 開発作業を効率化するカスタムコマンド
- **専門サブエージェント**: 分野特化型AIエージェントによる高品質な開発支援

## 📁 プロジェクト構成

```
├── .claude/                    # Claude Code設定
│   ├── commands/              # カスタムスラッシュコマンド
│   ├── agents/                # 専門サブエージェント
│   └── hooks/                 # コード検証・整形スクリプト
├── .github/workflows/         # GitHub Actions
├── .specify/                  # Spec Kit設定・テンプレート
├── docs/                      # プロジェクトドキュメント
├── CLAUDE.md                  # Claude Codeへの詳細指示
└── README.md                  # このファイル
```

## 🛠️ 開発フロー

### Spec Kit + TDD 統合開発
1. **仕様作成** (`/spec-kit:specify`) - 自然言語から正式仕様を作成
2. **計画立案** (`/spec-kit:plan`) - 技術選定と実装計画
3. **タスク生成** (`/spec-kit:tasks`) - TDD準拠のタスクリスト作成
4. **TDD実装** (`/spec-kit:implement`) - Red-Green-Refactorサイクル
5. **品質確認** (`/development:code-review`, `/spec-kit:constitution`) - 品質とプロジェクト憲法への準拠確認

## 📋 利用可能なスラッシュコマンド

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
- `/testing:test-gen` - テストコード生成
- `/documentation:docs-gen` - ドキュメント生成

## 🤖 専門サブエージェント

以下の分野に特化したAIエージェントが利用可能：

- **rust-expert** - Rust開発専門家
- **web-developer** - Web開発専門家
- **mobile-developer** - モバイルアプリ開発専門家
- **devops-engineer** - DevOpsとインフラ専門家
- **data-scientist** - データサイエンスと機械学習専門家
- **security-expert** - セキュリティと脆弱性専門家

## 🚦 使用方法

### スラッシュコマンドの使用
```
@claude /project-management:setup-project
@claude /development:code-review src/main.rs
@claude /testing:test-gen --unit --integration
```

### サブエージェントの呼び出し
```
@claude rust-expert: 所有権エラーを修正してください
@claude web-developer: レスポンシブデザインを実装してください
@claude security-expert: 脆弱性を検査してください
```

## ⚙️ GitHub Actions

以下のワークフローが自動実行されます：

- **claude.yml** - 基本的なClaude Code実行
- **claude-project.yml** - プロジェクト管理ワークフロー
- **claude-spec.yml** - Spec Kit統合ワークフロー
- **claude-code-review.yml** - 自動コードレビュー
- **claude-docs.yml** - ドキュメント生成
- **claude-project-management.yml** - プロジェクト管理

## 📖 詳細ドキュメント

- [COMMANDS.md](docs/COMMANDS.md) - スラッシュコマンド詳細ガイド
- [AGENTS.md](docs/AGENTS.md) - サブエージェント詳細ガイド
- [SPEC_KIT_TDD_WORKFLOW.md](docs/SPEC_KIT_TDD_WORKFLOW.md) - Spec Kit + TDD統合ワークフロー
- [GITHUB_ACTIONS_SETUP.md](docs/GITHUB_ACTIONS_SETUP.md) - GitHub Actions設定ガイド
- [CLAUDE.md](CLAUDE.md) - Claude Codeへの詳細指示

## 🔧 開発ルール

- **共通ルール**: 変数命名、コードスタイル、コメントの書き方はプロジェクト内で統一
- **Issue Driven 開発**: すべての開発はIssueから開始し、Issueに紐づけて進行
- **MCPツールの使用必須**: 開発作業は基本的にMCPのツールを使用
- **Formatter/Linter実行**: コード整形や静的解析はClaude CodeのHooksから自動実行
- **プロジェクト憲法遵守**: 開発原則の一貫した適用と品質ゲートの確実な実行

## 🧪 テスト・検証

- `@claude` コメント付きIssue/PRで動作確認
- 実行結果はGitHub Actionsのログで確認
- TDDに従い、まずテストを書いてから機能を実装

## 📚 参考リンク

- [Claude Code Actions Usage](https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md)
- [Spec Kit Documentation](.specify/)
- [プロジェクト憲法](.specify/memory/constitution.md)
