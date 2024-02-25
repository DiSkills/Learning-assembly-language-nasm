%include "stud_io.inc"
global _start                   ; делаем точку входа глобальной

extern input_string             ; подключаем ввод
extern convert_string_to_number ;
extern convert_number_to_string ; подключаем вывод
extern print_string


section .bss
string resb 11
number resd 1


section .data
max_length dd 11


section .text
_start:
        push dword string
        push dword [max_length]
        call input_string

        push dword string
        push eax
        call convert_string_to_number

        mov [number], eax
; output
        push dword [number]
        push dword string
        call convert_number_to_string

        push dword string
        push ecx
        call print_string
        PUTCHAR 10
finish:
        FINISH
