%include "stud_io.inc"
global input_string


section .text
; input_string(адрес начала строки, максимальное количество символов)
; -> eax - количество прочитанных символов, ecx - код завершения
; ('код символа' - символ не цифра, '-1' - конец файла,
; '-2' - переполнение, 0 - успех)
input_string: ; ввод числа в строковом представлении
        push ebp                ; сохраняем ebp
        mov ebp, esp            ; ставим ebp на вершину стека

        push edi                ; сохраняем edi

        mov ecx, [ebp + 8]      ; в ecx максимальное количество символов
        mov edi, [ebp + 12]     ; в edi адрес начала строки

        cld                     ; строковые операции в прямом направлении

.lp:
        GETCHAR                 ; считываем символ
        sub al, '0'             ; вычитаем код нуля (преобразуем в цифру)
        cmp al, 9               ; текущий символ - цифра?
        jnbe .not_digit         ; если не цифра, то ошибка
        jecxz .overflow         ; если больше нет места, то переполнение
        dec ecx                 ; уменьшаем максимальное количество
                                ; (считали символ)
        add al, '0'             ; восстанавливаем символ
        stosb                   ; записываем цифру в строку
        jmp .lp                 ; повторяем, пока число не введено до конца

.overflow: ; если цифр больше, чем доступно ячеек для записи
        mov ecx, -2             ; произошла ошибка переполнения
        jmp .quit

.not_digit: ; если введённый символ не цифра
        add al, '0'             ; восстанавливаем его код
        cmp al, 10              ; символ является переносом строки?
                                ; (ввод окончен)
        je .completed           ; если да, то ввод окончен
        cmp al, -1              ; символ является концом файла?
        je .eof                 ; если да, то возник конец файла
        mov ecx, eax            ; возникла ошибка введения числа
        jmp .quit

.completed: ; число введено успешно
        mov eax, [ebp + 8]      ; вычисляем количество введённых символов
        sub eax, ecx            ; (из максимального вычитаем оставшееся)
        xor ecx, ecx            ; число введено успешно
        jmp .quit

.eof: ; если возникла ситуация: конец файла
        mov ecx, -1             ; возникла ошибка конца файла

.quit:
        pop edi                 ; восстанавливаем edi

        mov esp, ebp            ; восстанавливаем esp
        pop ebp                 ; восстанавливаем ebp
        ret 8                   ; возвращаем управление и очищаем стек
                                ; если произошла ошибка, то ecx!=0
                                ; иначе количество прочитанных символов в eax,
                                ; ecx=0
