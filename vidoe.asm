CSEG segment
  PUBLIC SetVideoMode
  PUBLIC ClearScreen

  SetVideoMode proc NEAR
    mov ah, 13h
    int 10h
    ret
  SetVideoMode endp

  ClearScreen proc NEAR
    pusha
    mov ax, 0A000h
    mov es, ax
    xor di, di

    cld
    mov al, 0
    mov dx, 200

    ClearRow:
      mov cx, 250
      rep stosb

      add, di, 70
      dec dx
      jnz ClearRow

      popa 
      ret

  ClearScreen endp

CSEG ends
