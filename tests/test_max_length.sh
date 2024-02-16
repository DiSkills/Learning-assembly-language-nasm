#!/bin/bash

nasm -f elf max_length.asm
ld -m elf_i386 max_length.o -o max_length

while IFS="|" read input output; do
    result=`echo "$input" | ./max_length`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
2356\ 23541\ fda\ \ \ \ \ 2574123356|**********
23\ \ \ \ \ \ \ \ \ \ 00\ 578\ \ \ \ \ .036985|*******
\ \ \ \ \ \ \ \ 23\ \ \ 2|**
001\ \ \ \ \ \ \ \ \ \ \ 2522\ \ \ \ \ \ \ \ |****
32|**

\ \ \ \ 
2\ 1\ \ \ 2\ \ \ 3|*
END

rm max_length.o max_length
