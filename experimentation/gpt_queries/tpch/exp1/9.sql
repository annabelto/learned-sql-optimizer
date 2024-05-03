SELECT 
    n_name AS nation, 
    EXTRACT(YEAR FROM o_orderdate) AS o_year, 
    SUM(l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity) AS sum_profit
FROM 
    nation
JOIN 
    supplier ON s_nationkey = n_nationkey
JOIN 
    partsupp ON s_suppkey = ps_suppkey
JOIN 
    lineitem ON ps_suppkey = l_suppkey AND ps_partkey = l_partkey AND o_orderkey = l_orderkey
JOIN 
    orders ON o_orderkey = l_orderkey
JOIN 
    part ON p_partkey = l_partkey
WHERE 
    p_name LIKE '%white%'
GROUP BY 
    n_name, EXTRACT(YEAR FROM o_orderdate)
ORDER BY 
    n_name, EXTRACT(YEAR FROM o_orderdate) DESC
LIMIT ALL;