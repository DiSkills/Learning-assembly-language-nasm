#!/bin/bash

nasm -f elf stars_multiply.asm
ld -m elf_i386 stars_multiply.o -o stars_multiply

while read string result; do
    res=`echo $string | ./stars_multiply`

    if [ x"$result" != x"$res" ]; then
        echo "TEST '$string' FAILED: expected '$result', got '$res'"
    fi
done <<END
    +++++
    ---
    ffffff
    -++--+ *********
    -++ **
    -+-+- ******
    -+fd+--+ *********
    -++54 **
    !*-+/-+f- ******
END

rm stars_multiply.o stars_multiply
