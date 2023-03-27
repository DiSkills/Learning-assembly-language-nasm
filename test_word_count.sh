#!/bin/bash

nasm -f elf word_count.asm
ld -m elf_i386 word_count.o -o word_count

while read input output; do
    result=`echo $input | ./word_count`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    Hello,\ World! **
    Hello.\ How\ are\ you\ doing? *****
    I\ am\ learning\ assembly\ \ \ \ language\ \ \ \ \  *****
    \ \ \ \ \ \ \ Tests\ \ \ \ \ are\ everything!\  ***
END

rm word_count.o word_count
