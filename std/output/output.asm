%include "function_macros.inc"


global output_number
global ioutput_number

extern convert_to_string
extern iconvert_to_string
extern print_string_repr


section .text
; _output_number(п/программа вывода, число)
_output_number: ; вывод заданного числа
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека
        sub esp, 12             ; строка для строкового представления

        push edi                ; сохраняем edi
        push eax                ; сохраняем eax

        mov edi, ebp            ; в edi адрес строки
        sub edi, 12             ; ставим edi на начало
; переводим число в строковое представление
        pcall dword [arg(1)], edi, [arg(2)]
; выводим строковое представление числа
        pcall print_string_repr, edi, eax

.quit: ; завершение п/программы
        pop eax                 ; восстанавливаем eax
        pop edi                 ; восстанавливаем edi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret                     ; возвращаем управление


; output_number(число)
output_number: ; вывод беззнакового числа
        pcall _output_number, convert_to_string, [esp + 4]
        ret                     ; возвращаем управление


; ioutput_number(число)
ioutput_number: ; вывод знакового числа
        pcall _output_number, iconvert_to_string, [esp + 4]
        ret                     ; возвращаем управление
