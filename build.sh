#!/bin/bash

BUILD_DIR=build

mkdir -p $BUILD_DIR

nasm -f elf src/btld/btld.asm -o $BUILD_DIR/btld.o
gcc -m32 -ffreestanding -fno-pic -c src/krnl/krnl.c -o $BUILD_DIR/krnl.o

ld -m elf_i386 -T linker.ld -o $BUILD_DIR/krnl.elf \
    $BUILD_DIR/btld.o $BUILD_DIR/krnl.o
objcopy -O binary $BUILD_DIR/krnl.elf $BUILD_DIR/btld.bin

mkisofs -R -b build/btld.bin -no-emul-boot -boot-load-size 4 -o os.iso ./

qemu-system-i386 -cdrom os.iso
