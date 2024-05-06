SELECT s_name, s_address 
FROM supplier
JOIN nation ON s_nationkey = n_nationkey
WHERE n_name = 'FRANCE'
AND EXISTS (
    SELECT 1
    FROM partsupp
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity
        FROM lineitem
        WHERE l_shipdate >= DATE '1995-01-01' AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' year
        GROUP BY l_partkey, l_suppkey
    ) agg_lineitem ON agg_lineitem.agg_partkey = partsupp.ps_partkey AND agg_lineitem.agg_suppkey = partsupp.ps_suppkey
    JOIN part ON partsupp.ps_partkey = part.p_partkey
    WHERE part.p_name LIKE 'linen%' AND partsupp.ps_availqty > agg_lineitem.agg_quantity
)
ORDER BY s_name
LIMIT ALL;