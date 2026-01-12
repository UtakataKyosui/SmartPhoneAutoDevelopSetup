---
name: documentation-maintenance
description: Guide for continuous documentation maintenance. Use when creating or updating documentation, writing API docs, maintaining README files, or ensuring documentation quality.
---

# Documentation Maintenance

このスキルは、継続的なドキュメントメンテナンスをガイドします。

## ドキュメントの種類

### 1. README.md

**必須セクション**:
- [ ] プロジェクト概要
- [ ] インストール手順
- [ ] 使用方法
- [ ] 設定方法
- [ ] コントリビューションガイド
- [ ] ライセンス

**テンプレート**:
```markdown
# Project Name

Brief description of what this project does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

\`\`\`bash
npm install project-name
\`\`\`

## Usage

\`\`\`typescript
import { function } from 'project-name';

function();
\`\`\`

## Configuration

\`\`\`typescript
const config = {
  option1: 'value1',
  option2: 'value2'
};
\`\`\`

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

MIT
```

### 2. API ドキュメント

**TypeScript/JavaScript**:
```typescript
/**
 * Processes user data and returns a summary.
 * 
 * @param user - The user object to process
 * @param options - Optional processing options
 * @returns A summary of the user data
 * @throws {ValidationError} If user data is invalid
 * 
 * @example
 * ```typescript
 * const summary = processUser(user, { detailed: true });
 * console.log(summary);
 * ```
 */
export function processUser(
  user: User,
  options?: ProcessOptions
): UserSummary {
  // 実装
}
```

**Rust**:
```rust
/// Processes user data and returns a summary.
///
/// # Arguments
///
/// * `user` - The user object to process
/// * `options` - Optional processing options
///
/// # Returns
///
/// A summary of the user data
///
/// # Errors
///
/// Returns `ValidationError` if user data is invalid
///
/// # Examples
///
/// ```
/// let summary = process_user(&user, Some(options));
/// println!("{:?}", summary);
/// ```
pub fn process_user(
    user: &User,
    options: Option<ProcessOptions>
) -> Result<UserSummary, ValidationError> {
    // 実装
}
```

### 3. CHANGELOG.md

**フォーマット**:
```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- New feature description

### Changed
- Changed feature description

### Fixed
- Bug fix description

## [1.0.0] - 2024-01-01

### Added
- Initial release
```

### 4. CONTRIBUTING.md

**必須セクション**:
- [ ] 開発環境のセットアップ
- [ ] コーディング規約
- [ ] コミットメッセージ規約
- [ ] PR作成ガイド
- [ ] テスト実行方法

### 5. アーキテクチャドキュメント

**ADR (Architecture Decision Records)**:
```markdown
# ADR-001: Use TypeScript for Backend

## Status
Accepted

## Context
We need to choose a language for our backend services.

## Decision
We will use TypeScript for backend development.

## Consequences
### Positive
- Type safety
- Better IDE support
- Shared code with frontend

### Negative
- Compilation step required
- Learning curve for team
```

## ドキュメント作成のベストプラクティス

### 1. 明確で簡潔に

**良い例**:
```markdown
## Installation

Install the package using npm:

\`\`\`bash
npm install my-package
\`\`\`
```

**悪い例**:
```markdown
## How to Install This Package

First, you need to have npm installed on your system.
Then, open your terminal and navigate to your project directory.
After that, you can install the package by running the following command...
```

### 2. コード例を含める

すべての主要な機能にコード例を提供:

```markdown
## Usage

### Basic Example

\`\`\`typescript
import { createUser } from 'my-package';

const user = createUser({
  name: 'John Doe',
  email: 'john@example.com'
});
\`\`\`

### Advanced Example

\`\`\`typescript
const user = createUser({
  name: 'John Doe',
  email: 'john@example.com',
  options: {
    sendWelcomeEmail: true,
    role: 'admin'
  }
});
\`\`\`
```

### 3. 最新の状態を保つ

**ドキュメント更新のタイミング**:
- [ ] 新機能追加時
- [ ] API変更時
- [ ] バグ修正時（重要な場合）
- [ ] 設定変更時

### 4. スクリーンショットを活用

UIの説明にはスクリーンショットを含める:

```markdown
## Dashboard

The main dashboard shows your project overview:

![Dashboard Screenshot](./docs/images/dashboard.png)
```

## コードコメントのベストプラクティス

### WHYを説明する

**良い例**:
```typescript
// ユーザーのセッションタイムアウトを30分に設定
// 短すぎるとユーザー体験が悪化し、長すぎるとセキュリティリスクが高まる
const SESSION_TIMEOUT = 30 * 60 * 1000;
```

**悪い例**:
```typescript
// タイムアウトを設定
const SESSION_TIMEOUT = 30 * 60 * 1000;
```

### 複雑なロジックを説明する

```typescript
// Fisher-Yates アルゴリズムを使用した配列のシャッフル
// O(n) の時間計算量で、すべての順列が等確率で生成される
function shuffle<T>(array: T[]): T[] {
  const result = [...array];
  for (let i = result.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [result[i], result[j]] = [result[j], result[i]];
  }
  return result;
}
```

### TODOコメントの管理

```typescript
// TODO(username): Implement caching for better performance
// Issue: #123
// Deadline: 2024-12-31
function fetchData() {
  // 実装
}
```

## ドキュメント生成ツール

### TypeScript/JavaScript

**TypeDoc**:
```bash
# インストール
npm install --save-dev typedoc

# ドキュメント生成
npx typedoc src/index.ts
```

**JSDoc**:
```bash
# インストール
npm install --save-dev jsdoc

# ドキュメント生成
npx jsdoc src
```

### Rust

**cargo doc**:
```bash
# ドキュメント生成
cargo doc

# ブラウザで開く
cargo doc --open

# プライベート項目も含める
cargo doc --document-private-items
```

## ドキュメントの品質チェック

### チェックリスト

**README.md**:
- [ ] プロジェクト概要が明確か
- [ ] インストール手順が正確か
- [ ] 使用例が動作するか
- [ ] リンクが切れていないか
- [ ] スクリーンショットが最新か

**API ドキュメント**:
- [ ] すべての公開APIに説明があるか
- [ ] パラメータが説明されているか
- [ ] 戻り値が説明されているか
- [ ] エラーケースが説明されているか
- [ ] 使用例があるか

**CHANGELOG.md**:
- [ ] 最新バージョンが記載されているか
- [ ] 破壊的変更が明記されているか
- [ ] リリース日が記載されているか

## ドキュメントの多言語対応

### ディレクトリ構造

```
docs/
├── en/
│   ├── README.md
│   ├── API.md
│   └── CONTRIBUTING.md
├── ja/
│   ├── README.md
│   ├── API.md
│   └── CONTRIBUTING.md
└── zh/
    ├── README.md
    ├── API.md
    └── CONTRIBUTING.md
```

### 言語切り替えリンク

```markdown
# Project Name

[English](./en/README.md) | [日本語](./ja/README.md) | [中文](./zh/README.md)
```

## ドキュメントレビュー

### レビューポイント

- [ ] 技術的な正確性
- [ ] 文法とスペル
- [ ] 一貫性（用語、スタイル）
- [ ] 完全性（必要な情報がすべて含まれているか）
- [ ] 可読性

### ツールの活用

**スペルチェック**:
```bash
# cspell を使用
npm install -g cspell
cspell "**/*.md"
```

**リンクチェック**:
```bash
# markdown-link-check を使用
npm install -g markdown-link-check
markdown-link-check README.md
```

## ドキュメントの自動化

### CI/CDでのドキュメント生成

**GitHub Actions**:
```yaml
name: Generate Docs

on:
  push:
    branches: [main]

jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Generate docs
        run: npm run docs
      
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

## トラブルシューティング

### ドキュメントが古くなっている

**対処法**:
1. ドキュメント更新をPRの必須項目にする
2. 定期的なドキュメントレビューを実施
3. 自動化ツールで検出

### ドキュメントが見つからない

**対処法**:
1. README.mdに目次を追加
2. ドキュメントの構造を整理
3. 検索機能を追加

## 関連Skill

- **code-review-workflow**: [code-review-workflow](../code-review-workflow/SKILL.md) - ドキュメントレビュー

## 参考リソース

- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
- [Write the Docs](https://www.writethedocs.org/)
