%include "stud_io.inc"
global _start


section .data
; chars
space db ' '
end_line db 10

; default values
undefined dd -1
number_system dd 10

; numbers
number dd 0
number2 dd 0

; data size
input_size dd 2
output_size dd 3


section .bss
; chars
digits resb 10
separators resb 2

result resd 3
numbers resd 2


section .text
_start:
        mov esi, separators
        mov al, [space]
        mov ecx, [input_size]
add_separator:
        mov [esi + ecx * 1 - 1], al
        loop add_separator
last_separator:
        mov al, [end_line]
        mov [esi], al
input_numbers:
        mov edi, numbers
        mov ecx, [input_size]
input:
        mov dword [number], 0
        mov ebx, [undefined]
char:
        GETCHAR
        sub eax, '0'
        cmp eax, 9
        jnbe not_a_number
        mov ebx, eax
        mov eax, [number]
        mul dword [number_system]
        add eax, ebx
        mov [number], eax
        jmp char
not_a_number:
        cmp ebx, [undefined]
        je error
        add eax, '0'
        cmp [esi + ecx * 1 - 1], al
        jne error
        mov eax, [number]
        mov [edi + ecx * 4 - 4], eax
        loop input
get_indexes:
        mov esi, numbers
        mov edi, result
get_numbers:
        mov eax, [esi + 4]
        mov [number], eax
        mov eax, [esi]
        mov [number2], eax
sum:
        add eax, [number]
        mov [edi + 2 * 4], eax
difference:
        mov eax, [number]
        sub eax, [number2]
        mov [edi + 1 * 4], eax
product:
        mov eax, [number]
        mul dword [number2]
        mov [edi], eax
output:
        mov esi, result
        mov edi, digits
        mov ecx, [output_size]
print_number:
        xor ebx, ebx
        mov eax, [esi + ecx * 4 - 4]
digit:
        xor edx, edx
        div dword [number_system]
        add edx, '0'
        mov [edi + ebx * 1], dl
        inc ebx
        cmp eax, 0
        jne digit
print:
        PUTCHAR [edi + ebx * 1 - 1]
        dec ebx
        cmp ebx, 0
        jne print
next:
        PUTCHAR [space]
        loop print_number
        jmp finish
error:
        PRINT "Error"
finish:     PUTCHAR [end_line]
        FINISH
