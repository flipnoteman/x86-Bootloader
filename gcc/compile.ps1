
# Assemble the bootloader
write "Assembling ..."
# as -o boot.o boot.s
wsl bash -c "as -o boot.o ./boot.s"
write "Linking ..."
wsl bash -c "ld -o boot.bin --oformat binary -e _start -Ttext 0x7c00 -o boot.bin boot.o"
# ld -r -Ttext 0x7c00 -e _start -o boot.out boot.o
# objcopy -O binary -j .text boot.out boot.bin
write "Removing output files ..."
rm boot.o
