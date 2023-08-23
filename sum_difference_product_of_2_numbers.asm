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
        mov [separators + ecx * 1 - 1], al ; add the current separator
        loop add_separator
changing_last_separator:
        mov al, [end_line]           ; last separator by default is <CR>
        mov [separators], al         ; change the last separator

getting_input_data:
        mov ecx, [input_size]        ; number of input data
number_entry:
        cmp ecx, 0                   ; if the numbers are entered
        je number_processing         ; proceed to processing
        mov [number], dword 0        ; number by default is 0
        mov ebx, [undefined]         ; current digit by default is undefined
character_processing:
        GETCHAR                      ; character read
        sub al, [zero]               ; subtract zero code from character
        cmp eax, 9                   ; if the character is not a digit
        jnbe processing_not_a_number ; then we treat it as not a number
        mov ebx, eax                 ; save the current digit
        mov eax, [number]            ; current number
        mul dword [number_system]    ; multiply by number system
        add eax, ebx                 ; add with the current digit
        mov [number], eax            ; save the current number
        jmp character_processing     ; process the next character
processing_not_a_number:
        cmp ebx, [undefined]         ; if there were no digits
        je error_output              ; then throw an error
        add al, [zero]               ; add zero code to get character
        cmp [separators + ecx * 1 - 1], al ; if the character is not a separator
        jne error_output             ; then throw an error
        mov eax, [number]            ; current number
        mov [input_data + ecx * 4 - 4], eax ; save the current number
        dec ecx                      ; one number entered
        jmp number_entry             ; process the next number

number_processing:
        mov eax, [input_data + 4]    ; get the first number
        mov [number], eax            ; save the first number
        mov eax, [input_data]        ; get the second number
        mov [number2], eax           ; save the second number
getting_amount:
        add eax, [number]            ; number2 + number1
        mov [output_data + 2 * 4], eax ; save the sum of numbers
getting_difference:
        mov eax, [number]            ; get the first number
        sub eax, [number2]           ; number1 - number2
        mov [output_data + 1 * 4], eax ; save the difference of numbers
getting_product:
        mov eax, [number]            ; get the first number
        mul dword [number2]          ; number1 * number2
        mov [output_data], eax       ; save the product of numbers

output:
        mov ecx, [output_size]       ; number of output data
number_output:
        xor ebx, ebx                 ; clear the number of digits
        mov eax, [output_data + ecx * 4 - 4] ; get the current number
digit_processing:
        xor edx, edx                 ; clear the current discharge
        div dword [number_system]    ; get the last digit of a number
        add dl, [zero]               ; add zero code to get character
        mov [digits + ebx * 1], dl   ; save the current digit
        inc ebx                      ; increase the number of digits
        cmp eax, 0                   ; if there are still digits
        jne digit_processing         ; then process the next digit
print_digit:
        PUTCHAR [digits + ebx * 1 - 1] ; output the current digit
        dec ebx                      ; another digit of the number printed
        cmp ebx, 0                   ; if not all digits are printed yet
        jne print_digit              ; then output the following
next_number:
        dec ecx                      ; one number out
        jecxz finish                 ; if the numbers are out, then finish the job
        PUTCHAR [space]              ; output space (separator)
        jmp number_output            ; output the next number
error_output:
        PRINT "Error"
finish:
        PUTCHAR [end_line]           ; line break output
        FINISH
