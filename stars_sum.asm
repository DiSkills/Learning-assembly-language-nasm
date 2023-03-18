%include "stud_io.inc"
global _start

section .text
_start: GETCHAR            ;
        cmp al, 10         ; if \n -> finish
        je finish          ;
        cmp al, -1         ; if end of file -> finish
        je finish          ;
        sub al, 30h        ; al - ord('0')
        jz next            ; if al == 0 -> next char
        cmp al, 9          ; 1 <= al <= 9
        jnbe next          ; if not digit -> next char
star:   PRINT '*'          ;
        dec al             ;
        jnz star           ;
next:   jmp _start         ;
finish: PUTCHAR 10         ;
        FINISH             ;
