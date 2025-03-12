#!/bin/bash

BUILD_DIR=build

mkdir -p $BUILD_DIR

nasm -f elf src/btldr.asm -o $BUILD_DIR/btldr.o
gcc -m32 -ffreestanding -fno-pic -c src/krnl/krnl.c -o $BUILD_DIR/krnl.o

ld -m elf_i386 -T linker.ld -o $BUILD_DIR/krnl.elf \
    $BUILD_DIR/btldr.o $BUILD_DIR/krnl.o
objcopy -O binary $BUILD_DIR/krnl.elf $BUILD_DIR/btldr.bin

mkisofs -R -b build/btldr.bin -no-emul-boot -boot-load-size 4 -o os.iso ./

qemu-system-i386 -cdrom os.iso
