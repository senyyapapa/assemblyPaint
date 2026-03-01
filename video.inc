video_init macro
  mov ax, 12h ; set video mode with 640x480 16 colors
  int 10h
endm

draw_panel macro
  
endm

draw_color proc posX posY color
  mov al, color
draw_color endp
