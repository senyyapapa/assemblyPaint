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
  INCLUDE const.inc
  
  PUBLIC SetVideoMode
  PUBLIC ClearScreen
  PUBLIC DrawRectangle
  PUBLIC DrawUnFilledRectangle

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
    mov dx, WORKSPACE_HEIGHT

    ClearRow:
      mov cx, WORKSPACE_WIDTH
      rep stosb

      add di, 320 - WORKSPACE_WIDTH
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

    mov ax, [current_x]
    add ax, [rectangle_w] ; x + rectangle_w ex: 250 + 150
    cmp ax, WORKSPACE_WIDTH
    ja @@SetValue 

    mov ax, [current_y]
    mov di, [current_x]
    mov bx, ax
    mov dx, [rectangle_w]

    @@GetOffset:
      shl ax, 8
      shl bx, 6
      add bx, ax
      add di, bx

    mov bx, [rectangle_h]
    mov al, [current_color]
    
    @@DrawRow:
      mov cx, dx
      rep stosb

      add di, 320 
      sub di, dx

      dec bx
      jnz @@DrawRow
      jmp @@exit

    @@SetValue:
      mov bx, ax ; bx = x + rectangle_w ex: 250 + 150
      sub bx, WORKSPACE_WIDTH ; bx = 400 - 259 = 141 
      mov ax, [rectangle_w]
      sub ax, bx ; ax = rectagle_w - our_diff = 150 - 141 = 9
      jz @@exit

      mov cx, ax
      mov dx, ax

      mov ax, [current_y]
      mov di, [current_x]
      mov bx, ax
      jmp @@GetOffset


    
    @@exit:
      mov [rectangle_draw], 0
      popa
      ret
  DrawRectangle endp

  DrawUnFilledRectangle proc NEAR
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

    @@DrawHorizontalLine:
      push di
      mov cx, [rectangle_w]
      mov al, [current_color]
      rep stosb

      pop di
      push di

      mov ax, [rectangle_h]
      dec ax
      mov bx, ax
      shl ax, 8
      shl bx, 6
      add bx, ax
      add di, bx

      mov cx, [rectangle_w]
      mov al, [current_color]
      rep stosb


    @@DrawVerticalLine:
      pop di

      mov cx, [rectangle_h]
      mov al, [current_color]

      mov bx, [rectangle_w]
      dec bx

    @@DrawVertLoop:
      mov es:[di], al
      mov es:[bx+di], al

      add di, 320
      loop @@DrawVertLoop

    mov [rectangle_draw], 0
    popa
    ret
  DrawUnFilledRectangle endp

CSEG ends
end
