# CLAUDE.md

## プロジェクト概要
このリポジトリは、スマートフォンからClaude Code Actionsを使って自動開発を行うためのテンプレートリポジトリです。
Spec Kit + TDD統合開発フローを採用し、Issue Drivenで品質の高いソフトウェア開発を実現します。

### 主要な特徴
- **スマホ対応開発環境**: モバイルデバイスから本格的な開発作業が可能
- **複数のワークフロー**: 用途別に最適化された6つのGitHub Actionsワークフロー
- **自動化された品質管理**: コードレビュー、テスト、ドキュメント生成の自動化
- **専門エージェント活用**: 分野特化型AIエージェントによる高品質な開発支援

## 開発ルール・原則

### 基本原則
- **共通ルール**: 変数命名、コードスタイル、コメントの書き方はプロジェクト内で統一
- **Spec Kit + TDD統合開発**: 仕様駆動開発とテスト駆動開発を組み合わせた開発フロー
- **Issue Driven 開発**: すべての開発はIssueから開始し、Issueに紐づけて進行
- **MCPツールの使用必須**: 開発作業は基本的にMCPのツールを使用
- **Formatter/Linter実行**: コード整形や静的解析はClaude CodeのHooksから自動実行
- **プロジェクト憲法遵守**: 開発原則の一貫した適用と品質ゲートの確実な実行

### Spec Kit + TDD 統合開発フロー
1. **仕様作成** (`/spec-kit:specify`) - 自然言語から正式仕様を作成
2. **計画立案** (`/spec-kit:plan`) - 技術選定と実装計画
3. **タスク生成** (`/spec-kit:tasks`) - TDD準拠のタスクリスト作成
4. **TDD実装** (`/spec-kit:implement`) - Red-Green-Refactorサイクル
5. **品質確認** (`/development:code-review`, `/spec-kit:constitution`) - 品質とプロジェクト憲法への準拠確認

## プロジェクト構成

### ディレクトリ構造
```
├── .claude/                    # Claude Code設定
│   ├── commands/              # カスタムスラッシュコマンド定義
│   ├── agents/                # 専門サブエージェント定義
│   ├── hooks/                 # コード検証・整形スクリプト
│   └── settings.json          # Claude Code設定
├── .github/workflows/         # GitHub Actions（6つのワークフロー）
│   ├── claude.yml             # 基本ワークフロー
│   ├── claude-project.yml     # プロジェクト管理
│   ├── claude-spec.yml        # 仕様策定
│   ├── claude-code-review.yml # コードレビュー
│   ├── claude-docs.yml        # ドキュメント生成
│   └── claude-project-management.yml # 高度なプロジェクト管理
├── .specify/                  # Spec Kit設定・テンプレート・実行スクリプト
├── docs/                      # プロジェクトドキュメント
├── .mcp.json                  # MCP設定
├── CLAUDE.md                  # このファイル
└── README.md                  # プロジェクト概要
```

### ドキュメント
- `docs/COMMANDS.md` : スラッシュコマンド詳細ガイド
- `docs/AGENTS.md` : サブエージェント詳細ガイド
- `docs/SPEC_KIT_TDD_WORKFLOW.md` : Spec Kit + TDD統合ワークフロー
- `docs/GITHUB_ACTIONS_SETUP.md` : GitHub Actions設定ガイド
- `docs/prompt.md` : カスタムプロンプト定義

## GitHub Actionsワークフロー

### ワークフロー一覧とトリガー条件

#### 1. claude.yml - 基本ワークフロー
**トリガー**: `@claude` を含むコメント・Issue・PR
**用途**: 一般的な開発作業、コード修正、機能実装
**実行コンテキスト**: 汎用的な開発タスク全般

#### 2. claude-project.yml - プロジェクト初期セットアップ
**トリガー**: `@claude setup` を含むコメント・Issue・PR
**用途**: プロジェクトの初期セットアップ、環境構築
**実行コンテキスト**: 新規プロジェクト作成、開発環境の初期化

#### 3. claude-spec.yml - 仕様策定・計画
**トリガー**: `@claude plan` を含むコメント・Issue・PR
**用途**: 仕様作成、実装計画、アーキテクチャ設計
**利用可能コマンド**: Spec Kit統合コマンド群

#### 4. claude-code-review.yml - コードレビュー
**トリガー**: `@claude review` を含むコメント・Issue・PR
**用途**: 自動コードレビュー、品質分析
**実行コンテキスト**: コード品質の向上、ベストプラクティスの適用

#### 5. claude-docs.yml - ドキュメント生成
**トリガー**: `@claude docs` を含むコメント・Issue・PR
**用途**: API ドキュメント、README、技術文書の生成・更新
**実行コンテキスト**: ドキュメンテーション作業

#### 6. claude-project-management.yml - 高度なプロジェクト管理
**トリガー**: `@claude manage` を含むコメント・Issue・PR
**用途**: プロジェクト管理、タスク調整、進捗管理
**実行コンテキスト**: 大規模プロジェクトの管理・調整

### 設定要件
#### 必要なSecrets
- `CLAUDE_CODE_OAUTH_TOKEN`: Claude Code認証トークン
- `ANTHROPIC_API_KEY`: Anthropic API キー
- `GITHUB_TOKEN`: GitHub Actions標準トークン（自動設定）

#### 権限設定
- `contents: write` - ファイル読み書き
- `pull-requests: write` - PR操作
- `issues: write` - Issue操作
- `actions: read` - Actions実行状況参照
- `statuses: write` - コミット状態更新
- `repository-projects: write` - プロジェクト操作

## カスタムスラッシュコマンド

### プロジェクト管理
- `/project-management:setup-project` - プロジェクトの初期セットアップ

### Spec Kit統合コマンド（仕様駆動開発）
- `/spec-kit:specify` - 自然言語から正式仕様を作成
- `/spec-kit:plan` - 仕様から具体的な実装計画を生成
- `/spec-kit:clarify` - 仕様の曖昧な点を対話的に明確化
- `/spec-kit:tasks` - 実装計画からTDD準拠のタスクリストを生成
- `/spec-kit:implement` - TDDサイクルに従った機能実装
- `/spec-kit:analyze` - 既存仕様の分析と評価
- `/spec-kit:constitution` - プロジェクト憲法の作成・更新

### 開発支援
- `/development:code-review` - コード品質分析とレビュー
- `/development:debug-help` - デバッグ支援とエラー分析
- `/development:refactor` - コードリファクタリングと改善
- `/testing:test-gen` - テストコード生成
- `/documentation:docs-gen` - ドキュメント生成

## 専門サブエージェント

### 言語・技術特化エージェント
- **rust-expert**: Rust開発専門家
  - 所有権システム、ライフタイム管理、パフォーマンス最適化
- **web-developer**: Web開発専門家
  - フロントエンド技術、レスポンシブデザイン、ウェブアクセシビリティ
- **mobile-developer**: モバイルアプリ開発専門家
  - iOS/Android ネイティブ開発、クロスプラットフォーム開発

### 専門分野特化エージェント
- **devops-engineer**: DevOpsとインフラ専門家
  - CI/CD、コンテナ技術、クラウドインフラ、監視・ログ管理
- **data-scientist**: データサイエンスと機械学習専門家
  - データ分析、機械学習モデル、統計処理、可視化
- **security-expert**: セキュリティと脆弱性専門家
  - 脆弱性診断、セキュリティ監査、暗号化、認証システム

## 実行方法と使用例

### ワークフロー起動方法

#### 基本的な開発作業
```markdown
# Issue または PR コメントで
@claude ログイン機能を実装してください
@claude /development:code-review src/auth.rs
@claude rust-expert: 所有権エラーを修正してください
```

#### プロジェクト初期セットアップ
```markdown
# Issue または PR コメントで
@claude setup 新しいRustプロジェクトをセットアップしてください
@claude setup Web開発環境を構築してください
```

#### 仕様策定・計画作業
```markdown
# Issue または PR コメントで
@claude plan ユーザー管理システムの仕様を作成してください
@claude plan APIの設計を検討してください
```

#### コードレビュー
```markdown
# Issue または PR コメントで
@claude review このPRのコードをレビューしてください
@claude review --focus security セキュリティ観点でレビューしてください
```

#### ドキュメント生成
```markdown
# Issue または PR コメントで
@claude docs APIドキュメントを生成してください
@claude docs README.mdを更新してください
```

#### プロジェクト管理
```markdown
# Issue または PR コメントで
@claude manage プロジェクトの進捗を管理してください
@claude manage タスクの優先度を調整してください
```

### スラッシュコマンド詳細使用方法

#### プロジェクト管理
```markdown
@claude /project-management:setup-project
# プロジェクトの初期セットアップを自動実行
```

#### Spec Kit統合コマンド
```markdown
@claude /spec-kit:specify "ユーザー認証システム"
# 自然言語から正式仕様を作成

@claude /spec-kit:plan
# 仕様から実装計画を生成

@claude /spec-kit:tasks
# TDD準拠のタスクリストを生成

@claude /spec-kit:implement
# TDDサイクルで実装を進行
```

#### 開発支援コマンド
```markdown
@claude /development:code-review src/main.rs
# 指定ファイルのコードレビュー

@claude /development:debug-help "認証エラーが発生"
# デバッグ支援

@claude /development:refactor --target src/auth/
# リファクタリング実行

@claude /testing:test-gen --unit --integration
# テストコード生成

@claude /documentation:docs-gen --api
# APIドキュメント生成
```

## テスト・検証・運用

### 動作確認方法
1. **Issue作成**: 新しいIssueを作成し、`@claude [指示]` でコメント
2. **PR作成**: Pull Requestを作成し、`@claude [指示]` でコメント
3. **実行確認**: GitHub Actions タブで実行状況を確認
4. **結果確認**: スティッキーコメントで最終結果を確認

### ログ確認方法
1. GitHub リポジトリの **Actions** タブを開く
2. 該当のワークフロー実行を選択
3. **claude**, **claude-project**, **claude-spec** などのジョブを選択
4. ステップごとの詳細ログを確認

### トラブルシューティング
- **ワークフローが起動しない**: `@claude` キーワードの確認、Actionsの有効化、Secrets設定
- **権限エラー**: GitHub Token権限設定、リポジトリ権限設定の確認
- **コマンドが動作しない**: `.claude/commands/` ファイル確認、コマンド名の確認

### 品質保証
- **TDD遵守**: テストファーストでの開発
- **自動品質チェック**: Hooks による Formatter/Linter 自動実行
- **プロジェクト憲法準拠**: 開発原則の一貫した適用
- **継続的改善**: フィードバックに基づくCLAUDE.mdの継続的改善