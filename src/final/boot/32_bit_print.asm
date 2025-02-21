[bits 32] ;Enters into 32 bit protected mode

;Define Constants
VIDEO_MEMORY equ 0xb8000
WHITE_OB_BLACK equ 0x0f ;Color byte for each character

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ;Ebx is the address of character
    mov ah, WHITE_OB_BLACK

    cmp al, 0; If this is the end of string
    je print_string_pm_done

    mov [edx], ax; store the character + attribute in video memory
    add ebx, 1;next character
    add edx, 2; next video memory position

    jmp print_string_pm_loop

print_string_pm_done:
    popa 
    ret
