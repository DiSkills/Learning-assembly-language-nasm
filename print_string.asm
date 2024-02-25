%include "stud_io.inc"
global print_string


section .text
; print_string(адрес начала строки, длина строки)
print_string: ; вывод строкового представления числа
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека

        push esi                ; сохраняем esi
        push ecx                ; сохраняем ecx

        mov ecx, [ebp + 8]      ; в ecx длина строки
        mov esi, [ebp + 12]     ; в esi адрес начала строки

.lp:
        PUTCHAR byte [esi]      ; печатаем текущий символ
        inc esi                 ; увеличиваем адрес
        loop .lp                ; повторяем ecx раз

.quit:
        pop ecx                 ; восстанавливаем ecx
        pop esi                 ; восстанавливаем esi
        
        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 8                   ; возвращаем управление и очищаем стек
                                ; ничего не возвращаем
