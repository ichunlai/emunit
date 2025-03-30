#!/bin/bash

# EMUnit Test Script
# This script runs unit tests for different architectures

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default values
TARGET="x86"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --target)
            TARGET="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate target architecture
case $TARGET in
    x86|arm|riscv)
        echo "Running tests for $TARGET architecture..."
        ;;
    *)
        echo "Invalid target architecture: $TARGET"
        echo "Supported targets: x86, arm, riscv"
        exit 1
        ;;
esac

# Build directory
BUILD_DIR="$PROJECT_ROOT/build/$TARGET"

# Check if build exists
if [ ! -d "$BUILD_DIR" ]; then
    echo "Build directory not found. Building project first..."
    "$SCRIPT_DIR/build.sh" --target "$TARGET"
fi

# Run tests based on architecture
if [ "$TARGET" = "x86" ]; then
    # For x86, run tests directly
    echo "Running x86 tests..."
    cd "$BUILD_DIR"
    ctest --verbose
elif [ "$TARGET" = "arm" ]; then
    # For ARM, run tests with QEMU
    echo "Running ARM tests with QEMU..."
    cd "$BUILD_DIR/test"
    for test_bin in *_test; do
        if [ -x "$test_bin" ]; then
            echo "Running test: $test_bin"
            qemu-arm -L /usr/arm-none-eabi/lib "./$test_bin"
        fi
    done
elif [ "$TARGET" = "riscv" ]; then
    # For RISCV, run tests with QEMU
    echo "Running RISCV tests with QEMU..."
    cd "$BUILD_DIR/test"
    for test_bin in *_test; do
        if [ -x "$test_bin" ]; then
            echo "Running test: $test_bin"
            qemu-riscv32 -L /usr/riscv32-unknown-elf/lib "./$test_bin"
        fi
    done
fi

echo "All tests completed!"