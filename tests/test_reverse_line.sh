#!/bin/bash

filename=reverse_line

nasm -f elf $filename.asm
ld -m elf_i386 $filename.o -o $filename

while read input output; do
    result=`echo "$input" | ./$filename`

    if [ x"$output" != x"$result" ]; then
        echo "[-] TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    abcdae eadcba
    jfkdaljlfkajfakdl ldkafjakfljladkfj
END

rm $filename.o $filename
