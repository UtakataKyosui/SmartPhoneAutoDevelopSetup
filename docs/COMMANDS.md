# カスタムスラッシュコマンド詳細ガイド

このファイルは、Claude Codeで利用可能なカスタムスラッシュコマンドの詳細な使用方法を説明します。

## 利用可能なコマンド

### `/setup-project` - プロジェクト初期セットアップ
```
@claude /setup-project
```
- 新規プロジェクトの初期セットアップを自動化
- 言語やフレームワークを自動検出
- 必要な設定ファイルやCI/CD設定を生成

### `/code-review` - コード品質分析
```
@claude /code-review
@claude /code-review --full
@claude /code-review src/main.rs
```
- コード品質、セキュリティ、パフォーマンスの分析
- テストカバレッジやドキュメントの評価
- ベストプラクティスの適用確認

### `/debug-help` - デバッグ支援
```
@claude /debug-help
@claude /debug-help --error "compilation error"
```
- エラーメッセージの分析と解決策提案
- デバッグ手法の提案
- ログ分析とトラブルシューティング

### `/refactor` - コードリファクタリング
```
@claude /refactor
@claude /refactor --target performance
@claude /refactor --target maintainability
```
- コードの構造改善と最適化
- 可読性と保守性の向上
- パフォーマンス最適化

### `/test-gen` - テストコード生成
```
@claude /test-gen
@claude /test-gen --unit --integration
@claude /test-gen src/lib.rs
```
- ユニットテスト、統合テストの自動生成
- テストカバレッジの向上
- エッジケースのテスト追加

### `/docs-gen` - ドキュメント生成
```
@claude /docs-gen
@claude /docs-gen --api
@claude /docs-gen --readme
```
- API ドキュメントの自動生成
- README やユーザーガイドの作成
- コードコメントの充実

## 使用時の注意点

1. **コマンドの前に `@claude` を付ける**
2. **特定のファイルやディレクトリを指定可能**
3. **オプションフラグで動作をカスタマイズ**
4. **プロジェクトの言語・フレームワークに応じて自動適応**