%include "function_macros.inc"


global convert_to_number


section .text
; convert_to_number(адрес начала строки, длина строки)
; -> eax - знаковое или беззнаковое число
convert_to_number: ; перевод строкового представления числа в число
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека
        sub esp, 4              ; number_system
        mov dword [local(1)], 10; number_system = 10

        push esi                ; сохраняем esi
        push ecx                ; сохраняем ecx
        push edx                ; сохраняем edx
        push ebx                ; сохраняем ebx

        mov esi, [arg(1)]       ; в esi адрес начала строки
        mov ecx, [arg(2)]       ; в ecx длина строки

        inc esi                 ; esi += 1, т. к. первый разряд - знак
        dec ecx                 ; ecx -= 1

        xor ebx, ebx            ; очищаем ebx для текущей цифры
        xor eax, eax            ; очищаем eax для результата

.lp: ; перевод строки в беззнаковое число
        mov bl, [esi]           ; получаем текущую цифру в символьном виде
        sub bl, '0'             ; преобразуем в цифру

        mul dword [local(1)]    ; eax *= 10
        add eax, ebx            ; добавляем текущую цифру

        inc esi                 ; увеличиваем адрес строки
        loop .lp                ; продолжаем переводить строку в число

; переводим число в знаковый вид
        mov esi, [arg(1)]       ; в esi адрес начала строки
        cmp byte [esi], '-'     ; число отрицательное?
        jne .quit               ; если неотрицательное, то уже преобразовано
; если отрицательное, то приводим его к нужному виду
        neg eax                 ; eax = -eax

.quit: ; завершение п/программы
        pop ebx                 ; восстанавливаем ebx
        pop edx                 ; восстанавливаем edx
        pop ecx                 ; восстанавливаем ecx
        pop esi                 ; восстанавливаем esi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret                     ; возвращаем управление
