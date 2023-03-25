%include "stud_io.inc"
global _start

section .text
_start:     xor ebx, ebx        ; clear the left parenthesis counter
            xor ecx, ecx        ; clear the right parenthesis counter
            xor edx, edx        ; balance is maintained
char:       GETCHAR             ;
            cmp al, -1          ; char == eof
            je finish           ; go to finish
            cmp al, 10          ; char == \n
            je line             ; go to line
            cmp al, '('         ; char != '('
            jne right           ; go to right
            inc ebx             ; ebx++
            jmp char            ; go to next char
right:      cmp al, ')'         ; char != ')'
            jne char            ; go to next char
            inc ecx             ; ecx++
            cmp ebx, ecx        ; ebx >= ecx - '(' >= ')'
            jnb char            ; go to next char
            mov edx, 1          ; balance is not maintained
            jmp char            ; go to next char
line:       sub ebx, ecx        ; ebx == ecx -> ebx == 0
            or edx, ebx         ; edx == ebx == 0 -> balance is maintained
            jnz false           ;
            PRINT "YES"         ;
            jmp new_line        ; clear
false:      PRINT "NO"          ;
new_line:   xor ebx, ebx        ; clear the left parenthesis counter
            xor ecx, ecx        ; clear the right parenthesis counter
            xor edx, edx        ; balance is maintained
            PUTCHAR 10          ; print('\n')
            jmp char            ; go to next char
finish:     FINISH              ;
