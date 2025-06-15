#!/opt/local/bin/bash
set -xue

# QEMU file path
QEMU=/opt/local/bin/qemu-system-riscv32

# Path to clang and compiler flags
CC=/opt/local/bin/clang-mp-20
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32-unknown-elf -fno-stack-protector -ffreestanding -nostdlib"

# Build the kernel
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf kernel.c common.c

# Start QEMU
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot -kernel kernel.elf
