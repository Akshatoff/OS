org 0x7C00; Tells assembler where we expect our code to be loaded.
bits 16; Tell assembler to emit 16 bit code. Can be 32 or 64

%define ENDL 0x00, 0x0A 
;Define is used to create a const variable with the name ENDL and 0x00 is the value for end of line and 0x0A is the value for the new line character


start:
    jmp main ;Jumps to the main function as soon as the os boots


;Printing something to the screen

puts: 
    ;Saving the regsiter which we will modify
    push si ;Pushes Si to the top of the stack
    push ax

.loop:
    lodsb                   ;Loads the next character 
    or al, al               ;verify if next character is  null
    jz .done                ;Used to jump to a desitnation if zero flag is set

    mov ah, 0x0e; Calls a BIOS interupt
    int 0x10 ;The BIOS interupt code
    jmp .loop ;Jumps back to the loop and if the value is 0 then calls teh jz.done

.done: 
    pop ax ;Remove the top value from the stack and loads it into the ax register
    pop si
    ret ;Exits the function and returns to the main program

main:

    ;Setting Up Data segments
    mov ax, 0; Used to transfer data between registers, memory location or immediate values
            ;Moves the value of 0 into ax register which is a 16 bit register this effectively clears the content of ax

    mov ds, ax;Moves the value of ax into ds
    mov es, ax;moves the value of ax into es

    ;Setting up the stack
    mov ss, ax; Points to the top of a stack
    mov sp, 0x7C00 ; Stack goes downward from where we loaded in our memory

    ;Print the Message 
    mov si, msg_hello ;Moves the message into the si register
    call puts ;Puts functoion called and message printed

    hlt ;Stop CPU from executing can be resumed by an interupt

.halt:
    jmp .halt ;Jumps to given location same as goto in C

msg_hello: db 'Hello World!', ENDL , 0

times 510-($-$$) db 0 ;Db stands for define bytes. Write the given bytes to the binary file
; Times is used to repeat given instruction
;$ can be used to obtain the assembly position of the given line
;$$ position of given section
;$-$$ gives the size of our program in bytes
dw 0AA55h; dw stands for define words. Write given words to the binary file
