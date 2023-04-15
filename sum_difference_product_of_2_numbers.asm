%include "stud_io.inc"
global _start


section .data
; chars
zero db '0'
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

; input data
input_data resd 2
; output data
output_data resd 3


section .text
_start:

separators_initialization:
        mov ecx, [input_size]        ; number of separators
        mov al, [space]              ; separator by default is space
add_separator:
        mov [separators + ecx * 1 - 1], al
        loop add_separator
last_separator:
        mov al, [end_line]           ; last separator by default is <CR>
        mov [separators], al         ; changing the last separator

getting_input_data:
        mov ecx, [input_size]        ; number of input data
number_entry:
        cmp ecx, 0                   ; if the numbers are entered
        je get_indexes               ; proceed to processing
        mov [number], dword 0        ; number by default is 0
        mov ebx, [undefined]         ; current digit by default is undefined
character_processing:
        GETCHAR                      ; character reading
        sub al, [zero]               ; subtract zero code from character
        cmp eax, 9                   ; if the character is not a digit
        jnbe processing_not_a_number ; then we treat it as a separator
        mov ebx, eax                 ; save the current digit
        mov eax, [number]            ; current number
        mul dword [number_system]    ; multiply by number system
        add eax, ebx                 ; add with the current digit
        mov [number], eax            ; save the current number
        jmp character_processing     ; process the next character
processing_not_a_number:
        cmp ebx, [undefined]         ; if there were no numbers
        je error                     ; then throw an error
        add al, [zero]               ; add zero code to get character
        cmp [separators + ecx * 1 - 1], al ; if the character is not a separator
        jne error                    ; then throw an error
        mov eax, [number]            ; current number
        mov [input_data + ecx * 4 - 4], eax ; save the current number
        dec ecx                      ; one number entered
        jmp number_entry             ; process the next number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_indexes:
        mov esi, input_data
        mov edi, output_data
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
        mov esi, output_data
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
