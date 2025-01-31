[org 0x7c00]

mov bx, HELLO
call print

call print_nl

mov bx, WORLD
call print

call print_nl

mov dx, 0x12fe
call print_hex

jmp $

%include "boot_sector_print.asm"
%include "boot_sector_print_hex.asm"

HELLO:
    db "HELLO ", 0

WORLD:
    db "WORLD", 0

times 510-($-$$) db 0
dw 0xaa55