CSEG segment
  
  InitMouse proc NEAR
    mov ax, 00h
    int 33h

    ; show cursor
    mov ax, 01h
    int 33h
    ret
  InitMouse endp

CSEG ends
