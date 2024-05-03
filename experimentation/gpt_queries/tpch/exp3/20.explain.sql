explain select s_name, s_address 
FROM supplier 
JOIN nation ON s_nationkey = n_nationkey AND n_name = 'FRANCE'
JOIN (
    SELECT ps_suppkey 
    FROM partsupp 
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity 
        FROM lineitem 
        WHERE l_shipdate >= DATE '1995-01-01' AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
        GROUP BY l_partkey, l_suppkey
    ) AS agg_lineitem ON agg_partkey = ps_partkey AND agg_suppkey = ps_suppkey AND ps_availqty > agg_quantity
    JOIN part ON ps_partkey = p_partkey AND p_name LIKE 'linen%'
) AS agg_partsupp ON s_suppkey = agg_partsupp.ps_suppkey
ORDER BY s_name;SELECT s_name, s_address 
FROM supplier 
JOIN nation ON s_nationkey = n_nationkey AND n_name = 'FRANCE'
JOIN (
    SELECT ps_suppkey 
    FROM partsupp 
    JOIN (
        SELECT l_partkey AS agg_partkey, l_suppkey AS agg_suppkey, 0.5 * SUM(l_quantity) AS agg_quantity 
        FROM lineitem 
        WHERE l_shipdate >= DATE '1995-01-01' AND l_shipdate < DATE '1995-01-01' + INTERVAL '1' YEAR 
        GROUP BY l_partkey, l_suppkey
    ) AS agg_lineitem ON agg_partkey = ps_partkey AND agg_suppkey = ps_suppkey AND ps_availqty > agg_quantity
    JOIN part ON ps_partkey = p_partkey AND p_name LIKE 'linen%'
) AS agg_partsupp ON s_suppkey = agg_partsupp.ps_suppkey
ORDER BY s_name;