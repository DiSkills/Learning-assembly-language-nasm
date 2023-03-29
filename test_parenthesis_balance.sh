#!/bin/bash

nasm -f elf parenthesis_balance.asm
ld -m elf_i386 parenthesis_balance.o -o parenthesis_balance

while IFS="|" read input output; do
    result=`echo "$input" | ./parenthesis_balance`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
5689874(123)()()()((()))l;|YES
(((((((())))))))()(())|YES
)()()()(|NO
)(())))|NO
(((((())(|NO
f|YES
(|NO
)|NO
END

rm parenthesis_balance.o parenthesis_balance
