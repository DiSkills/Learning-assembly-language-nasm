%macro _syscall1 2
    push ebx

    mov ebx, %2
    mov eax, %1
    int 80h

    pop ebx
%endmacro


%macro _syscall2 3
    push ecx

    mov ecx, %3
    _syscall1 %1, %2

    pop ecx
%endmacro


%macro _syscall3 4
    push edx

    mov edx, %4
    _syscall2 %1, %2, %3

    pop edx
%endmacro


%macro scall 2-4
    %if %0 == 2
        _syscall1 %1, %2
    %elif %0 == 3
        _syscall2 %1, %2, %3
    %else
        _syscall3 %1, %2, %3, %4
    %endif
%endmacro
