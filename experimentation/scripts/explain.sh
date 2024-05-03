#!/bin/sh

IN_DIR=$1
OUT_DIR=$2
n=$3

nq="1 4 11 74"

for q in `seq 1 $n`
do
    if echo "$nq" | grep -w "$n" > /dev/null; then
        continue;
    fi
    # DSS_QUERY=$IN_DIR ./qgen $q >> $OUT_DIR/$q.sql
    sed 's/^SELECT/explain select/' $OUT_DIR/$q.sql > $OUT_DIR/$q.explain.sql
    cat $OUT_DIR/$q.sql >> $OUT_DIR/$q.explain.sql;
done