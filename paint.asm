.286
JUMPS
SSEG segment stack
  db 512 dup(0)
SSEG ends

DSEG segment PUBLIC 'DATA'
  current_x dw 0
  current_y dw 0
  current_color db 15

  prev_x dw 0
  prev_y dw 0
  is_pressed db 0

  width_brush dw 3

  rectangle_w dw 100
  rectangle_h dw 50
  rectangle_fill db 1
  rectangle_draw db 0

  PUBLIC current_x, current_y, current_color
  PUBLIC prev_x, prev_y, is_pressed
  PUBLIC width_brush
  PUBLIC rectangle_w, rectangle_h, rectangle_fill, rectangle_draw

DSEG ends

CSEG segment
  assume cs:CSEG, ds:DSEG, ss:SSEG

  INCLUDE const.inc
  INCLUDE macros.inc

  ; Using all proc
  EXTRN InitMouse:NEAR
  EXTRN SetVideoMode:NEAR
  EXTRN ClearScreen:NEAR
  EXTRN DrawPalette:NEAR
  EXTRN MouseHandler:FAR
  EXTRN DrawToolBar:NEAR

start: 
  mov ax, DSEG
  mov ds, ax

  call InitMouse
  cmp ax, 0000h
  je exit

  GetMouseState
  call SetVideoMode
  call ClearScreen
  DrawPaletteBorder
  DrawToolbarBorder
  call DrawToolBar
  call DrawPalette

  ; Show cursor
  mov ax, 01h
  int 33h

  jmp main_loop

main_loop:
  mov ah, 01h
  int 16h
  jz main_loop
  
  mov ah, 00h
  int 16h

  cmp al, 1Bh
  je exit

  cmp al, 63h ; c
  je @@clear_screen

  cmp al, 43h ; C
  je @@clear_screen

  cmp al, 50h ; P
  je @@draw_rectangle

  cmp al, 70h ; p
  je @@draw_rectangle

  cmp al, 75h ; u
  je @@draw_unfilled_rectangle

  cmp al, 55h ; U
  je @@draw_unfilled_rectangle

  cmp al, '1'
  jb main_loop
  cmp al, '9'
  ja main_loop
  sub al, '0'
  xor ah, ah
  mov [width_brush], ax

  jmp main_loop

@@clear_screen:
  call ClearScreen
  jmp main_loop
  
@@draw_rectangle:
  test [rectangle_draw], 1
  jnz main_loop

  mov [rectangle_draw], 1 
  mov [rectangle_fill], 1
  jmp main_loop

@@draw_unfilled_rectangle:
  test [rectangle_draw], 1
  jnz main_loop

  mov [rectangle_draw], 1 
  mov [rectangle_fill], 0
  jmp main_loop

exit:
  mov ax, 0Ch
  xor cx, cx
  xor dx, dx
  int 33h
  mov ax, 0003h
  int 10h
  
  mov ax, 4C00h
  int 21h 

CSEG ends
end start
