%include "stud_io.inc"
global _start                   ; делаем точку входа глобальной

extern input_number             ; подключаем ввод
extern ioutput_number           ; подключаем вывод


section .bss
number resd 1


section .text
_start:
; input
        push dword number
        call input_number
; output
        push dword [number]
        call ioutput_number
finish:
        PUTCHAR 10
        FINISH
