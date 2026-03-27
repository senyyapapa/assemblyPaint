CSEG segment PUBLIC 'CODE'
  assume cs:CSEG

  PUBLIC InitMouse

  InitMouse proc
    mov ax, 00h
    int 33h
    ret
  InitMouse endp
CSEG ends
end
