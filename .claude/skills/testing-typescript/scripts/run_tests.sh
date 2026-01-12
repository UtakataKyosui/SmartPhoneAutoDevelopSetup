#!/bin/bash
# テスト実行スクリプト
# プロジェクトタイプを自動検出してテストを実行

set -e

# カラー出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 使用方法
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --coverage    カバレッジレポートを生成"
    echo "  --watch       ウォッチモードで実行"
    echo "  --help        このヘルプを表示"
    exit 1
}

# オプション解析
COVERAGE=false
WATCH=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --coverage)
            COVERAGE=true
            shift
            ;;
        --watch)
            WATCH=true
            shift
            ;;
        --help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

echo -e "${GREEN}🧪 テスト実行スクリプト${NC}"
echo ""

# プロジェクトタイプの検出
detect_project_type() {
    if [ -f "package.json" ]; then
        echo "typescript"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    else
        echo -e "${RED}❌ サポートされていないプロジェクトタイプです${NC}"
        echo "package.json または Cargo.toml が見つかりません"
        exit 1
    fi
}
# TypeScript/JavaScript テスト実行
run_typescript_tests() {
    echo -e "${YELLOW}📦 TypeScript/JavaScript プロジェクトを検出${NC}"
    
    # テストフレームワークの検出
    if grep -q "jest" package.json; then
        FRAMEWORK="jest"
        TEST_CMD="npm test"
    elif grep -q "@playwright/test" package.json; then
        FRAMEWORK="playwright"
        TEST_CMD="npx playwright test"
    else
        echo -e "${RED}❌ テストフレームワークが見つかりません${NC}"
        echo "package.json に jest または @playwright/test を追加してください"
        exit 1
    fi
    
    echo -e "${GREEN}✓ テストフレームワーク: $FRAMEWORK${NC}"
    
    # オプションに応じてコマンドを構築
    if [ "$WATCH" = true ]; then
        if [ "$FRAMEWORK" = "jest" ]; then
            TEST_CMD="$TEST_CMD -- --watch"
        elif [ "$FRAMEWORK" = "playwright" ]; then
            TEST_CMD="$TEST_CMD --ui"
        fi
    fi
    
    if [ "$COVERAGE" = true ]; then
        if [ "$FRAMEWORK" = "jest" ]; then
            TEST_CMD="$TEST_CMD -- --coverage"
        elif [ "$FRAMEWORK" = "playwright" ]; then
            echo -e "${YELLOW}⚠ Playwrightはカバレッジオプションをサポートしていません${NC}"
        fi
    fi
    
    echo -e "${YELLOW}実行コマンド: $TEST_CMD${NC}"
    echo ""
    
    # テスト実行
    eval $TEST_CMD
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✅ すべてのテストがパスしました${NC}"
    else
        echo ""
        echo -e "${RED}❌ テストが失敗しました${NC}"
        exit 1
    fi
}

# Rust テスト実行
run_rust_tests() {
    echo -e "${YELLOW}🦀 Rust プロジェクトを検出${NC}"
    
    # cargo-nextest の確認
    if command -v cargo-nextest &> /dev/null; then
        FRAMEWORK="cargo-nextest"
        TEST_CMD="cargo nextest run"
    else
        FRAMEWORK="cargo test"
        TEST_CMD="cargo test"
    fi
    
    echo -e "${GREEN}✓ テストフレームワーク: $FRAMEWORK${NC}"
    
    # ウォッチモードは cargo-watch を使用
    if [ "$WATCH" = true ]; then
        if ! command -v cargo-watch &> /dev/null; then
            echo -e "${YELLOW}⚠ cargo-watch がインストールされていません${NC}"
            echo "インストール: cargo install cargo-watch"
            exit 1
        fi
        TEST_CMD="cargo watch -x test"
    fi
    
    # カバレッジ測定
    if [ "$COVERAGE" = true ]; then
        if ! command -v cargo-llvm-cov &> /dev/null; then
            echo -e "${YELLOW}⚠ cargo-llvm-cov がインストールされていません${NC}"
            echo "インストール: cargo install cargo-llvm-cov"
            exit 1
        fi
        TEST_CMD="cargo llvm-cov --html"
        echo -e "${YELLOW}カバレッジレポート: target/llvm-cov/html/index.html${NC}"
    fi
    
    echo -e "${YELLOW}実行コマンド: $TEST_CMD${NC}"
    echo ""
    
    # テスト実行
    eval $TEST_CMD
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✅ すべてのテストがパスしました${NC}"
        
        if [ "$COVERAGE" = true ]; then
            echo -e "${GREEN}📊 カバレッジレポート: target/llvm-cov/html/index.html${NC}"
        fi
    else
        echo ""
        echo -e "${RED}❌ テストが失敗しました${NC}"
        exit 1
    fi
}

# メイン処理
PROJECT_TYPE=$(detect_project_type)

case $PROJECT_TYPE in
    typescript)
        run_typescript_tests
        ;;
    rust)
        run_rust_tests
        ;;
    *)
        echo -e "${RED}❌ 不明なプロジェクトタイプ: $PROJECT_TYPE${NC}"
        exit 1
        ;;
esac
