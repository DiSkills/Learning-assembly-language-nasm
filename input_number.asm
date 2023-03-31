%include "stud_io.inc"
global _start

section .data
number dd 0

section .text
_start:     xor ebx, ebx        ; clear current digit
            mov ecx, 10         ; current number system
char:       GETCHAR             ;
            sub al, '0'         ; char - ord('0')
            cmp al, 9           ; not (char <= 9)
            jnbe print          ; go to print
            mov bl, al          ; current digit
            mov eax, [number]   ; eax = number
            mul ecx             ; eax * current number system
            add eax, ebx        ; eax += ebx
            mov [number], eax   ; number = eax
            jmp char            ; go to next char
print:      mov ecx, [number]   ; ecx = number
            jecxz finish        ; ecx == 0 -> go to finish
star:       PUTCHAR '*'         ; print('*')
            loop star           ;
            PUTCHAR 10          ; print('\n')
finish:     FINISH              ;
