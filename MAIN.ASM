.386
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

  ; initialize mouse with 6 buttons and activate video mode
  mouse_init
  video_init ; 640x480x16
  
  jmp main_loop ; after all init go to main loop

main_loop:
	mov ah, 0
	int 16h

  ; If pressed key - Ctrl+c then exit
	cmp al, 03h
	je exit

exit:
	mov ax, 4Ch
	int 21h

  ; All includes files
  INCLUDE mouse.inc
  INCLUDE video.inc
CSEG ends
end start
