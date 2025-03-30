#!/bin/bash

# EMUnit Build Script
# This script handles building the project for different architectures

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default values
TARGET="x86"
BUILD_TYPE="Debug"
BUILD_TESTS=ON

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --target)
            TARGET="$2"
            shift
            shift
            ;;
        --release)
            BUILD_TYPE="Release"
            shift
            ;;
        --no-tests)
            BUILD_TESTS=OFF
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
        echo "Building for $TARGET architecture..."
        ;;
    *)
        echo "Invalid target architecture: $TARGET"
        echo "Supported targets: x86, arm, riscv"
        exit 1
        ;;
esac

# Create build directory
BUILD_DIR="$PROJECT_ROOT/build/$TARGET"
mkdir -p "$BUILD_DIR"

# Configure CMake
echo "Configuring CMake for $TARGET..."
cd "$BUILD_DIR"
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DTARGET_ARCH=$TARGET \
      -DBUILD_TESTS=$BUILD_TESTS \
      "$PROJECT_ROOT"

# Build the project
echo "Building project..."
cmake --build "$BUILD_DIR" -- -j$(nproc)

echo "Build completed successfully!"
echo "Output files can be found in: $BUILD_DIR"