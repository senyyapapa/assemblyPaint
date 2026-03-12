DrawPaletteBorder macro
  LOCAL DrawVertLine
  pusha

  mov ax, 0A000h
  mov es, ax

  mov ax, PALETTE_Y
  mov bx, 320
  mul bx
  add ax, PALETTE_X
  mov di, ax

  mov cx, PALETTE_H
  mov al, PALETTE_COLOR

  DrawVertLine:
    mov es:[di], al
    add di, 320
    loop DrawVertLine
  popa
endm
