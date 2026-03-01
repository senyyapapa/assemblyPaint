	SSEG segment stack
	db 256 dup(0)
SSEG ends

DSEG segment
	en_mess db 'Privet', 0dh, 0ah, '$'
  ru_mess db 'Привет', 0dh, 0ah, '$'
DSEG ends

CSEG segment
	assume cs:CSEG, ds:DSEG, ss:SSEG

begin:
	mov ax, DSEG
	mov ds, ax

	mov ah, 09h
	mov dx, offset en_mess
	int 21h

  mov ah, 09h
  mov dx, offset ru_mess
  int 21h

	mov ah, 01h
	int 21h

	mov ah, 4Ch
	int 21h
CSEG ends
end begin
