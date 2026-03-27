.286
SSEG segment stack
  db 256 dup(0)
SSEG ends

DSEG segment
  INCLUDE const.inc

  ; color_padding_y db 8
  ; color_padding_x db 22
  ;
  ; PUBLIC color_padding_y
  ; PUBLIC color_padding_x
DSEG ends

CSEG segment
  assume cs:CSEG, ds:DSEG, ss:SSEG

  INCLUDE macros.inc

  ; Using all proc
  EXTRN InitMouse:NEAR
  EXTRN SetVideoMode:NEAR
  EXTRN ClearScreen:NEAR
  EXTRN DrawPalette:NEAR

start: 
  mov ax, DSEG
  mov ds, ax

  call InitMouse
  cmp ax, 0000h
  je exit
  
  call SetVideoMode
  call ClearScreen
  DrawPaletteBorder
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
  mov ax, 0003h
  int 10h
  
  mov ax, 4C00h
  int 21h 

CSEG ends
end start
