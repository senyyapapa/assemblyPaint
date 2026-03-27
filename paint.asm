.286
SSEG segment stack
  db 256 dup(0)
SSEG ends

DSEG segment
  INCLUDE const.inc
DSEG ends

CSEG segment
  assume cs:CSEG, ds:DSEG, ss:SSEG

  INCLUDE macros.inc

  ; Using all proc
  EXTRN InitMouse:NEAR
  EXTRN SetVideoMode:NEAR

start: 
  mov ax, DSEG
  mov ds, ax

  call InitMouse
  cmp ax, 0000h
  je exit
  
  call SetVideoMode

  ; Show cursor
  mov ax, 01h
  int 33h

exit:
  mov ax, 0003h
  int 10h
  
  mov ax, 4C00h
  int 21h 

CSEG ends
end start
