#!/bin/bash

nasm -f elf length_star.asm
ld -m elf_i386 length_star.o -o length_star

while read input output; do
    result=`echo $input | ./length_star`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    
    12356 *****
    012356 ******
    .-+012. *******
    kjdf ****
    8 *
END

rm length_star.o length_star
