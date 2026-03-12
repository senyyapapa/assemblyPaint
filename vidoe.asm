CSEG segment
  PUBLIC SetVideoMode
  PUBLIC ClearScreen

  SetVideoMode proc NEAR
    mov ah, 13h
    int 10h
    ret
  SetVideoMode endp

  ClearScreen proc NEAR
    ; TODO: There will logic for clear workspace
  ClearScreen endp

  DrawPalette proc NEAR 
    ; TODO: Need in refactor 
    ARG color:byte, x:byte, size:byte, padding:byte, count:byte

    push bp
    mov bp, sp

    pusha 

    mov ax, 0A000h
    mov es, ax

    mov bx, x
    mov dx, padding
    mov si, color 
    mov bp, count

    NextRect:
      mov ax, dx
      mov di, 320
      mul di
      add ax, bx
      mov di, ac

      mov cx, size
      mov al, si

    DrawRow:
      push cx
      push di

      mov cx, size
      cld
      rep stosb

      pop di
      add di, 320
      pop cx
      loop DrawRow

      inc si

      add dx, size
      add dx, padding

      dec bp
      jnz NextRect

    popa
    pop bp
    ret 10 ; Clean stack from args + return 
  DrawPalette endp
CSEG ends
