[org 0x7c00]
    mov bp, 0x8000 ;sets teh stack away from our code
    mov sp, bp

    mov bx, 0x9000
    mov dh, 2 ;Reads the 2 secotr

    call disk_load

    mov dx, [0x9000]; Loads the first word
    call print_hex

    call print_nl

    mov dx, [0x9000 + 512] ;first word from second sector
    call print_hex

    jmp $

%include "boot_sector_disk.asm"
%include "boot_sector_print_hex.asm"
%include "boot_sector_print.asm"


times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada 
times 256 dw 0xface
