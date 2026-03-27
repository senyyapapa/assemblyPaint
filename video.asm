CSEG segment PUBLIC 'CODE'
  assume cs:CSEG
  
  PUBLIC SetVideoMode

  SetVideoMode proc
    mov ax, 13h
    int 10h
    ret

  SetVideoMode endp

CSEG ends
