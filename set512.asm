section .bss
set512  resd 16

section .text
        xor eax, eax
        mov ecx, 16
        mov esi, set512
lp:     mov [esi + 4 * ecx - 4], eax
        loop lp

; add to set512 from ebx
        mov cl, bl
        and cl, 11111b
        mov eax, 1
        shl eax, cl
        mov edx, ebx
        shr edx, 5
        or [set512 + 4 * edx], eax
