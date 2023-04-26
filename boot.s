# x86 Bootloader
# 
# Minimal bootloader for x86_64 architecture
# Samuel Smith

## Preprocessor Directives
.code16 # tells the assembler that our code needs to run in 16bit mode with 16bit registers
.global _start # Makes our label "init" available to outside linking files


## Text Section
_start: # this is the beginning of our binary
  #jmp _start  # jump to _start, this creates an infinite loop
  # ljmpw $0xFFFF, $0 # jumps to "reset vector", re-executing the first instruction, doing a "warm-reboot"; ljmp is an instruction that means "Long Jump", you can jump to specific memory address. 
 
 ## Print to screen
  # mov $0x0e, %ah # moves 0xe to ah register (function teletype), ah is the bits 8-15 of the EAX register and al to 0x41 (Which is "A")
  # mov $0x41, %al # moves 41 into the lower 8 bits of the EAX register 
  
  # instead of doing them seperately, you can manipulate the entire lower 16 bits of the EAX register with the ax register
  # mov $0x0e41, %ax # represents ah + al (16 bits)

  # We want to write the full message, so here's how
  mov $0x0e, %ah # Move out function teletype into ah
  mov $msg, %bx # sets BX to the address of the first byte of our messagethe reason we go for bx is because addresses are 16 bits long, and bx is the culmination of bh and bl, two 8 bit long addresses
  mov (%bx), %al # sets AL to the first byte of our message (() dereferences the data from that address)

  int $0x10 # Call the function in ah from interrupt 0x10 http://www.ctyme.com/intr/rb-0106.htm
  hlt # stops re-executing

msg: .ascii "AHello World!" # Stores the string (plus a byte with value "0") and gives us access via $msg. The extra byte comes from the z on the and of asci, if we had used .ascii it would not have done this.

## Data Section
.fill 510-(.-_start), 1, 0 # add zeroes to make the bootloader it 510 bytes long
.word 0xaa55  # magic bytes that tell BIOS that this is bootable, putting it at the end here stores it at the end of our binary
