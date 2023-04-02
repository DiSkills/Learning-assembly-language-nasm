%include "stud_io.inc"
global _start

section .bss
digits resb 10

section .text
_start:     xor ebx, ebx        ; clear chars count

char:
            GETCHAR             ;
            cmp al, -1          ; char == eof
            je convert          ; go to convert
            inc ebx             ; count char++
            jmp char            ; go to next char
convert:
            xor ecx, ecx        ; clear count digits
            mov eax, ebx        ; copy number to eax
            mov esi, digits     ; copy address
            mov ebx, 10         ; current number system
digit:
            xor edx, edx        ; clear remainder
            div ebx             ; eax / ebx
            add edx, '0'        ; edx += ord('0')
            mov [esi + 1 * ecx], edx ; added last digit
            inc ecx             ; count digits++
            cmp eax, 0          ; eax != 0
            jne digit           ; go to next digit

output:     jecxz finish        ; ecx == 0 -> go to finish
print:
            PUTCHAR [esi + 1 * ecx - 1] ; print(current digit)
            loop print          ; repeat print
            PUTCHAR 10          ; print('\n')

finish:     FINISH              ;
