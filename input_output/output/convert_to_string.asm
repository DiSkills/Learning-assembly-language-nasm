global convert_to_string


section .text
; convert_to_string(адрес начала строки, беззнаковое число)
; -> eax - длина строки
convert_to_string: ; перевод беззнакового числа в строковое представление
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека
        sub esp, 4              ; number_system
        mov dword [ebp - 4], 10 ; number_system = 10
        
        push edi                ; сохраняем edi
        push ecx                ; сохраняем ecx
        push edx                ; сохраняем edx

        mov eax, [ebp + 8]      ; в eax число
        mov edi, [ebp + 12]     ; в edi адрес начала строки

        mov byte [edi], '+'     ; число не отрицательное
        inc edi                 ; edi += 1 (знак)
        xor ecx, ecx            ; очищаем длину строки

.lp: ; сохраняем разряды числа в стеке
        xor edx, edx            ; очищаем edx для деления

        div dword [ebp - 4]     ; eax /= 10

        add edx, '0'            ; добавляем код нуля (преобразуем в символ)
        push edx                ; сохраняем текущую цифру в стек
        inc ecx                 ; увеличиваем длину строки

        test eax, eax           ; есть ещё цифры в числе?
        jnz .lp                 ; если есть, то повторяем

; подготовка к записи строкового представления
        mov edx, ecx            ; копируем длину строки
        cld                     ; строковые операции в прямом направлении

.lp2: ; записываем строковое представление числа
        pop eax                 ; считываем текущую цифру из стека
        stosb                   ; записываем её в строку
        loop .lp2               ; повторяем, пока цифры не кончились

.quit: ; завершение п/программы
        mov eax, edx            ; сохраняем в eax длину строки
        inc eax                 ; eax += 1 (знак)

        pop edx                 ; восстанавливаем edx
        pop ecx                 ; восстанавливаем ecx
        pop edi                 ; восстанавливаем edi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 8                   ; возвращаем управление с очисткой стека
