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

GetMouseState macro
    mov ax, 0Ch
    mov dx, offset MouseHandler
    mov bx, cs
    mov es, bx
    mov cx, 001011b
    int 33h
endm

DrawPixel macro
  pusha

  mov ax, 0A000h
  mov es, ax

  mov ax, [current_y]
  mov bx, ax
  mov di, [current_x]
  
  shl ax, 8
  shl bx, 6
  add bx, ax
  add di, bx
  mov al, [current_color]
  mov dx, [width_brush]

  DrawRow:
    mov cx, [width_brush]
    rep stosb

    add di, 320
    sub di, [width_brush]

    dec dx
    jne DrawRow

  popa
endm

DrawToolbarBorder macro
  LOCAL DrawVertLine
  pusha

  mov ax, 0A000h
  mov es, ax

  mov ax, TOOLBAR_Y
  mov bx, 320
  mul bx
  add ax, TOOLBAR_BORDER_X
  mov di, ax

  mov cx, TOOLBAR_H
  mov al, TOOLBAR_COLOR

  DrawVertLine:
    mov es:[di], al
    add di, 320
    loop DrawVertLine
  popa
endm
