SELECT s_name, s_address 
FROM supplier
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
WHERE nation.n_name = 'FRANCE'
AND supplier.s_suppkey IN (
    SELECT partsupp.ps_suppkey
    FROM partsupp
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity
        FROM lineitem
        WHERE l_shipdate >= DATE '1995-01-01' AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' year
        GROUP BY l_partkey, l_suppkey
    ) AS agg_lineitem ON partsupp.ps_partkey = agg_lineitem.agg_partkey AND partsupp.ps_suppkey = agg_lineitem.agg_suppkey
    WHERE partsupp.ps_availqty > agg_lineitem.agg_quantity
    AND EXISTS (
        SELECT 1
        FROM part
        WHERE part.p_partkey = partsupp.ps_partkey
        AND part.p_name LIKE 'linen%'
    )
)
ORDER BY s_name
LIMIT ALL;