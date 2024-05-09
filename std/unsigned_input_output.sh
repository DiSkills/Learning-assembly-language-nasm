#!/bin/bash

filename=$1

while read input output; do
    result=`echo "$input" | ./$filename`

    if [ x"$output" != x"$result" ]; then
        echo "TEST '$input' FAILED: expected '$output', got '$result'"
    fi
done <<END
    0 0
    -1000 4294966296
    109 109
    +888 888
    1980198 1980198
    -89 4294967207
    4294967207 4294967207
    8933 8933
    84573 84573
    -9783 4294957513
END
