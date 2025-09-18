#!/bin/bash
# Cargo format check hook for Claude Code
set -e

# Ensure Rust environment is loaded
if command -v cargo >/dev/null 2>&1; then
    echo "🎨 Checking Rust formatting..."
    cargo fmt --check --quiet
    if [ $? -eq 0 ]; then
        echo "✅ Code formatting is correct"
    else
        echo "❌ Code formatting issues found"
        echo "💡 Run 'cargo fmt' to fix formatting"
        exit 1
    fi
else
    # Load Rust environment if not available
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
        echo "🎨 Checking Rust formatting..."
        cargo fmt --check --quiet
        if [ $? -eq 0 ]; then
            echo "✅ Code formatting is correct"
        else
            echo "❌ Code formatting issues found"
            echo "💡 Run 'cargo fmt' to fix formatting"
            exit 1
        fi
    else
        echo "⚠️ Cargo not found, skipping format check"
        exit 0
    fi
fi
