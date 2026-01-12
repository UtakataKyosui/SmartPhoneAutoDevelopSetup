# SmartPhoneAutoDevelopSetup

スマホでClaude Code Actionsを動かして自動開発するためのテンプレートリポジトリ。

## 🚀 特徴

- **スマホ対応開発環境**: スマートフォンからClaude Code Actionsで開発可能
- **Issue Driven開発**: すべての開発はIssueから開始し、体系的に管理
- **Agent Skills**: 10個の特化したSkillによる効率的なガイダンス
- **最適化されたMCP**: 必要最小限のMCPサーバで効率的な開発
- **自動化されたワークフロー**: GitHub Actionsによる自動レビュー・テスト・デプロイ
- **豊富なスラッシュコマンド**: 開発作業を効率化するカスタムコマンド
- **専門サブエージェント**: 分野特化型AIエージェントによる高品質な開発支援

## 📁 プロジェクト構成

```
├── .claude/                    # Claude Code設定
│   ├── commands/              # カスタムスラッシュコマンド
│   ├── agents/                # 専門サブエージェント
│   ├── skills/                # Agent Skills（10個）
│   │   ├── tdd-basics/        # TDD基礎
│   │   ├── testing-typescript/ # TypeScript/JavaScriptテスト
│   │   ├── testing-rust/      # Rustテスト
│   │   ├── ci-cd-setup/       # CI/CD設定
│   │   └── library-research/  # ライブラリ調査
│   └── hooks/                 # コード検証・整形スクリプト
├── .github/workflows/         # GitHub Actions
├── docs/                      # プロジェクトドキュメント
├── .mcp.json                  # MCP設定（context7, magic, github）
├── CLAUDE.md                  # Claude Codeへの詳細指示
└── README.md                  # このファイル
```

## 🛠️ 開発フロー

このリポジトリを使用した標準的な開発サイクルは以下の通りです。

### 1. Issue作成と仕様策定
機能追加やバグ修正は必ず **Issue** から開始します。
- 適切な **Issue Template** (Feature/Bug) を選択して起票します。
- 必要に応じて `@claude` と対話し、仕様を明確化します (`spec: confirmed` ラベルの獲得を目指します)。

### 2. 実装計画 (Planning)
- Issueコメントで `@claude plan` を実行します。
- Claudeが要件に基づいた詳細な実装計画を提案します。

### 3. テスト駆動開発 (TDD)
- **Red**: `@claude /testing:test-gen` を使用して、まず失敗するテストを作成します。
- **Green**: テストを通すための最小限の実装を行います。
- **Refactor**: `@claude /development:refactor` 等を用いてコードを整理します。

### 4. Pull Request とレビュー
- 実装が完了したら **Pull Request** を作成します。
- 自動的に `claude-code-review` ワークフローが走り、コード品質やセキュリティのチェックが行われます。
- `@claude /development:code-review` で手動レビューも可能です。

### 5. マージ
- すべてのチェックとレビューが完了したら、mainブランチへマージします。## 🎯 Agent Skills

開発作業を効率化する10個の特化したSkillを提供：

### 1. tdd-basics - TDD基礎
- Red-Green-Refactorサイクル
- TDDベストプラクティス
- テスト戦略（言語非依存）

### 2. testing-typescript - TypeScript/JavaScriptテスト
- Jest（単体・統合テスト）
- Playwright（E2Eテスト）
- モックとカバレッジ測定

### 3. testing-rust - Rustテスト
- cargo test/nextest
- mockallによるモック
- cargo-llvm-covによるカバレッジ

### 4. ci-cd-setup - CI/CD設定
- ghatsによる型安全なワークフロー定義
- GitHub Actionsテスト自動化
- デプロイメント戦略

### 5. library-research - ライブラリ調査
- Context7 MCPを活用した最新情報収集
- ライブラリ比較・評価
- 調査結果のドキュメント化

- 仕様作成（Specify）
- 仕様明確化（Clarify）
- 実装計画（Plan）
- タスク生成（Tasks）
- TDD実装（Implement）
- 品質分析（Analyze）
- プロジェクト憲法（Constitution）

### 7. code-review-workflow - コードレビューワークフロー
- 体系的なレビュープロセス
- セキュリティ・パフォーマンスチェック
- レビューコメントのベストプラクティス

### 8. debugging-workflow - デバッグワークフロー
- 効率的な問題解決アプローチ
- ログ分析とデバッグツール
- 体系的な原因特定

### 9. refactoring-workflow - リファクタリングワークフロー
- 安全なリファクタリング手順
- コードスメルの特定
- テストファーストリファクタリング

### 10. documentation-maintenance - ドキュメントメンテナンス
- README・API ドキュメント作成
- ドキュメント品質チェック
- 継続的なメンテナンス

## 🔌 MCP設定

効率的な開発のため、以下のMCPサーバを使用：

- **context7**: 最新情報の調査（ライブラリ、フレームワーク、ベストプラクティス）
- **magic**: 開発支援機能
- **github**: GitHub連携（Issue、PR、リポジトリ操作）

## 🤖 専門サブエージェント

以下の分野に特化したAIエージェントが利用可能：

- **rust-expert** - Rust開発専門家
- **web-developer** - Web開発専門家
- **mobile-developer** - モバイルアプリ開発専門家
- **devops-engineer** - DevOpsとインフラ専門家
- **data-scientist** - データサイエンスと機械学習専門家
- **security-expert** - セキュリティと脆弱性専門家

## 🚦 使用方法

### 基本的なワークフロー起動

#### 1. 通常の開発作業 (`@claude`)
**起動条件**: Issue または PR コメントで `@claude` を含める

```markdown
@claude ログイン機能を実装してください
@claude /development:code-review src/auth.rs
@claude rust-expert: 所有権エラーを修正してください
```

**トリガーイベント**:
- Issue コメント作成時
- PR レビューコメント作成時
- Issue 作成・割り当て時
- PR レビュー投稿時

#### 2. プロジェクト初期セットアップ (`@claude setup`)
**起動条件**: Issue または PR コメントで `@claude setup` を含める

```markdown
@claude setup 新しいRustプロジェクトをセットアップしてください
@claude setup Web開発環境を構築してください
```

**自動実行内容**:
- プロジェクト構造の分析・作成
- 設定ファイルの確認・生成
- 依存関係の解決
- 開発環境の初期化
- CI/CD設定の確認

#### 3. 仕様策定・計画作業 (`@claude plan`)
**起動条件**: Issue または PR コメントで `@claude plan` を含める

```markdown
@claude plan ユーザー管理システムの仕様を作成してください
@claude plan APIの設計を検討してください
```

**利用可能なコマンド**:

### スラッシュコマンドの詳細使用方法

#### プロジェクト管理
```markdown
@claude /project-management:setup-project
# → プロジェクトの初期セットアップを実行
```

#### 開発支援
```markdown
@claude /development:code-review src/main.rs
# → 指定ファイルのコードレビューを実行

@claude /development:debug-help "認証エラーが発生します"
# → デバッグ支援とエラー分析を実行

@claude /development:refactor --target src/auth/
# → 指定ディレクトリのリファクタリングを実行
```

#### テスト生成
```markdown
@claude /testing:test-gen --unit --integration
# → ユニットテストと統合テストを生成

@claude /testing:test-gen src/user_service.rs
# → 指定ファイル用のテストを生成
```

#### ドキュメント生成
```markdown
@claude /documentation:docs-gen --api
# → API ドキュメントを生成

@claude /documentation:docs-gen README
# → README ファイルを生成・更新
```

### サブエージェントの呼び出し方法

```markdown
# 言語・技術特化
@claude rust-expert: 所有権エラーを修正してください
@claude web-developer: レスポンシブデザインを実装してください
@claude mobile-developer: iOS向けUIを作成してください

# 専門分野特化
@claude security-expert: 脆弱性スキャンを実行してください
@claude devops-engineer: CI/CDパイプラインを構築してください
@claude data-scientist: データ分析コードを最適化してください
```

### ワークフロー実行確認

#### 実行状況の確認方法
1. **GitHub Actions タブ**で実行状況を確認
2. **Issue/PR のコメント**でリアルタイム進捗を確認
3. **スティッキーコメント**で最終結果を確認

#### 実行ログの確認
```
1. GitHub リポジトリの [Actions] タブを開く
2. 該当のワークフロー実行を選択
3. [claude], [claude-project], [claude-spec] などのジョブを選択
4. ステップごとの詳細ログを確認
```

### トラブルシューティング

#### よくある問題と解決方法

**1. ワークフローが起動しない**
- `@claude` キーワードがコメントに含まれているか確認
- リポジトリの Actions が有効になっているか確認
- 必要な Secrets (`CLAUDE_CODE_OAUTH_TOKEN`, `ANTHROPIC_API_KEY`) が設定済みか確認

**2. 権限エラーが発生する**
- GitHub Token の権限設定を確認
- リポジトリの Settings > Actions > General の権限設定を確認

**3. 特定のコマンドが動作しない**
- `.claude/commands/` ディレクトリの該当ファイルが存在するか確認
- コマンド名のスペルや形式が正しいか確認

## ⚙️ GitHub Actions

以下のワークフローが自動実行されます：

- **claude.yml** - 基本的なClaude Code実行
- **claude-project.yml** - プロジェクト管理ワークフロー
- **claude-code-review.yml** - 自動コードレビュー
- **claude-docs.yml** - ドキュメント生成
- **claude-project-management.yml** - プロジェクト管理

## 📖 詳細ドキュメント

- [SKILLS.md](docs/SKILLS.md) - Agent Skills詳細ガイド
- [AGENTS.md](docs/AGENTS.md) - サブエージェント詳細ガイド
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
- [プロジェクト憲法](.specify/memory/constitution.md)
