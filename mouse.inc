mouse_init macro
  xor ax 
  int 33h
  test ax, ax
  ; show cursor
  mov ax, 01h
  int 33h
endm
