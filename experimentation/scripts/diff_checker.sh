#!/bin/sh

IN_DIR=$1
OUT_DIR=$2

n=$3

nq="1 4 11 74"

for i in $(seq 1 22)
do

    if echo "$nq" | grep -w "$i" > /dev/null; then
        continue;
    fi

    e=$(wc -l < "$IN_DIR/errors/$i")
    if [ "$e" -ne "0" ];
        then
            echo "Query $i has an error!"
        else
            d=$(diff <(tail -n +2 "$IN_DIR/results/$i") <(tail -n +2 "$OUT_DIR/results/$i") | wc -l)
            if [ "$d" -ne "0" ]; then
                echo "Query $i outputs do not match!"
            fi;
    fi;
done;