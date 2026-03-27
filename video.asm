.286
CSEG segment PUBLIC 'CODE'
  assume cs:CSEG
  
  PUBLIC SetVideoMode
  PUBLIC ClearScreen

  SetVideoMode proc NEAR
    mov ax, 13h
    int 10h
    ret

  SetVideoMode endp



  ClearScreen proc NEAR
    pusha
    mov ax, 0A000h
    mov es, ax
    xor di, di

    cld
    mov ax, 0
    mov dx, 200

    ClearRow:
      mov cx, 250
      rep stosb

      add di, 70
      dec dx
      jnz ClearRow

    popa 
    ret

  ClearScreen endp

CSEG ends
end
