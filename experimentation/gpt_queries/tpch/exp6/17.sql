SELECT SUM(l.l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem l
JOIN part p ON p.p_partkey = l.l_partkey
JOIN (
    SELECT l_partkey AS agg_partkey, 0.2 * AVG(l_quantity) AS avg_quantity
    FROM lineitem
    GROUP BY l_partkey
) part_agg ON part_agg.agg_partkey = l.l_partkey
WHERE p.p_brand = 'Brand#41'
AND p.p_container = 'WRAP BAG'
AND l.l_quantity < part_agg.avg_quantity
LIMIT ALL;