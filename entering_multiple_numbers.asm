%include "stud_io.inc"
global _start

section .data
space db ' '
end_line db 10
number dd 0
quantity dd 2
number_system dd 10

section .bss
numbers resd 2
separators resb 2

section .text
_start:
            mov esi, separators
            mov al, [space]
            mov ecx, [quantity]
add_separator:
            mov [esi + ecx * 1 - 1], al
            loop add_separator
last_separator:
            mov al, [end_line]
            mov [esi], al
input_numbers:
            mov edi, numbers
            mov ecx, [quantity]
input:
            mov dword [number], 0
            mov ebx, -1
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
            cmp ebx, -1
            je error
            add eax, '0'
            cmp [esi + ecx * 1 - 1], al
            jne error
            mov eax, [number]
            mov [edi + ecx * 4 - 4], eax
            loop input
success:
            PRINT "Success"
            jmp finish
error:
            PRINT "Error"
finish:     PUTCHAR 10
            FINISH
