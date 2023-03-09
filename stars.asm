%include "stud_io.inc"
global _start

section .text
_start: GETCHAR                 ;
        sub al, 30h             ;
        cmp al, 9               ; 0 <= el <= 9
        jnbe finish             ; if not -> finish
        mov cl, al              ; copy al -> cl
        jecxz finish            ; ecx == 0 -> finish
lp:     PRINT "*"               ; print loop stars
        loop lp                 ;
        PUTCHAR 10              ;
finish: FINISH
