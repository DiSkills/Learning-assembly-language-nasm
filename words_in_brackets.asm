%include "stud_io.inc"
global _start

section .text
_start:     mov ebx, ' '        ; clear previous char
char:       GETCHAR             ;
            cmp al, -1          ; char == eof
            je finish           ; go to finish
            cmp al, 10          ; char == \n
            je right            ; go to right
left:       cmp al, ' '         ; char == space
            je right            ; go to right
            cmp bl, ' '         ; previous char != space
            jne print           ; go to print char
            PUTCHAR '('         ; print('(')
            jmp print           ; go to print char
right:      cmp bl, ' '         ; char == space
            je print            ; go to print char
            PUTCHAR ')'         ; print(')')
print:      PUTCHAR al          ; print(current char)
            cmp al, 10          ; char != \n
            jne next            ; go to next
            mov eax, ' '        ; current char = space
next:       mov ebx, eax        ; previous char = current char
            jmp char            ; go to next char
finish:     FINISH              ;
