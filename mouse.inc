mouse_init macro
  xor ax 
  mov bx, 06h ; 6 button
  int 33h
  test ax, ax
  ; show cursor
  mov ax, 01h
  int 33h
endm
