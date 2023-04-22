
# Assemble the bootloader
write "Assembling ..."
as -o boot.o boot.s
write "Linking ..."
ld -r -Ttext 0x0 -e _start -s -o boot.out boot.o
objcopy -O binary -j .text boot.out boot.bin
write "Removing output files ..."
rm boot.out
rm boot.o
