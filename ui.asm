.286
INCLUDE const.inc
DSEG segment PUBLIC 'DATA'
  EXTRN width_brush:WORD
DSEG ends
CSEG segment
  assume cs:CSEG, ds:DSEG

  PUBLIC DrawPalette
  PUBLIC DrawToolBar

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

  DrawToolBar proc NEAR
    pusha
    mov ax, 0A000h
    mov es, ax

    mov bx, TOOLBAR_COUNT
    mov al, TOOLBAR_COLOR
    mov dx, TOOLBAR_Y

    @@NextLine:
      push bx
      push ax
      mov ax, dx
      mov bx, ax
      shl ax, 8
      shl bx, 6
      add bx, ax
      add bx, TOOLBAR_X
      mov di, bx

      pop ax
      mov cx, TOOLBAR_CELL_SIZE
      rep stosb

      pop bx
      add dx, TOOLBAR_CELL_SIZE

      dec bx
      jnz @@NextLine
      ; jmp @@FillCell
    
    ; @@FillCell:
    ;  
    popa
    ret
  DrawToolBar endp

CSEG ends
end
