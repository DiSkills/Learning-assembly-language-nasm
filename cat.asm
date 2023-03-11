%include "stud_io.inc"
global _start

section .text
_start: GETCHAR
        cmp al, -1
        je finish
        PUTCHAR al
        jmp _start
finish: FINISH
