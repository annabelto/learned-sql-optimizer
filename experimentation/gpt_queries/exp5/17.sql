SELECT sum(l_extendedprice) / 7.0 AS avg_yearly
FROM part
JOIN lineitem ON p_partkey = l_partkey
JOIN (
    SELECT l_partkey AS agg_partkey, 
           0.2 * avg(l_quantity) AS avg_quantity
    FROM lineitem
    GROUP BY l_partkey
) AS part_agg ON part_agg.agg_partkey = lineitem.l_partkey
WHERE p_brand = 'Brand#41'
  AND p_container = 'WRAP BAG'
  AND l_quantity < part_agg.avg_quantity
LIMIT ALL;