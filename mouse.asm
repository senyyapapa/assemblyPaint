.286
DSEG segment PUBLIC 'DATA'
  EXTRN current_x:WORD
  EXTRN current_y:WORD
  EXTRN current_color:BYTE

  EXTRN prev_x:WORD
  EXTRN prev_y:WORD 
  EXTRN is_pressed:BYTE

  EXTRN width_brush:WORD

  EXTRN rectangle_draw:BYTE
  EXTRN rectangle_fill:BYTE

DSEG ends
CSEG segment PUBLIC 'CODE'
  assume cs:CSEG, ds:DSEG
  INCLUDE macros.inc
  INCLUDE const.inc

  EXTRN DrawRectangle:NEAR
  EXTRN DrawUnFilledRectangle:NEAR

  PUBLIC InitMouse
  PUBLIC MouseHandler

  InitMouse proc
    mov ax, 00h
    int 33h
    ret
  InitMouse endp

  MouseHandler proc FAR
    push ds
    mov ax, 02h
    int 33h

    mov ax, DSEG
    mov ds, ax
    pusha

    shr cx, 1

    test bx, 02h
    jnz @@RightClick

    test bx, 01h
    jnz @@LeftClick

    
    jmp @@exitf
    
    @@LeftClick:
      cmp cx, 259
      ja @@exitf

      mov [current_x], cx
      mov [current_y], dx

      test [rectangle_draw], 1
      jnz @@draw_rectangle


      DrawPixel
      jmp @@exitf

    @@RightClick:
      cmp cx, 260
      jb @@exitf

      mov ax, dx
      mov si, 320
      mul si
      add ax, cx
      mov bx, ax
      mov si, 0A000h
      mov es, si
      mov al, es:[bx]
      mov byte ptr [current_color], al

      mov ax, 01h
      int 33h
      jmp @@exitf

    @@draw_rectangle:
      cmp [rectangle_fill], 1
      jne @@draw_unfilled_rectangle

      call DrawRectangle
      jmp @@exitf

    @@draw_unfilled_rectangle:
      call DrawUnFilledRectangle
      jmp @@exitf

  @@exitf:
    mov ax, 01h
    int 33h
    popa
    pop ds
    retf
  MouseHandler endp
CSEG ends
end
