.286
DSEG segment PUBLIC 'DATA'
    EXTRN current_x:WORD
    EXTRN current_y:WORD
    EXTRN current_color:BYTE

    EXTRN rectangle_w:WORD
    EXTRN rectangle_h:WORD
    EXTRN rectangle_draw:BYTE

DSEG ends
CSEG segment PUBLIC 'CODE'
  assume cs:CSEG, ds:DSEG
  
  PUBLIC SetVideoMode
  PUBLIC ClearScreen
  PUBLIC DrawRectangle

  SetVideoMode proc NEAR
    mov ax, 13h
    int 10h
    ret

  SetVideoMode endp



  ClearScreen proc NEAR
    pusha
    mov ax, 02h
    int 33h

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

    mov ax, 01h
    int 33h
    popa 
    ret

  ClearScreen endp

  DrawRectangle proc NEAR
    pusha
    
    mov ax, 0A000h
    mov es, ax
    
    mov ax, [current_y]
    mov di, [current_x]
    mov bx, ax

    shl ax, 8
    shl bx, 6
    add bx, ax
    add di, bx

    mov bx, [rectangle_h]
    mov al, [current_color]
    
    @@DrawRow:
      mov cx, [rectangle_w]
      rep stosb

      add di, 320
      sub di, [rectangle_w]

      dec bx
      jnz @@DrawRow
    
    mov [rectangle_draw], 0
    popa
    ret
  DrawRectangle endp

CSEG ends
end
