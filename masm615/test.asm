.model small
.stack 010h
.data
     var BYTE 2
.code
     mov ax, @data
     mov ds, ax
     mov ax, 0
     mov ax, var
     mov ah, 4ch
     int 21h
end