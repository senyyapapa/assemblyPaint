SSEG segment stack
  db 256 dup(0)
SSEG ends

DSEG segment

DSEG ends

CSEG segment
  assume cs:CSEG, ds:DSEG, ss:SSEG

start: 
  mov ax, DSEG
  mov ds, ax
CSEG ends
end start
