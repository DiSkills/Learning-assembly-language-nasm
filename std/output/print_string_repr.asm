%include "stud_io.inc"
%include "function_macros.inc"


global print_string_repr


section .text
; print_string_repr(адрес начала строки, длина строки)
print_string_repr: ; вывод строкового представления числа
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека

        push esi                ; сохраняем esi
        push ecx                ; сохраняем ecx

        mov esi, [arg(1)]       ; в esi адрес начала строки
        mov ecx, [arg(2)]       ; в ecx длина строки

; выводить знак или нет?
        cmp byte [esi], '+'     ; знак - '+'?
        jne .lp                 ; если нет, то знак выводим

; если число положительное, то знак не выводим
        inc esi                 ; увеличиваем esi
        dec ecx                 ; уменьшаем количество символов для вывода

.lp: ; вывод строки по-символьно
        PUTCHAR byte [esi]      ; вывести текущий символ
        inc esi                 ; увеличиваем адрес
        loop .lp                ; продолжаем выводить

.quit: ; завершение п/программы
        pop ecx                 ; восстанавливаем ecx
        pop esi                 ; восстанавливаем esi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret                     ; возвращаем управление
