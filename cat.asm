%include "stud_io.inc"
global _start

section .text
_start: GETCHAR        ; input char
        cmp al, -1     ; if char == Ctrl+D -> finish
        je finish      ;
        PUTCHAR al     ; print char
        jmp _start     ;
finish: FINISH
