%include "stud_io.inc"
global _start

section .text
_start:     xor ebx, ebx        ; clear current length
            xor ecx, ecx        ; clear maximum length
input:      GETCHAR             ; input char
            cmp al, -1          ; if end of file
            je finish           ; go to finish
            cmp al, ' '         ; if space
            je max              ; go to max
            cmp al, 10          ; if \n
            je max              ; go to max
            inc ebx             ; if char not in (' ', '\n', eof) then ebx += 1
            jmp input           ; go to next char
max:        cmp ebx, ecx        ; if ebx <= ecx
            jna say             ; go to next word
            mov ecx, ebx        ; if ebx > ecx then ecx = ebx
say:        xor ebx, ebx        ; clear current length
line:       cmp al, 10          ; if not new line
            jne input           ; go to next char
            jecxz input         ; if ecx == 0 -> go to next char
lp:         PRINT "*"           ; print stars
            loop lp             ;
            PUTCHAR 10          ; print('\n')
            jmp input           ; go to next char
finish:     FINISH              ; finish
