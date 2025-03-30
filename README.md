# EMUnit - Cross-Platform Embedded Unit Testing Framework

EMUnit is a comprehensive embedded software project that demonstrates cross-platform unit testing capabilities for multiple architectures including X86, ARM (arm926-ejs), and RISCV (riscv32).

## Features

- Multi-architecture support (X86, ARM, RISCV)
- CMake-based build system
- Unity test framework integration
- NEWLIB standard library integration
- QEMU-based test execution
- GitHub Actions CI/CD pipeline

## Prerequisites

- Linux development environment
- CMake (version 3.12 or higher)
- GCC toolchains:
  - X86 GCC
  - ARM GCC (for arm926-ejs)
  - RISCV GCC (for riscv32)
- QEMU for ARM and RISCV emulation
- Git

## Project Structure

```
.
├── cmake/              # CMake modules and utilities
├── docs/              # Documentation
├── include/           # Header files
├── lib/              # Third-party libraries
│   └── newlib/       # NEWLIB source code
├── scripts/          # Build and test scripts
├── src/              # Source code
├── test/             # Unit tests
└── toolchain/        # Toolchain configuration files
```

## Quick Start

1. Set up the development environment:
   ```bash
   ./scripts/setup.sh
   ```

2. Build for different targets:
   ```bash
   # Build for X86
   ./scripts/build.sh --target x86

   # Build for ARM
   ./scripts/build.sh --target arm

   # Build for RISCV
   ./scripts/build.sh --target riscv
   ```

3. Run unit tests:
   ```bash
   # Run tests for X86
   ./scripts/test.sh --target x86

   # Run tests for ARM (using QEMU)
   ./scripts/test.sh --target arm

   # Run tests for RISCV (using QEMU)
   ./scripts/test.sh --target riscv
   ```

## Documentation

Detailed documentation is available in the `docs/` directory:

- [Setup Guide](docs/setup.md)
- [Build Instructions](docs/build.md)
- [Testing Guide](docs/testing.md)
- [NEWLIB Integration](docs/newlib.md)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.