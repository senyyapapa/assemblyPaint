.286
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

  PUBLIC current_x, current_y, current_color
  PUBLIC prev_x, prev_y, is_pressed
  PUBLIC width_brush
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
  cmp al, 1Bh
  je exit
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
