%include "stud_io.inc"
global _start
extern input_string
extern convert_string_to_number

section .bss
string resb 11

section .data
max_length dd 11
number dd 0

section .text
_start:
        push dword string
        push dword [max_length]
        call input_string

        push dword string
        push eax
        call convert_string_to_number
        mov [number], eax
print:
        mov ecx, [number]       ; ecx = number
        jecxz finish            ; ecx == 0 -> go to finish
.lp:
        PUTCHAR '*'             ; print('*')
        loop .lp
        PUTCHAR 10
finish:
        FINISH
