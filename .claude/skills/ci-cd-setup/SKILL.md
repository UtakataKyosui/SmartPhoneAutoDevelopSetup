---
name: ci-cd-setup
description: Guide for setting up CI/CD pipelines with GitHub Actions. Use when configuring automated testing, deployment workflows, or continuous integration. Covers ghats for type-safe workflow definitions, test automation, and deployment strategies.
---

# CI/CD Setup

このスキルは、GitHub Actionsを使用したCI/CDパイプラインの設定をガイドします。

## クイックスタート

### ghatsによる型安全なワークフロー定義

```typescript
// .github/workflows/src/ci.ts
import { workflow, job, step } from "ghats";
import * as checkout from "ghats/actions/checkout";
import * as setupNode from "ghats/actions/setup-node";

const ci = workflow("CI", {
  on: {
    push: { branches: ["main"] },
    pull_request: { branches: ["main"] },
  },
  jobs: {
    test: job("Run Tests", {
      "runs-on": "ubuntu-latest",
      steps: [
        step.uses(checkout.action()),
        step.uses(setupNode.action({ "node-version": "20" })),
        step.run("Install dependencies", "npm ci"),
        step.run("Run tests", "npm test"),
      ],
    }),
  },
});

export default ci;
```

**ビルド**:
```bash
cd .github/workflows
npm run build
```

## ghatsのセットアップ

### インストール

```bash
cd .github/workflows
npm init -y
npm install --save-dev ghats tsx
```

### package.json設定

```json
{
  "name": "github-workflows",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "build": "tsx src/index.ts"
  }
}
```

## TypeScript/JavaScriptプロジェクトのCI

### 単体テスト + E2Eテスト

```typescript
const ci = workflow("CI", {
  on: {
    push: { branches: ["main"] },
    pull_request: { branches: ["main"] },
  },
  jobs: {
    test: job("Run Unit Tests", {
      "runs-on": "ubuntu-latest",
      steps: [
        step.uses(checkout.action()),
        step.uses(setupNode.action({
          "node-version": "20",
          cache: "npm",
        })),
        step.run("Install dependencies", "npm ci"),
        step.run("Run linter", "npm run lint"),
        step.run("Run tests", "npm test -- --coverage"),
      ],
    }),
    
    e2e: job("Run E2E Tests", {
      "runs-on": "ubuntu-latest",
      steps: [
        step.uses(checkout.action()),
        step.uses(setupNode.action({ "node-version": "20" })),
        step.run("Install dependencies", "npm ci"),
        step.run("Install Playwright",
          "npx playwright install --with-deps"),
        step.run("Run E2E tests", "npx playwright test"),
      ],
    }),
  },
});
```

## Rustプロジェクトの CI

```typescript
const rustCI = workflow("Rust CI", {
  on: {
    push: { branches: ["main"] },
    pull_request: { branches: ["main"] },
  },
  jobs: {
    test: job("Test", {
      "runs-on": "ubuntu-latest",
      steps: [
        step.uses(checkout.action()),
        step.run("Install Rust", 
          "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"),
        step.run("Run clippy", "cargo clippy -- -D warnings"),
        step.run("Check formatting", "cargo fmt --check"),
        step.run("Run tests", "cargo test"),
      ],
    }),
  },
});
```

## デプロイメント戦略

### 環境別デプロイ

#### 開発環境

```typescript
const deployDev = workflow("Deploy to Development", {
  on: { push: { branches: ["develop"] } },
  jobs: {
    deploy: job("Deploy", {
      "runs-on": "ubuntu-latest",
      environment: "development",
      steps: [
        step.uses(checkout.action()),
        step.run("Build", "npm run build"),
        step.run("Deploy", "npm run deploy:dev"),
      ],
    }),
  },
});
```

#### 本番環境

```typescript
const deployProd = workflow("Deploy to Production", {
  on: { push: { tags: ["v*"] } },
  jobs: {
    deploy: job("Deploy", {
      "runs-on": "ubuntu-latest",
      environment: "production",
      steps: [
        step.uses(checkout.action()),
        step.run("Pre-deployment checks",
          "bash .claude/skills/ci-cd-setup/scripts/deploy_check.sh"),
        step.run("Build", "npm run build"),
        step.run("Deploy", "npm run deploy:prod"),
      ],
    }),
  },
});
```

## デプロイ前チェック

すべてのチェックを自動実行:

```bash
bash .claude/skills/ci-cd-setup/scripts/deploy_check.sh
```

**チェック項目**:
- ✅ テストがパス
- ✅ リントエラーなし
- ✅ セキュリティ脆弱性なし
- ✅ ビルド成功
- ✅ カバレッジ目標達成

## セキュリティベストプラクティス

### 1. 最小権限の原則

```typescript
const workflow = workflow("CI", {
  permissions: {
    contents: "read",
    "pull-requests": "write",
  },
  // ...
});
```

### 2. アクションのバージョン固定

```typescript
// SHAハッシュで固定
step.uses("actions/checkout@8ade135a41bc03ea155e62e844d188df1ea18608")
```

### 3. シークレット管理

```typescript
step.run("Deploy", "npm run deploy", {
  env: {
    API_KEY: "${{ secrets.API_KEY }}",
  },
})
```

## キャッシュ戦略

### Node.js依存関係

```typescript
import * as cache from "ghats/actions/cache";

step.uses(cache.action({
  path: "~/.npm",
  key: "${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}",
}))
```

### Rustビルド

```typescript
step.uses(cache.action({
  path: [
    "~/.cargo/bin/",
    "~/.cargo/registry/",
    "target/",
  ].join("\n"),
  key: "${{ runner.os }}-cargo-${{ hashFiles('**/Cargo.lock') }}",
}))
```

## テスト自動化

テスト実装の詳細については、以下のSkillを参照してください：

- **TypeScript/JavaScript**: [testing-typescript](../testing-typescript/SKILL.md)
- **Rust**: [testing-rust](../testing-rust/SKILL.md)

## TDD統合

TDDワークフローについては [tdd-basics](../tdd-basics/SKILL.md) を参照してください。

## 詳細ガイド

- **GitHub Actions詳細**: [GITHUB_ACTIONS.md](GITHUB_ACTIONS.md)
- **デプロイメント戦略**: [DEPLOYMENT.md](DEPLOYMENT.md)

## トラブルシューティング

### ワークフローが実行されない

1. トリガー条件を確認
2. ブランチ名が正しいか確認
3. YAML構文エラーを確認

### デプロイが失敗する

1. ログを確認
2. ローカルで同じコマンドを実行
3. 環境変数が正しく設定されているか確認

## 参考リソース

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [ghats](https://github.com/koki-develop/ghats)
- [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
