---
name: testing-typescript
description: Guide for TypeScript/JavaScript testing with Jest and Playwright. Use when writing unit tests, integration tests, or E2E tests for TypeScript/JavaScript projects. Covers Jest configuration, Playwright setup, mocking, and test automation.
---

# TypeScript/JavaScript Testing

このスキルは、TypeScript/JavaScriptプロジェクトのテスト実装をガイドします。

## クイックスタート

### Jest（単体・統合テスト）

```typescript
import { describe, it, expect } from '@jest/globals';

describe('Calculator', () => {
  it('should add two numbers', () => {
    expect(2 + 3).toBe(5);
  });
});
```

**実行**:
```bash
npm test
```

### Playwright（E2Eテスト）

```typescript
import { test, expect } from '@playwright/test';

test('homepage has title', async ({ page }) => {
  await page.goto('https://example.com');
  await expect(page).toHaveTitle(/Example/);
});
```

**実行**:
```bash
npx playwright test
```

## テストツールの選択

| ツール | 用途 | 特徴 |
|--------|------|------|
| **Jest** | 単体・統合テスト | 高速、モック機能、カバレッジ |
| **Playwright** | E2Eテスト | クロスブラウザ、自動待機、UIモード |

## Jest設定

### インストール

```bash
npm install --save-dev jest ts-jest @types/jest
```

### 設定ファイル

詳細な設定については [JEST.md](JEST.md) を参照してください。

**基本設定**:
```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
};
```

### テストの実行

```bash
# すべてのテスト実行
npm test

# ウォッチモード
npm test -- --watch

# カバレッジ測定
npm test -- --coverage

# 特定のテストのみ
npm test -- path/to/test.test.ts
```

## Playwright設定

### インストール

```bash
npm install --save-dev @playwright/test
npx playwright install
```

### 設定ファイル

詳細な設定については [PLAYWRIGHT.md](PLAYWRIGHT.md) を参照してください。

**基本設定**:
```typescript
// playwright.config.ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  use: {
    baseURL: 'http://localhost:3000',
  },
});
```

### テストの実行

```bash
# すべてのE2Eテスト実行
npx playwright test

# UIモード（推奨）
npx playwright test --ui

# デバッグモード
npx playwright test --debug

# テストコード生成
npx playwright codegen http://localhost:3000
```

## テスト実行スクリプト

プロジェクトタイプを自動検出してテストを実行:

```bash
bash .claude/skills/testing-typescript/scripts/run_tests.sh
```

オプション:
- `--coverage`: カバレッジレポート生成
- `--watch`: ウォッチモード

## TDDワークフロー

TDDの基本概念については [tdd-basics](../tdd-basics/SKILL.md) を参照してください。

### Red-Green-Refactorサイクル

```bash
# 1. Red: テストを書く
npm test -- --watch

# 2. Green: 実装する
# （エディタでコードを書く）

# 3. Refactor: 改善する
# （テストが通る状態を維持）
```

## 詳細ガイド

- **Jest詳細**: [JEST.md](JEST.md) - テストパターン、モック、カバレッジ
- **Playwright詳細**: [PLAYWRIGHT.md](PLAYWRIGHT.md) - E2Eテスト、ページオブジェクト、ベストプラクティス

## CI/CD統合

GitHub Actionsでのテスト自動化については [ci-cd-setup](../ci-cd-setup/SKILL.md) を参照してください。

## トラブルシューティング

### テストが失敗する

1. エラーメッセージを確認
2. テストの前提条件を確認
3. モックが正しく設定されているか確認

### カバレッジが低い

1. テストされていないコードパスを特定
2. エッジケースのテストを追加
3. 統合テストでカバレッジを補完

### Playwrightのタイムアウト

1. `timeout`設定を調整
2. `waitForSelector`で要素を待機
3. ネットワークの遅延を考慮

## 参考リソース

- [Jest Documentation](https://jestjs.io/)
- [Playwright Documentation](https://playwright.dev/)
- [Testing Library](https://testing-library.com/)
