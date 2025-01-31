disk_load:
    pusha
    push dx 
    mov ah, 0x02 ;read
    mov al, dh
    mov cl, 0x02

    mov ch, 0x00
    mov dh, 0x00

    int 0x13 ;Bios disk interrupt
    jc disk_err

    pop dx
    cmp al, dh
    jne sec_err
    popa
    ret

disk_err:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah is the error code and dh is the drive 
    call print_hex
    jmp disk_loop

sec_err:
    mov bx, SECTOR_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk Reading  error", 0
SECTOR_ERROR: db "Sector error", 0