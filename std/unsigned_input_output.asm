%include "stud_io.inc"
%include "function_macros.inc"


global _start                   ; делаем точку входа глобальной

extern input_number             ; подключаем ввод
extern output_number            ; подключаем вывод


section .bss
number resd 1


section .text
_start:
; input
        pcall input_number, number
; output
        push dword [number]
        call output_number
finish:
        PUTCHAR 10
        FINISH
