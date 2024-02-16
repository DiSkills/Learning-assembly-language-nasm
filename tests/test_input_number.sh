#!/bin/bash

nasm -f elf input_number.asm
ld -m elf_i386 input_number.o -o input_number

while read input output; do
    result=`echo "$input" | ./input_number`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    0
    1 *
    2 **
    3 ***
    4 ****
    5 *****
    6 ******
    7 *******
    8 ********
    9 *********
    10 **********
    22 **********************
    5f *****
END

rm input_number.o input_number
