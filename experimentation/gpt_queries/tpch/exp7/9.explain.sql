explain select 
    nation, 
    o_year, 
    SUM(amount) AS sum_profit 
FROM 
    (
        SELECT 
            n_name AS nation, 
            EXTRACT(YEAR FROM o_orderdate) AS o_year, 
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount 
        FROM 
            part
            JOIN partsupp ON p_partkey = ps_partkey
            JOIN lineitem ON ps_partkey = l_partkey AND ps_suppkey = l_suppkey AND l_partkey = p_partkey
            JOIN orders ON o_orderkey = l_orderkey
            JOIN supplier ON s_suppkey = l_suppkey
            JOIN nation ON s_nationkey = n_nationkey
        WHERE 
            p_name LIKE '%white%'
    ) AS profit 
GROUP BY 
    nation, 
    o_year 
ORDER BY 
    nation, 
    o_year DESC 
LIMIT ALL;SELECT 
    nation, 
    o_year, 
    SUM(amount) AS sum_profit 
FROM 
    (
        SELECT 
            n_name AS nation, 
            EXTRACT(YEAR FROM o_orderdate) AS o_year, 
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount 
        FROM 
            part
            JOIN partsupp ON p_partkey = ps_partkey
            JOIN lineitem ON ps_partkey = l_partkey AND ps_suppkey = l_suppkey AND l_partkey = p_partkey
            JOIN orders ON o_orderkey = l_orderkey
            JOIN supplier ON s_suppkey = l_suppkey
            JOIN nation ON s_nationkey = n_nationkey
        WHERE 
            p_name LIKE '%white%'
    ) AS profit 
GROUP BY 
    nation, 
    o_year 
ORDER BY 
    nation, 
    o_year DESC 
LIMIT ALL;