%include "stud_io.inc"
global _start

section .data
; CONSTS
END_LINE db 10
END_FILE db -1

section .text
_start:
        mov al, [END_LINE]        ; move \n to al
        push eax                  ; move \n to stack
        mov ecx, 1                ; ecx = 1 (\n)
.lp:    ; input string
        GETCHAR                   ; read char
        cmp al, [END_LINE]        ; char is \n?
        je finish                 ; if true, then complete input
        cmp al, [END_FILE]        ; char is eof?
        je finish                 ; if true, then complete input
        push eax                  ; char not in (\n, eof) -> move to stack
        inc ecx                   ; ecx += 1
        jmp .lp                   ; repeat
finish: ; print reverse string
.lp:    ; number of chars in ecx
        pop eax                   ; pop char from stack
        PUTCHAR al                ; print char
        loop .lp                  ; repeat ecx times
        FINISH                    ; finish
