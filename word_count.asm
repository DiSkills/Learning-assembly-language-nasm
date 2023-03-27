%include "stud_io.inc"
global _start

section .text
_start:     mov ebx, ' '        ; clear previous char
char:       GETCHAR             ;
            cmp al, -1          ; char == eof
            je finish           ; go to finish
            cmp al, 10          ; char == \n
            je line             ; go to line
            cmp al, ' '         ; char != space
            jne next            ; go to next
            cmp bl, ' '         ; previous char == space
            je next             ; go to next
            PRINT "*"           ; print('*')
            jmp next            ; go to next
line:       cmp bl, ' '         ; previous char == space
            je new_line         ; go to new line
            PRINT "*"           ; print('*')
new_line:   PUTCHAR 10          ; print('\n')
            mov eax, ' '        ; clear current char
next:       mov ebx, eax        ; previous char = current char
            jmp char            ; go to next char
finish:     FINISH              ;
