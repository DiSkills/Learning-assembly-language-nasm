%include "stud_io.inc"
global _start

section .text
_start: GETCHAR            ;
        cmp al, 10         ; if \n -> finish
        je finish          ;
        cmp al, -1         ; if end of file -> finish
        je finish          ;
        sub al, 30h        ; al -= ord('0')
        jz next            ; if al == 0 -> next char
        cmp al, 9          ; al <= 9 -> al - digit
        jnbe next          ; if not digit -> next char
star:   PRINT '*'          ;
        dec al             ; al -= 1
        jnz star           ; if al != 0 -> print next star
next:   jmp _start         ; next iteration
finish: PUTCHAR 10         ; print('\n')
        FINISH             ;
