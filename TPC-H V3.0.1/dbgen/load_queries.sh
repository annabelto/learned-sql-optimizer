#!/bin/sh

IN_DIR=$1
OUT_DIR=$2

for q in `seq 1 22`
do
    # DSS_QUERY=$IN_DIR ./qgen $q >> $OUT_DIR/$q.sql
    sed 's/^SELECT/explain select/' $OUT_DIR/$q.sql > $OUT_DIR/$q.explain.sql
    cat $OUT_DIR/$q.sql >> $OUT_DIR/$q.explain.sql;
done
