%include "stud_io.inc"
global _start

section .text
_start: GETCHAR           ;
        cmp al, -1        ; if end of file -> finish
        je finish         ;
        cmp al, 10        ; if not \n
        jne star          ; jump start
        PUTCHAR 10        ; else print('\n')
        jmp next          ; go next
star:   PRINT "*"         ; print('*')
next:   jmp _start        ; next char
finish: FINISH            ;
