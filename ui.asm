.286
INCLUDE const.inc
CSEG segment
  assume cs:CSEG

  PUBLIC DrawPalette

  DrawPalette proc NEAR
    pusha
    mov ax, 0A000h
    mov es, ax

    mov ax, COLOR_PADDING_Y
    mov di, PALETTE_X + COLOR_PADDING_X

    mov bx, ax
    shl ax, 8
    shl bx, 6
    add bx, ax
    add di, bx

    mov al, 15
    mov dx, COLOR_COUNT

    DrawNextBox:
      mov bx, COLOR_BOX_SIZE

      DrawRow:
        mov cx, COLOR_BOX_SIZE
        rep stosb

        add di, 320 - COLOR_BOX_SIZE

        dec bx
        jne DrawRow

      add di, 320 * COLOR_PADDING_Y
      dec al

      dec dx
      jne DrawNextBox

    popa
    ret
  DrawPalette endp

CSEG ends
end
