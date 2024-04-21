#!/bin/sh

IN_DIR=$1
OUT_DIR=$2

for i in $(seq 1 22)
do
    e=$(wc -l < "$IN_DIR/errors/$i")
    if [ "$e" -ne "0" ];
        then
            echo "Query $i has an error!"
        else
            d=$(diff "$IN_DIR/results/$i" "$OUT_DIR/results/$i" | wc -l)
            if [ "$d" -ne "0" ]; then
                echo "Query $i outputs do not match!"
            fi;
    fi;
done;