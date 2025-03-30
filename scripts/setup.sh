#!/bin/bash

# EMUnit Setup Script
# This script installs all necessary dependencies for the EMUnit project

set -e
set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SYS_TMP_DIR="$(mktemp -d)"
NEWLIB_VERSION="newlib-4.5.0"
UNITY_VERSION="2.6.1"
FFF_VERSION="1.1"

echo "EMUnit Setup Script"
echo "===================="
echo "Installing dependencies for EMUnit project..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install basic build tools
install_build_tools() {
    echo "Installing build tools..."
    sudo apt-get update
    sudo apt-get install -y build-essential cmake git wget curl unzip
}

# Install QEMU
install_qemu() {
    echo "Installing QEMU..."
    sudo apt-get install -y qemu-system-arm qemu-system-misc
}

# Install ARM toolchain
install_arm_toolchain() {
    if ! command_exists arm-none-eabi-gcc; then
        echo "Installing ARM toolchain..."
        sudo apt-get install -y gcc-arm-none-eabi
    else
        echo "ARM toolchain already installed."
    fi
}

# Install RISCV toolchain
install_riscv_toolchain() {
    if ! command_exists riscv32-unknown-elf-gcc; then
        echo "Installing RISCV toolchain..."
        sudo apt-get install -y gcc-riscv64-unknown-elf
        # Create symlinks for riscv32 if needed
        if [ ! -f /usr/bin/riscv32-unknown-elf-gcc ]; then
            echo "Creating RISCV32 toolchain symlinks..."
            for tool in gcc g++ ar ranlib objcopy objdump size; do
                sudo ln -sf /usr/bin/riscv64-unknown-elf-$tool /usr/bin/riscv32-unknown-elf-$tool
            done
        fi
    else
        echo "RISCV toolchain already installed."
    fi
}

# Clone NEWLIB
clone_newlib() {
    echo "Cloning NEWLIB repository..."
    if [ ! -d "$PROJECT_ROOT/lib/newlib/src" ]; then
        mkdir -p "$PROJECT_ROOT/lib/newlib"
        git clone --depth 1 --branch $NEWLIB_VERSION https://sourceware.org/git/newlib-cygwin.git "$PROJECT_ROOT/lib/newlib/src"
    else
        echo "NEWLIB already cloned."
    fi
}

# Download Unity Test Framework
download_unity() {
    echo "Downloading Unity Test Framework..."
    if [ ! -d "$PROJECT_ROOT/lib/unity" ]; then
        wget -O unity.zip "https://github.com/ThrowTheSwitch/Unity/archive/v${UNITY_VERSION}.zip"
        unzip unity.zip -d "$PROJECT_ROOT/lib/"
        mv "$PROJECT_ROOT/lib/Unity-${UNITY_VERSION}" "$PROJECT_ROOT/lib/unity"
        rm unity.zip
    else
        echo "Unity already downloaded."
    fi
}

# Download FFF (Fake Function Framework)
download_fff() {
    echo "Downloading FFF (Fake Function Framework)..."
    if [ ! -d "$PROJECT_ROOT/lib/fff" ]; then
        wget -O fff.zip "https://github.com/meekrosoft/fff/archive/v${FFF_VERSION}.zip"
        unzip fff.zip -d "$PROJECT_ROOT/lib/"
        mv "$PROJECT_ROOT/lib/fff-${FFF_VERSION}" "$PROJECT_ROOT/lib/fff"
        rm fff.zip
    else
        echo "FFF already downloaded."
    fi
}

# Main installation process
main() {
    install_build_tools
    install_qemu
    install_arm_toolchain
    install_riscv_toolchain
    clone_newlib
    download_unity
    download_fff

    echo "Setup completed successfully!"
    echo "You can now build the project using: ./scripts/build.sh --target [x86|arm|riscv]"
}

main
