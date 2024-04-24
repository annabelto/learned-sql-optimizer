SELECT 
    nation, 
    o_year, 
    sum(amount) as sum_profit 
FROM 
    (
        SELECT 
            n_name as nation, 
            extract(year from o_orderdate) as o_year, 
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount 
        FROM 
            part
        INNER JOIN 
            lineitem ON p_partkey = l_partkey
        INNER JOIN 
            partsupp ON ps_partkey = l_partkey
        INNER JOIN 
            orders ON o_orderkey = l_orderkey
        INNER JOIN 
            supplier ON s_suppkey = l_suppkey AND s_suppkey = ps_suppkey
        INNER JOIN 
            nation ON s_nationkey = n_nationkey
        WHERE 
            p_name like '%white%'
    ) as profit 
GROUP BY 
    nation, 
    o_year 
ORDER BY 
    nation, 
    o_year DESC 
LIMIT ALL;