---
name: testing-rust
description: Guide for Rust testing with cargo test and cargo nextest. Use when writing unit tests, integration tests, or doc tests for Rust projects. Covers test organization, mocking with mockall, and coverage measurement with cargo-llvm-cov.
---

# Rust Testing

このスキルは、Rustプロジェクトのテスト実装をガイドします。

## クイックスタート

### 単体テスト

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }
}

pub fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

**実行**:
```bash
cargo test
```

### 統合テスト

```rust
// tests/integration_test.rs
use my_crate::add;

#[test]
fn test_add_integration() {
    assert_eq!(add(2, 3), 5);
}
```

## テストツールの選択

| ツール | 用途 | 特徴 |
|--------|------|------|
| **cargo test** | 標準テストランナー | 組み込み、設定不要 |
| **cargo nextest** | 高速テストランナー | 並列実行、リトライ機能 |
| **cargo-llvm-cov** | カバレッジ測定 | 正確なカバレッジ |

## cargo test

### 基本的な使い方

```bash
# すべてのテスト実行
cargo test

# 特定のテストのみ
cargo test test_name

# 標準出力を表示
cargo test -- --nocapture

# シングルスレッドで実行
cargo test -- --test-threads=1

# ドキュメントテストも実行
cargo test --doc
```

### テストの種類

#### 1. 単体テスト

```rust
// src/lib.rs
pub fn divide(a: i32, b: i32) -> Result<i32, String> {
    if b == 0 {
        Err("Division by zero".to_string())
    } else {
        Ok(a / b)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_divide_success() {
        assert_eq!(divide(10, 2), Ok(5));
    }

    #[test]
    fn test_divide_by_zero() {
        assert_eq!(divide(10, 0), Err("Division by zero".to_string()));
    }

    #[test]
    #[should_panic(expected = "assertion failed")]
    fn test_panic() {
        assert_eq!(1, 2);
    }
}
```

#### 2. 統合テスト

```rust
// tests/integration_test.rs
use my_crate::UserService;

#[test]
fn test_create_user() {
    let service = UserService::new();
    let user = service.create_user("Alice").unwrap();
    assert_eq!(user.name, "Alice");
}
```

#### 3. ドキュメントテスト

```rust
/// Adds two numbers together.
///
/// # Examples
///
/// ```
/// use my_crate::add;
/// assert_eq!(add(2, 3), 5);
/// ```
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

## cargo nextest

### インストール

```bash
cargo install cargo-nextest --locked
```

### 使い方

```bash
# すべてのテスト実行
cargo nextest run

# 特定のテストのみ
cargo nextest run test_name

# 失敗したテストのみ再実行
cargo nextest run --failed

# JUnit形式でレポート出力
cargo nextest run --profile ci
```

### 設定ファイル

```toml
# .config/nextest.toml
[profile.default]
retries = 2
fail-fast = false

[profile.ci]
retries = 3
fail-fast = true
```

## モックとスタブ

### mockallの使用

```rust
use mockall::predicate::*;
use mockall::mock;

// トレイトの定義
pub trait Database {
    fn get_user(&self, id: u32) -> Option<String>;
}

// モックの生成
mock! {
    pub Database {}
    
    impl Database for Database {
        fn get_user(&self, id: u32) -> Option<String>;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_with_mock() {
        let mut mock = MockDatabase::new();
        mock.expect_get_user()
            .with(eq(1))
            .times(1)
            .returning(|_| Some("Alice".to_string()));

        assert_eq!(mock.get_user(1), Some("Alice".to_string()));
    }
}
```

## カバレッジ測定

### cargo-llvm-covのインストール

```bash
cargo install cargo-llvm-cov
```

### カバレッジ測定

```bash
# HTMLレポート生成
cargo llvm-cov --html
open target/llvm-cov/html/index.html

# lcov形式で出力
cargo llvm-cov --lcov --output-path lcov.info

# カバレッジ表示
cargo llvm-cov
```

## テスト実行スクリプト

プロジェクトタイプを自動検出してテストを実行:

```bash
bash .claude/skills/testing-rust/scripts/run_tests.sh
```

オプション:
- `--coverage`: カバレッジレポート生成
- `--nextest`: cargo nextestを使用

## TDDワークフロー

TDDの基本概念については [tdd-basics](../tdd-basics/SKILL.md) を参照してください。

### Red-Green-Refactorサイクル

```bash
# 1. Red: テストを書く
cargo watch -x test

# 2. Green: 実装する
# （エディタでコードを書く）

# 3. Refactor: 改善する
# （テストが通る状態を維持）
```

## ベストプラクティス

### 1. テストの命名規則

```rust
#[test]
fn test_[function_name]_[expected_behavior]_when_[condition]() {
    // テストコード
}
```

### 2. AAA パターン

```rust
#[test]
fn test_calculate_discount() {
    // Arrange: テストデータの準備
    let price = 1000;
    let discount_rate = 0.1;

    // Act: テスト対象の実行
    let result = calculate_discount(price, discount_rate);

    // Assert: 結果の検証
    assert_eq!(result, 900);
}
```

### 3. エラーハンドリングのテスト

```rust
#[test]
fn test_error_handling() {
    let result = divide(10, 0);
    assert!(result.is_err());
    assert_eq!(result.unwrap_err(), "Division by zero");
}
```

## CI/CD統合

GitHub Actionsでのテスト自動化については [ci-cd-setup](../ci-cd-setup/SKILL.md) を参照してください。

## トラブルシューティング

### テストが失敗する

1. エラーメッセージを確認
2. `-- --nocapture`で標準出力を確認
3. デバッガーを使用（`rust-lldb`、`rust-gdb`）

### カバレッジが低い

1. `cargo llvm-cov --html`でカバレッジレポートを確認
2. テストされていないコードパスを特定
3. エッジケースのテストを追加

### 並列実行での問題

1. `-- --test-threads=1`でシングルスレッド実行
2. テストの独立性を確認
3. 共有リソースの使用を避ける

## 参考リソース

- [Rust Testing Guide](https://doc.rust-lang.org/book/ch11-00-testing.html)
- [cargo-nextest](https://nexte.st/)
- [mockall](https://docs.rs/mockall/)
- [cargo-llvm-cov](https://github.com/taiki-e/cargo-llvm-cov)
