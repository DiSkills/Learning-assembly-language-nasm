#!/bin/bash

nasm -f elf stars.asm
ld -m elf_i386 stars.o -o stars

while read char result; do
    res=`echo $char | ./stars`

    if [ x"$result" != x"$res" ]; then
        echo "TEST $char FAILED: expected $result, got $res"
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
    a
    b
    c
    d
    e
    f
    g
    h
    i
    j
    k
    l
    m
    n
    o
    p
    q
    r
    s
    t
    u
    v
    w
    x
    y
    z
    A
    B
    C
    D
    E
    F
    G
    H
    I
    J
    K
    L
    M
    N
    O
    P
    Q
    R
    S
    T
    U
    V
    W
    X
    Y
    Z
    !
    "
    #
    $
    %
    &
    '
    (
    )
    *
    +
    ,
    -
    .
    /
    :
    ;
    <
    =
    >
    ?
    @
    [
    \
    ]
    ^
    _
    \`
    {
    |
    }
    ~
END

rm stars.o stars
