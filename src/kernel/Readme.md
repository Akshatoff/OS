i686-elf-gcc -ffreestanding -c kernel.c -o kernel.o
i686-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
copy /b bootsect.bin + kernel.bin os-image.bin
qemu-system-i386 -fda os-image.bin
