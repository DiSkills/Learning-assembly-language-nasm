#!/bin/bash

nasm -f elf last_word_length.asm
ld -m elf_i386 last_word_length.o -o last_word_length

while read input output; do
    result=`echo $input | ./last_word_length`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    2356121\ 2\ 1\ 30 **
    \ \ \ \ \ 5 *
    56\ \ \ \ \ = *
    .f\ \ \ \ \ \  **
    \ \ \ \ \ \ \ 

    \ \ \ cvf\ \ \  ***
END

rm last_word_length.o last_word_length
