# Source files
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# Replace .c files with .o for object files
OBJ = ${C_SOURCES:.c=.o}

# Compiler and tools
CC = i686-elf-gcc
LD = i686-elf-ld
GDB = i686-elf-gdb
QEMU = qemu-system-i386

# Compiler flags
CFLAGS = -g -ffreestanding

# Default rule
all: os-image.bin

# Merge boot sector and kernel
os-image.bin: boot/bootsect.bin kernel.bin
	cat boot/bootsect.bin kernel.bin > os-image.bin

# Link kernel (Added `--entry=_start` to fix missing entry symbol warning)
kernel.bin: boot/kernel_entry.o ${OBJ}
	$(LD) -Ttext 0x1000 --entry=_start -o $@ $^ --oformat binary

# Debug version (Added `--entry=_start` to keep symbols properly)
kernel.elf: boot/kernel_entry.o ${OBJ}
	$(LD) -Ttext 0x1000 --entry=_start -o $@

# Run in QEMU
run: os-image.bin
	$(QEMU) -fda os-image.bin

# Debugging with GDB
debug: os-image.bin kernel.elf
	$(QEMU) -s -fda os-image.bin &
	$(GDB) -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# Compile C files to object files
%.o: %.c ${HEADERS}
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble assembly files to object files
%.o: %.asm
	nasm $< -f elf -o $@

# Assemble boot sector
%.bin: %.asm
	nasm $< -f bin -o $@

# Clean files (Windows-friendly fix)
clean:
	rm -f *.bin *.dis *.o os-image.bin *.elf
	rm -f kernel/*.o boot/*.bin drivers/*.o boot/*.o
