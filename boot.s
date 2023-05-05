# x86 Bootloader
# 
# Minimal bootloader for x86_64 architecture
# Samuel Smith

## Preprocessor Directives
.code16 # tells the assembler that our code needs to run in 16bit mode with 16bit registers
.global _start # Makes our label "_start" available to outside linking files

## Text Section
_start: # this is the beginning of our binary
  mov $msg, %si # Loads the first byte of msg into si 
  mov $0xe, %ah # Loads the Teletype function into ah

print_char:
  lodsb # Loads the byte from address in si into al and increments si
  cmp $0, %al # Comparies content in AL with zero
  je done # if al == 0, go to "done"
  int $0x10 # prints the character in al to screen (calls interrupt 10)
  jmp print_char # Repeat
done:
  hlt # stops re-executing

msg: .asciz "Hello World!"

.fill 510-(.-_start), 1, 0 # add 0's to make it 510 bytes long
.word 0xaa55  # magic bytes that tell BIOS that this is bootable, putting it at the end here stores it at the end of our binary


