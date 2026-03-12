CSEG segment
  DrawPalette proc NEAR 
    ; Тут идея такая, из-за особенности, что всегда по минимуму 2 байта выделяется
    ; То чтобы максимум сэкономить места, то мы помещаем в аргумент сразу 2 переменные 
    ARG @@count_size:WORD, @@x:WORD, @@padding:WORD

    push bp
    mov bp, sp
    pusha
    cld

    mov ax, 0A000h
    mov es, ax

    mov ax, [@@padding]
    mov bx, ax

    shl ax, 8
    shl bx, 6
    add bx, ax
    
    mov di, bx ; DI = padding * 320 + x
    add di, [@@x]

    mov ax, [@@count_size]
    mov dh, ah ; DH = count
    mov dl, al ; DL = size


    mov si, 1 ; Color 

    DrawSquare:
      test dh, dh
      jz EndDraw

      mov cl, dl
      xor ch, ch

    DrawRow:
      push cx
      push di

      mov cl, dl
      xor ch, ch
      mov ax, si
      
      rep stosb

      pop di
      add di, 320

      pop cx
      loop DrawRow

      add di, bx ; BX = padding * 320

      inc si
      dec dl
      jmp DrawSquare

    EndDraw:
      popa
      pop bp
      ret 6 ; Clean stack from args + return 
  DrawPalette endp

CSEG ends
