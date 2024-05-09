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
        push edi                ; передаём адрес строки для строкового представления
        push dword [ebp + 8]    ; передаём число
        call dword [ebp + 12]   ; вызываем п/программу для конвертации вывода
; выводим строковое представление числа
        push edi                ; передаём адрес строкового представления числа
        push eax                ; передаём длину строки
        call print_string_repr  ; вызываем п/программу вывода

.quit: ; завершение п/программы
        pop eax                 ; восстанавливаем eax
        pop edi                 ; восстанавливаем edi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 8                   ; возвращаем управление с очисткой стека


; output_number(число)
output_number: ; вывод беззнакового числа
        push dword convert_to_string ; передаём п/программу вывода
        push dword [esp + 8]    ; передаём число
        call _output_number     ; вызываем вывод
        ret 4                   ; возвращаем управление с очисткой стека


; ioutput_number(число)
ioutput_number: ; вывод знакового числа
        push dword iconvert_to_string ; передаём п/программу вывода
        push dword [esp + 8]    ; передаём число
        call _output_number     ; вызываем вывод
        ret 4                   ; возвращаем управление с очисткой стека
