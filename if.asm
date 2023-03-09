%include "stud_io.inc"
global _start

section .text
_start: PRINT "Input char: "
        GETCHAR
        cmp al, 'A'
        jnz finish
        PRINT "YES"
        PUTCHAR 10
finish: FINISH
