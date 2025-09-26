# カスタムスラッシュコマンド詳細ガイド

このファイルは、Claude Codeで利用可能なカスタムスラッシュコマンドの詳細な使用方法を説明します。

## コマンドディレクトリ構成

カスタムスラッシュコマンドは以下のディレクトリ構成で管理されています：

```
.claude/commands/
├── spec-kit/                    # 仕様駆動開発コマンド
│   ├── specify.md               # 仕様作成
│   ├── clarify.md               # 仕様明確化
│   ├── plan.md                  # 実装計画作成
│   ├── tasks.md                 # タスクリスト生成
│   ├── implement.md             # TDD実装
│   ├── analyze.md               # 仕様解析
│   └── constitution.md          # プロジェクト憲法管理
├── project-management/          # プロジェクト管理
│   └── setup-project.md         # プロジェクト初期セットアップ
├── development/                 # 開発支援
│   ├── code-review.md           # コード品質分析
│   ├── refactor.md              # リファクタリング
│   └── debug-help.md            # デバッグ支援
├── testing/                     # テスト関連
│   └── test-gen.md              # テストコード生成
└── documentation/               # ドキュメント
    └── docs-gen.md              # ドキュメント生成
```

## GitHub Actions統合

これらのコマンドはGitHub Actionsと統合して自動実行が可能です。詳細な仕様については、[CLAUDE_GITHUB_ACTIONS_SPECS.md](./CLAUDE_GITHUB_ACTIONS_SPECS.md)を参照してください。

## 利用可能なコマンド

### プロジェクト管理コマンド

#### `/setup-project` - プロジェクト初期セットアップ
**概要**: 新規プロジェクトの初期セットアップを自動実行
**使用例**:
```bash
@claude /setup-project
```
**実行内容**:
- プロジェクト構造の分析・作成
- 設定ファイルの確認・生成
- 依存関係の解決
- 開発環境の初期化
- CI/CD設定の確認

**対象環境**: Rust、Node.js、Python、Go、Java/Kotlin等

---

### Spec Kit統合コマンド（仕様駆動開発）

#### `/specify` - 仕様作成
**概要**: 自然言語の機能説明から正式な仕様を作成
**使用例**:
```bash
@claude /specify ユーザー登録機能を実装したい。メールとパスワードで登録し、重複チェックも行う
```
**出力**:
- 専用ブランチ作成
- 仕様ファイル（`.specify/specs/[###-feature]/spec.md`）
- 機能要求・受入条件の明確化

#### `/plan` - 実装計画作成
**概要**: 仕様から具体的な実装計画を生成
**使用例**:
```bash
@claude /plan
```
**前提条件**: 仕様ファイル（`/specify`の実行後）
**出力**:
- `plan.md` - 全体設計・技術選定
- `research.md` - 技術調査結果
- `data-model.md` - データモデル設計
- `contracts/` - API契約定義
- `quickstart.md` - 検証手順

#### `/clarify` - 仕様明確化
**概要**: 仕様の曖昧な点を対話的に明確化
**使用例**:
```bash
@claude /clarify パスワード要件とメール認証の必要性について
```
**機能**: インタラクティブな質疑応答で仕様を改善

#### `/tasks` - タスク生成
**概要**: 実装計画からTDD準拠のタスクリストを生成
**使用例**:
```bash
@claude /tasks
```
**前提条件**: 実装計画（`/plan`の実行後）
**出力**:
- TDD順序のタスクリスト
- 並列実行可能タスクのマーク `[P]`
- 依存関係の明確化
- 具体的ファイルパス指定

#### `/implement` - TDD実装
**概要**: TDDサイクルに従った機能実装
**使用例**:
```bash
@claude /implement
```
**前提条件**: タスクリスト（`/tasks`の実行後）
**実装サイクル**:
1. Red: テスト作成（失敗）
2. Green: 最小限実装
3. Refactor: コード改善

#### `/analyze` - 仕様解析
**概要**: 既存仕様の分析と評価
**使用例**:
```bash
@claude /analyze spec.md
```
**機能**: 仕様の完全性・一貫性チェック

#### `/constitution` - プロジェクト憲法管理
**概要**: 開発原則の作成・更新と準拠確認
**使用例**:
```bash
@claude /constitution
```
**機能**:
- プロジェクト憲法の作成・更新
- 開発原則への準拠チェック
- テンプレート同期

---

### 開発支援コマンド

#### `/code-review` - コード品質分析
**概要**: コードの品質分析とレビュー実行
**使用例**:
```bash
@claude /code-review src/main.rs
@claude /code-review src/
```
**分析項目**:
- バグ・セキュリティ問題
- パフォーマンス問題
- 可読性・保守性
- ベストプラクティス準拠

#### `/debug-help` - デバッグ支援
**概要**: エラー分析とデバッグ支援
**使用例**:
```bash
@claude /debug-help テストが失敗している
@claude /debug-help --error-log error.log
```
**機能**:
- エラー原因分析
- 修正方法提案
- ログ解析
- デバッグ戦略提案

#### `/refactor` - リファクタリング
**概要**: コードのリファクタリングと改善
**使用例**:
```bash
@claude /refactor src/services/
@claude /refactor --extract-function complex_method
```
**実行内容**:
- コード構造改善
- 重複除去
- 設計パターン適用
- パフォーマンス最適化

#### `/test-gen` - テストコード生成
**概要**: 自動テストコード生成
**使用例**:
```bash
@claude /test-gen --unit --integration
@claude /test-gen src/models/user.rs
```
**テスト種類**:
- 単体テスト（unit）
- 統合テスト（integration）
- 契約テスト（contract）

#### `/docs-gen` - ドキュメント生成
**概要**: 自動ドキュメント生成
**使用例**:
```bash
@claude /docs-gen
@claude /docs-gen --api --readme
```
**生成内容**:
- API仕様書
- README更新
- コード仕様書
- ユーザーガイド


## 使用時の注意点

1. **コマンドの前に `@claude` を付ける**
2. **特定のファイルやディレクトリを指定可能**
3. **オプションフラグで動作をカスタマイズ**
4. **プロジェクトの言語・フレームワークに応じて自動適応**
