%include "stud_io.inc"
global _start

section .data
; CONSTS
END_LINE db 10
END_FILE db -1

section .text
_start:
        mov al, [END_LINE]        ; кладём в al \n
        push eax                  ; заносим \n в стек
        mov ecx, 1                ; уже один символ есть
.lp:
        GETCHAR                   ; считываем символ
        cmp al, [END_LINE]        ; символ \n?
        je finish                 ; если да, то прыгаем
        cmp al, [END_FILE]        ; символ eof?
        je finish                 ; если да, то прыгаем
        push eax                  ; иначе заносим символ в стек
        inc ecx                   ; увеличиваем количество символов в строке
        jmp .lp                   ; повторяем
finish:
.lp:
        pop eax                   ; считываем символ
        PUTCHAR al                ; выводим его
        loop .lp                  ; повторяем ecx раз
        FINISH                    ; завершаем программу
