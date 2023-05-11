
# Script to assemble and run the bootloader
write "Running compile.ps1 ..."
./compile.ps1
write "Starting Qemu ..."
qemu-system-x86_64 boot.bin
