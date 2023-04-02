#!/bin/bash

nasm -f elf print_number.asm
ld -m elf_i386 print_number.o -o print_number

while read input output; do
    if [ x"$input" == x"\\0" ]; then
        input=""
    fi

    result=`echo -n "$input" | ./print_number`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    * 1
    ** 2
    *** 3
    **** 4
    ***** 5
    ****** 6
    ******* 7
    ******** 8
    ********* 9
    ********** 10
    *********** 11
    **\ ************************************************************************************************************* 112
    \\\0 0
END

rm print_number.o print_number
