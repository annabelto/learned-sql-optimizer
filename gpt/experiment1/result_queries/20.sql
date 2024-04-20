SELECT s_name, s_address 
FROM part
JOIN partsupp ON p_partkey = ps_partkey
JOIN supplier ON ps_suppkey = s_suppkey
JOIN nation ON s_nationkey = n_nationkey
WHERE p_name LIKE ':1%'
AND n_name = ':3'
AND ps_availqty > (
    SELECT 0.5 * SUM(l_quantity) 
    FROM lineitem 
    WHERE l_partkey = ps_partkey 
    AND l_suppkey = ps_suppkey 
    AND l_shipdate >= DATE ':2' 
    AND l_shipdate < DATE ':2' + INTERVAL '1' year
)
ORDER BY s_name;