#!/bin/bash

filename="sum_difference_product_of_2_numbers"

nasm -f elf $filename.asm
ld -m elf_i386 $filename.o -o $filename

while read input output; do
    result=`echo "$input" | ./$filename`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    0\ 0 0\ 0\ 0
    76\ 25 101\ 51\ 1900
    57\ 89 146\ 4294967264\ 5073
    4294967296\ 4 4\ 4294967292\ 0
    4294967300\ 7 11\ 4294967293\ 28
    4294967295\ 1 0\ 4294967294\ 4294967295
    - Error
    57f Error
    7f83 Error
    832\ 8f Error
    931\ qf Error
    8563\ 8953\  Error
END

rm $filename.o $filename
