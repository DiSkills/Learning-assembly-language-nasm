#!/bin/bash

filename=input_number

nasm -f elf input_number_in_string_repr.asm
nasm -f elf convert_string_to_number.asm
nasm -f elf convert_number_to_string.asm
nasm -f elf print_string.asm
nasm -f elf $filename.asm
ld -m elf_i386 *.o -o $filename

while read input output; do
    result=`echo "$input" | ./$filename`

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
END

rm *.o $filename
