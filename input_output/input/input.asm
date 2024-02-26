global input_number

extern input_string_repr
extern convert_to_number


section .text
; input_number(адрес памяти для записи числа)
input_number: ; считывает число и записывает по переданному адресу
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека
        sub esp, 12             ; строка для строкового представления

        push edi                ; сохраняем edi
        push eax                ; сохраняем eax
        push ecx                ; сохраняем ecx

        mov edi, ebp            ; в edi адрес строки
        sub edi, 12             ; ставим edi на начало
; вводим строковое представление числа
        push edi                ; передаём адрес строки для строкового представления
        push dword 12           ; длина строки = 12
        call input_string_repr  ; получаем строковое представление
; переводим строковое представление в число
        push edi                ; передаём адрес строкового представления числа
        push eax                ; передаём длину строки
        call convert_to_number  ; переводим строку в число

        mov edi, [ebp + 8]      ; в edi адрес области памяти для записи числа
        mov [edi], eax          ; записываем число

.quit: ; завершение п/программы
        pop ecx                 ; восстанавливаем ecx
        pop eax                 ; восстанавливаем eax
        pop edi                 ; восстанавливаем edi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 4                   ; возвращаем управление
