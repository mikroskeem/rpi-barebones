#CROSS_COMPILE = arm-none-eabi-
CROSS_COMPILE = 
CC = $(CROSS_COMPILE)gcc
OBJCOPY = $(CROSS_COMPILE)objcopy
RM = rm -rf
CFLAGS = -mcpu=arm1176jzf-s -fpic -ffreestanding

all: boot.o kernel.o
	$(CC) -T linker.ld -o kernel.elf -ffreestanding -O2 -nostdlib boot.o kernel.o
	$(OBJCOPY) kernel.elf -O binary kernel.bin
clean:
	$(RM) *.o *.elf *.bin
boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o
kernel.o: kernel.c
	$(CC) $(CFLAGS) -std=gnu99 -c kernel.c -o kernel.o -O2 -Wall -Wextra
