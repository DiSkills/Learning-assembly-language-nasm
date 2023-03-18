#!/bin/bash

nasm -f elf stars_sum.asm
ld -m elf_i386 stars_sum.o -o stars_sum

while read string result; do
    res=`echo $string | ./stars_sum`

    if [ x"$result" != x"$res" ]; then
        echo "TEST '$string' FAILED: expected '$result', got '$res'"
    fi
done <<END
    +++
    -+jlkfd
    5 *****
    0
    032f1 ******
    flsa;8fkj ********
END

rm stars_sum.o stars_sum
