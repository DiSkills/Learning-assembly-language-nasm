; системный вызов с 1 параметром
%macro _syscall1 2
    push ebx                    ; сохраняем ebx

    mov ebx, %2                 ; передаём 1 параметр
    mov eax, %1                 ; передаём код системного вызова
    int 80h                     ; вызов ОС

    pop ebx                     ; восстанавливаем ebx
%endmacro


; системный вызов с 2 параметрами
%macro _syscall2 3
    push ecx                    ; сохраняем ecx

    mov ecx, %3                 ; передаём 2 параметр
    _syscall1 %1, %2            ; используем системный вызов с 1 параметром

    pop ecx                     ; восстанавливаем ecx
%endmacro


; системный вызов с 3 параметрами
%macro _syscall3 4
    push edx                    ; сохраняем edx

    mov edx, %4                 ; передаём 3 параметр
    _syscall2 %1, %2, %3        ; используем системный вызов с 2 параметрами

    pop edx                     ; восстанавливаем edx
%endmacro


; системный вызов (код, параметры [1-3])
%macro scall 2-4
    %if %0 == 2
        _syscall1 %1, %2
    %elif %0 == 3
        _syscall2 %1, %2, %3
    %else
        _syscall3 %1, %2, %3, %4
    %endif
%endmacro
