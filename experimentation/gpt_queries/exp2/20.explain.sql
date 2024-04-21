explain select s_name, s_address 
FROM supplier
JOIN nation ON s_nationkey = n_nationkey 
WHERE n_name = 'FRANCE'
AND EXISTS (
    SELECT 1
    FROM partsupp
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity 
        FROM lineitem 
        WHERE l_shipdate >= DATE '1995-01-01' 
        AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
        GROUP BY l_partkey, l_suppkey
    ) agg_lineitem ON agg_partkey = ps_partkey AND agg_suppkey = ps_suppkey
    WHERE ps_suppkey = supplier.s_suppkey
    AND ps_availqty > agg_quantity
    AND EXISTS (
        SELECT 1
        FROM part
        WHERE p_partkey = ps_partkey
        AND p_name LIKE 'linen%'
    )
)
ORDER BY s_name;SELECT s_name, s_address 
FROM supplier
JOIN nation ON s_nationkey = n_nationkey 
WHERE n_name = 'FRANCE'
AND EXISTS (
    SELECT 1
    FROM partsupp
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity 
        FROM lineitem 
        WHERE l_shipdate >= DATE '1995-01-01' 
        AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
        GROUP BY l_partkey, l_suppkey
    ) agg_lineitem ON agg_partkey = ps_partkey AND agg_suppkey = ps_suppkey
    WHERE ps_suppkey = supplier.s_suppkey
    AND ps_availqty > agg_quantity
    AND EXISTS (
        SELECT 1
        FROM part
        WHERE p_partkey = ps_partkey
        AND p_name LIKE 'linen%'
    )
)
ORDER BY s_name;