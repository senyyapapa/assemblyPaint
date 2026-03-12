CSEG segment
  PUBLIC SetVideoMode
  PUBLIC ClearScreen

  SetVideoMode proc NEAR
    mov ah, 13h
    int 10h
    ret
  SetVideoMode endp

  ClearScreen proc NEAR
    ; TODO: There will logic for clear workspace
  ClearScreen endp

CSEG ends
