#!/bin/bash

nasm -f elf words_in_brackets.asm
ld -m elf_i386 words_in_brackets.o -o words_in_brackets

while IFS="|" read input output; do
    result=`echo "$input" | ./words_in_brackets`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
Hello,\ World!|(Hello,)\ (World!)
Hello.\ How\ are\ you\ doing?|(Hello.)\ (How)\ (are)\ (you)\ (doing?)
I\ am\ learning\ assembly\ \ \ \ language\ \ \ \ |(I)\ (am)\ (learning)\ (assembly)\ \ \ \ (language)\ \ \ \ 
\ \ \ \ \ \ \ Tests\ \ \ \ \ are\ everything!\ |\ \ \ \ \ \ \ (Tests)\ \ \ \ \ (are)\ (everything!)\ 
END

rm words_in_brackets.o words_in_brackets
