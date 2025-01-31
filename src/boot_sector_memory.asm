[org 0x7c00]

mov ah, 0x0e

mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

the_secret:
    db "X"