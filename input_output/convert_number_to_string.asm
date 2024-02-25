global convert_number_to_string


section .text
; convert_number_to_string(число, адрес начала строки)
; -> ecx - количество разрядов числа
convert_number_to_string: ; конвертация числа в строку
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека
        sub esp, 4              ; создаём переменную number_system
        mov dword [ebp - 4], 10 ; помещаем в неё 10

        push edi                ; сохраняем edi
        push eax                ; сохраняем eax
        push edx                ; сохраняем edx

        mov edi, [ebp + 8]      ; в edi адрес начала строки
        mov eax, [ebp + 12]     ; в eax число

        xor ecx, ecx            ; очищаем количество символов в строке

.lp: ; получаем разряды числа, сохраняем их в стек
        xor edx, edx            ; очищаем edx для деления
        div dword [ebp - 4]     ; eax / 10
        add edx, '0'            ; добавляем код нуля (преобразуем в символ)
        push edx                ; сохраняем текущую цифру в стек
        inc ecx                 ; увеличиваем количество цифр в строке
        test eax, eax           ; есть ещё цифры в eax?
        jnz .lp                 ; если есть, то повторяем

        mov edx, ecx            ; копируем количество цифр
        cld                     ; строковые операции в прямом направлении

.lp2: ; сохраняем число в память
        pop eax                 ; считываем текущую цифру из стека
        stosb                   ; записываем её в строку
        loop .lp2               ; повторяем, пока цифры не кончились

        mov ecx, edx            ; восстанавливаем количество цифр в ecx

.quit:
        pop edx                 ; восстанавливаем edx
        pop eax                 ; восстанавливаем eax
        pop edi                 ; восстанавливаем edi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 8                   ; возвращаем управление и очищаем стек
                                ; число записано по переданному адресу
                                ; ecx=количеству разрядов числа
