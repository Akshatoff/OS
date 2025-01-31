mov ah, 0x0e ;Sets up the tty mode

mov bp, 0x8000 ; This is an address far away from the boot sector
mov sp, bp; Stack pointer init

push 'A'
push 'B'
push 'C'



mov al, [0x8000]
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55