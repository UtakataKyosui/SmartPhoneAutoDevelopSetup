---
name: refactoring-workflow
description: Guide for safe and effective refactoring. Use when improving code structure, reducing technical debt, or applying design patterns. Covers test-first refactoring and incremental improvements.
---

# Refactoring Workflow

このスキルは、安全で効果的なリファクタリングプロセスをガイドします。

## リファクタリングの原則

### テストファーストリファクタリング

```
リファクタリングフロー:
- [ ] 1. テストを書く（または既存テストを確認）
- [ ] 2. テストが通ることを確認（Green）
- [ ] 3. リファクタリングを実行
- [ ] 4. テストが通ることを確認（Green維持）
- [ ] 5. コミット
```

**重要**: テストなしでリファクタリングしない

### 小さなステップで進める

- [ ] 1つの変更を小さく保つ
- [ ] 各ステップでテストを実行
- [ ] 頻繁にコミット

## コードスメルの特定

### 1. 長いメソッド

**問題**:
- 理解が困難
- テストが難しい
- 再利用性が低い

**リファクタリング**: メソッド抽出

```typescript
// Before
function processOrder(order: Order) {
  // 検証（20行）
  // 計算（30行）
  // 保存（15行）
  // 通知（10行）
}

// After
function processOrder(order: Order) {
  validateOrder(order);
  const total = calculateTotal(order);
  saveOrder(order, total);
  notifyCustomer(order);
}
```

### 2. 重複コード

**問題**:
- メンテナンスコストが高い
- バグが複数箇所に存在する可能性

**リファクタリング**: 共通処理の抽出

```typescript
// Before
function processUserOrder(user: User, order: Order) {
  if (!user.isActive) throw new Error('Inactive user');
  if (!user.hasPermission('order')) throw new Error('No permission');
  // 処理
}

function processAdminOrder(admin: Admin, order: Order) {
  if (!admin.isActive) throw new Error('Inactive user');
  if (!admin.hasPermission('order')) throw new Error('No permission');
  // 処理
}

// After
function validateUser(user: User | Admin) {
  if (!user.isActive) throw new Error('Inactive user');
  if (!user.hasPermission('order')) throw new Error('No permission');
}

function processUserOrder(user: User, order: Order) {
  validateUser(user);
  // 処理
}
```

### 3. 大きなクラス

**問題**:
- 単一責任の原則違反
- 理解が困難
- 変更の影響範囲が広い

**リファクタリング**: クラスの分割

```typescript
// Before
class User {
  // ユーザー情報
  // 認証ロジック
  // 権限管理
  // 通知設定
  // メール送信
}

// After
class User {
  // ユーザー情報のみ
}

class UserAuthenticator {
  // 認証ロジック
}

class UserPermissions {
  // 権限管理
}

class UserNotifier {
  // 通知設定とメール送信
}
```

### 4. 長いパラメータリスト

**問題**:
- 関数呼び出しが複雑
- 引数の順序を間違えやすい

**リファクタリング**: パラメータオブジェクトの導入

```typescript
// Before
function createUser(
  name: string,
  email: string,
  age: number,
  address: string,
  phone: string,
  role: string
) {
  // 処理
}

// After
interface UserParams {
  name: string;
  email: string;
  age: number;
  address: string;
  phone: string;
  role: string;
}

function createUser(params: UserParams) {
  // 処理
}
```

### 5. 複雑な条件式

**問題**:
- 可読性が低い
- バグが混入しやすい

**リファクタリング**: 条件の分解と命名

```typescript
// Before
if (user.age >= 18 && user.hasLicense && !user.isSuspended && user.balance > 0) {
  // 処理
}

// After
const isAdult = user.age >= 18;
const hasValidLicense = user.hasLicense && !user.isSuspended;
const hasBalance = user.balance > 0;

if (isAdult && hasValidLicense && hasBalance) {
  // 処理
}

// さらに良い
function canDrive(user: User): boolean {
  return user.age >= 18 
    && user.hasLicense 
    && !user.isSuspended 
    && user.balance > 0;
}

if (canDrive(user)) {
  // 処理
}
```

## リファクタリングパターン

### 1. メソッド抽出（Extract Method）

長いメソッドを小さなメソッドに分割:

```typescript
// Before
function generateReport(data: Data[]) {
  let html = '<html><body>';
  html += '<h1>Report</h1>';
  html += '<table>';
  for (const item of data) {
    html += '<tr>';
    html += `<td>${item.name}</td>`;
    html += `<td>${item.value}</td>`;
    html += '</tr>';
  }
  html += '</table>';
  html += '</body></html>';
  return html;
}

// After
function generateReport(data: Data[]): string {
  return wrapInHtml(
    generateHeader() + generateTable(data)
  );
}

function generateHeader(): string {
  return '<h1>Report</h1>';
}

function generateTable(data: Data[]): string {
  const rows = data.map(generateRow).join('');
  return `<table>${rows}</table>`;
}

function generateRow(item: Data): string {
  return `<tr><td>${item.name}</td><td>${item.value}</td></tr>`;
}

function wrapInHtml(content: string): string {
  return `<html><body>${content}</body></html>`;
}
```

### 2. 変数の抽出（Extract Variable）

複雑な式を変数に抽出:

```typescript
// Before
if (platform.toUpperCase().indexOf('MAC') > -1 &&
    browser.toUpperCase().indexOf('IE') > -1 &&
    wasInitialized() && resize > 0) {
  // 処理
}

// After
const isMacOS = platform.toUpperCase().indexOf('MAC') > -1;
const isIE = browser.toUpperCase().indexOf('IE') > -1;
const wasResized = wasInitialized() && resize > 0;

if (isMacOS && isIE && wasResized) {
  // 処理
}
```

### 3. 関数のインライン化（Inline Function）

不要な間接化を削除:

```typescript
// Before
function getRating(driver: Driver): number {
  return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver: Driver): boolean {
  return driver.numberOfLateDeliveries > 5;
}

// After
function getRating(driver: Driver): number {
  return driver.numberOfLateDeliveries > 5 ? 2 : 1;
}
```

### 4. 条件記述の分解（Decompose Conditional）

複雑な条件を関数に抽出:

```typescript
// Before
if (date.before(SUMMER_START) || date.after(SUMMER_END)) {
  charge = quantity * winterRate + winterServiceCharge;
} else {
  charge = quantity * summerRate;
}

// After
if (isWinter(date)) {
  charge = winterCharge(quantity);
} else {
  charge = summerCharge(quantity);
}

function isWinter(date: Date): boolean {
  return date.before(SUMMER_START) || date.after(SUMMER_END);
}

function winterCharge(quantity: number): number {
  return quantity * winterRate + winterServiceCharge;
}

function summerCharge(quantity: number): number {
  return quantity * summerRate;
}
```

## 安全なリファクタリング手順

### 1. 準備

**テストの確認**:
- [ ] 既存のテストが存在するか
- [ ] テストカバレッジが十分か
- [ ] すべてのテストが通るか

**変更範囲の特定**:
- [ ] 影響を受けるコードを特定
- [ ] 依存関係を確認

### 2. 実行

**小さなステップで**:
1. 1つの変更を実施
2. テストを実行
3. テストが通ることを確認
4. コミット
5. 次の変更へ

**自動化ツールの活用**:
- IDEのリファクタリング機能
- 自動フォーマッター
- 静的解析ツール

### 3. 検証

**テストの実行**:
```bash
# すべてのテストを実行
npm test

# カバレッジを確認
npm run test:coverage
```

**手動確認**:
- [ ] 主要な機能が動作するか
- [ ] パフォーマンスが劣化していないか

### 4. レビュー

**セルフレビュー**:
- [ ] 変更が意図通りか
- [ ] 新しいコードスメルが発生していないか
- [ ] ドキュメントが更新されているか

**チームレビュー**:
- [ ] PRを作成
- [ ] レビューを依頼
- [ ] フィードバックを反映

## リファクタリングのタイミング

### ボーイスカウトルール

**「来た時よりも美しく」**

コードを触るたびに少しずつ改善:
- バグ修正時に周辺コードをリファクタリング
- 機能追加時に既存コードを整理
- コードレビュー時に改善提案

### 計画的リファクタリング

**技術的負債の返済**:
- [ ] 定期的なリファクタリング時間を確保
- [ ] 優先度の高い負債から対処
- [ ] チーム全体で取り組む

## 言語別のリファクタリング

### TypeScript/JavaScript

**型の活用**:
```typescript
// Before
function process(data: any) {
  // 処理
}

// After
interface ProcessData {
  id: number;
  name: string;
}

function process(data: ProcessData) {
  // 処理
}
```

### Rust

**所有権の最適化**:
```rust
// Before
fn process(data: Vec<String>) -> Vec<String> {
    // data の所有権を奪う
    data
}

// After
fn process(data: &[String]) -> Vec<String> {
    // 借用を使用
    data.to_vec()
}
```

## トラブルシューティング

### テストが壊れた

**対処法**:
1. 前回のコミットに戻る（`git reset --hard HEAD~1`）
2. より小さなステップで再試行
3. テストを先に修正

### パフォーマンスが劣化した

**対処法**:
1. ベンチマークで計測
2. プロファイラーでボトルネックを特定
3. 必要に応じて最適化

## 関連Skill

- **tdd-basics**: [tdd-basics](../tdd-basics/SKILL.md) - テストファーストリファクタリング
- **code-review-workflow**: [code-review-workflow](../code-review-workflow/SKILL.md) - リファクタリングのレビュー
- **testing-typescript**: [testing-typescript](../testing-typescript/SKILL.md) - TypeScriptテスト
- **testing-rust**: [testing-rust](../testing-rust/SKILL.md) - Rustテスト

## 参考リソース

- [Refactoring by Martin Fowler](https://refactoring.com/)
- [Code Smells](https://refactoring.guru/refactoring/smells)
