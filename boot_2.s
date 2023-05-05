.code16


boot:
  mov $0x2401, %ax # A20 instruction value
  int $0x15 # enable A20 bit
  mov $0x3, %ax # VGA text mode 3 value
  int $0x10

