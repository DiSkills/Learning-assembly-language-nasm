%include "stud_io.inc"
global _start

section .text
_start: PRINT "Input char: "
        GETCHAR
        cmp al, 'A'
        jnz no
        PRINT "YES"
        jmp finish
no:     PRINT "NO"
finish: PUTCHAR 10
        FINISH
