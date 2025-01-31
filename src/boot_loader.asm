mov ah, 0x0e ;Sets up the tty mode
mov al, 'H' ;Prints the letter H
int 0x10 ;Calls the interrupt for video service
mov al, 'e' ;Prints the letter e
int 0x10
mov al, 'l' ;Prints the letter l
int 0x10
mov al, 'l' ;Prints the letter l
int 0x10
mov al, 'o' ;Prints the letter o
int 0x10

jmp $; jumps to the current address inifinite loop

times 510-($-$$) db 0; Fills everything with 0
dw 0xaa55