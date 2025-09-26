# /test-gen

テストコードの自動生成と既存テストの改善を行います。

## 実行内容
1. 単体テストの生成
2. 統合テストの作成
3. エッジケースの特定とテスト化
4. モックオブジェクトの作成
5. テストカバレッジの向上
6. テストデータの生成

## 使用例
- `/test-gen` - 選択中の関数/クラスのテストを生成
- `/test-gen --unit` - 単体テストのみ生成
- `/test-gen --integration` - 統合テストを生成

## 対応するテストタイプ
- Unit Tests（単体テスト）
- Integration Tests（統合テスト）
- End-to-End Tests（E2Eテスト）
- Performance Tests（性能テスト）
- Security Tests（セキュリティテスト）
- Property-based Tests（プロパティベーステスト）