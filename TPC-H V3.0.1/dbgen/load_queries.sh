for q in `seq 1 22`
do
    DSS_QUERY=../../pg_tpch/dss/templates ./qgen $q >> ./out_queries/$q.sql
    sed 's/^select/explain select/' ./out_queries/$q.sql > ./out_queries/$q.explain.sql
    cat ./out_queries/$q.sql >> ./out_queries/$q.explain.sql;
done
