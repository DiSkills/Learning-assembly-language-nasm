%include "stud_io.inc"
global _start

section .text
_start:     xor ebx, ebx        ; clear current length
            xor ecx, ecx        ; clear last length
char:       GETCHAR             ;
            cmp al, -1          ; char == eof
            je finish           ; go to finish
            cmp al, ' '         ; char == space
            je space            ; go to space
            cmp al, 10          ; char == \n
            je line             ; go to line
            inc ebx             ; char not in (' ', eof, '\n') -> ebx++
            jmp char            ; go to next char
space:      cmp ebx, 0          ; ebx == 0
            je char             ; go to next char
            mov ecx, ebx        ; ecx = ebx (last word)
            xor ebx, ebx        ; clear current length
            jmp char            ; go to next char
line:       cmp ebx, 0          ; ebx == 0
            je output           ; go to _
            mov ecx, ebx        ; ecx = ebx (last word)
            xor ebx, ebx        ; clear current length
output:     jecxz char          ; length last word == 0 -> go to next char (line)
star:       PRINT "*"           ;
            loop star           ; print next star
            PUTCHAR 10          ; print('\n')
            jmp char            ; go to next char (line)
finish:     FINISH
