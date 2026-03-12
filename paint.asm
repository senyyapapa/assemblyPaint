.586
SSEG segment stack
  db 256 dup(0)
SSEG ends

DSEG segment

DSEG ends

CSEG segment
  assume cs:CSEG, ds:DSEG, ss:SSEG

  ; Include all .inc files with macros + consts
  INCLUDE macros.inc
  INCLUDE const.inc
  
  ; Using extern proc
  EXTRN SetVideoMode:NEAR
  EXTRN InitMouse:NEAR
start: 
  mov ax, DSEG
  mov ds, ax

  call InitMouse
  cmp ax, 0000h
  je exit

  call SetVideoMode
  DrawPaletteBorder 

main_loop:
  

exit: 
  mov ax, 4c00h
  int 21h
CSEG ends
end start
