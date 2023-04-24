# x86 Bootloader
# 
# Minimal bootloader for x86_64 architecture
# Samuel Smith

## Preprocessor Directives
.code16 # tells the assembler that our code needs to run in 16bit mode with 16bit registers
.global _start # Makes our label "init" available to outside linking files


## Text Section
_start: # this is the beginning of our binary
  jmp _start # jump to init, this creates an infinite loop


## Data Section
.fill 510-(.-_start), 1, 0 # add zeroes to make the bootloader it 510 bytes long
.word 0xaa55  # magic bytes that tell BIOS that this is bootable
