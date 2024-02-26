%include "stud_io.inc"
global _start                   ; делаем точку входа глобальной

extern input_number             ; подключаем ввод
extern convert_number_to_string ; подключаем вывод
extern print_string


section .bss
string resb 11
number resd 1


section .data
max_length dd 11


section .text
_start:
        push dword number
        call input_number
        
        nop
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
