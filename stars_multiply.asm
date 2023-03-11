%include "stud_io.inc"
global _start

section .text
_start: xor ebx, ebx        ; clear ebx (counter '-')
        xor ecx, ecx        ; clear ecx (counter '+')
input:  GETCHAR             ;
        cmp al, -1          ; if char == Ctrl-D -> print
        je print            ;
        cmp al, 10          ; if char == \n -> print
        je print            ;
plus:   cmp al, '+'         ; if char != '+' -> jump
        jne dash            ;
        inc ecx             ; ecx += 1
        jmp end             ; next char
dash:   cmp al, '-'         ; if char != '-' -> jump
        jne end             ;
        inc ebx             ; ebx += 1
end:    jmp input           ; jump input
print:  mov eax, ebx        ; copy ebx -> eax
        mul ecx             ; eax * ecx
        jnc success         ; if not carry -> print stars
        PRINT "Too much '+/-'"
        PUTCHAR 10          ; print('\n')
        jmp finish          ; if carry -> exit
success:
        mov ecx, eax        ; copy eax -> ecx
        jecxz finish        ; if ecx == 0 -> finish
star:   PRINT '*'           ; print('*')
        loop star           ;
        PUTCHAR 10          ; print('\n')
finish: FINISH
