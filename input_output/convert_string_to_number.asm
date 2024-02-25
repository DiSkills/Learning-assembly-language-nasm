global convert_string_to_number


section .text
; convert_string_to_number(адрес строки, длина строки)
; -> eax - число, ecx - код завершения (1 - ошибка, 0 - успех)
convert_string_to_number: ; конвертация строки в число
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека
        sub esp, 4              ; создаём переменную number_system
        mov dword [ebp - 4], 10 ; помещаем в неё 10

        push esi                ; сохраняем esi
        push edx                ; сохраняем edx
        push ebx                ; сохраняем ebx

        mov ecx, [ebp + 8]      ; в ecx количество цифр
        mov esi, [ebp + 12]     ; в esi адрес начала строки

        xor ebx, ebx            ; очищаем ebx для текущей цифры
        xor eax, eax            ; очищаем eax для результата

.lp:
        mov bl, [esi]           ; кладём в bl текущий символ
        sub bl, '0'             ; вычитаем код нуля (преобразуем в цифру)
        cmp bl, 9               ; текущий символ - цифра?
        jnbe .error             ; если не цифра, то ошибка
        mul dword [ebp - 4]     ; eax *= 10
        add eax, ebx            ; добавляем текущую цифру
        inc esi                 ; увеличиваем адрес
        loop .lp                ; повторяем ecx раз
        jmp .quit               ; завершаем конвертацию числа

.error: ; символ не является цифрой
        mov ecx, 1              ; произошла ошибка конвертации
.quit:
        pop ebx                 ; восстанавливаем ebx
        pop edx                 ; восстанавливаем edx
        pop esi                 ; восстанавливаем esi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 8                   ; возвращаем управление и очищаем стек
                                ; если произошла ошибка, то ecx=1
                                ; иначе число в eax, ecx=0
