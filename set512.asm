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
        and cl, 11111b                ; ebx % 32
        mov eax, 1                    ;
        shl eax, cl                   ; create mask
        mov edx, ebx                  ;
        shr edx, 5                    ; ebx // 32
        or [set512 + 4 * edx], eax    ; apply mask

; count items
        xor ebx, ebx                  ; counter = 0
        mov ecx, 15                   ; last index
lp:     mov eax, [set512 + 4 * ecx]   ; load item
digit:  test eax, 1                   ; last digit is 1?
        jz notone                     ; false -> jump
        inc ebx                       ; true -> ebx++
notone: shr eax, 1                    ; shift right
        test eax, eax                 ; eax is empty?
        jnz digit                     ; true -> jump

        jecxz quit                    ; loop has been ended
        dec ecx                       ;
        jmp lp                        ;

quit:

; remove from set512
        mov cl, bl
        and cl, 11111b                ; ebx % 32
        mov eax, 1                    ;
        shl eax, cl                   ; create mask
        not eax                       ; reverse
        mov edx, ebx                  ;
        shr edx, 5                    ; ebx // 32
        and [set512 + 4 * edx], eax   ; apply mask

; exists
        mov cl, bl
        and cl, 11111b                ; ebx % 32
        mov eax, 1                    ;
        shl eax, cl                   ; create mask
        mov edx, ebx                  ;
        shr edx, 5                    ; ebx // 32
        test [set512 + 4 * edx], eax  ; apply mask
