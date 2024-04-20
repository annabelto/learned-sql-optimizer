#!/bin/sh

for q in `seq 1 22`
do
    DSS_QUERY=/home/excalibur/learned-sql-optimizer/experimentation/templates ./qgen $q >> /home/excalibur/learned-sql-optimizer/experimentation/tpch_queries/$q.sql
    sed 's/^select/explain select/' /home/excalibur/learned-sql-optimizer/experimentation/tpch_queries/$q.sql > /home/excalibur/learned-sql-optimizer/experimentation/tpch_queries/$q.explain.sql
    cat /home/excalibur/learned-sql-optimizer/experimentation/tpch_queries/$q.sql >> /home/excalibur/learned-sql-optimizer/experimentation/tpch_queries/$q.explain.sql;
done
