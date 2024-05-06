SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM part
JOIN lineitem ON part.p_partkey = lineitem.l_partkey
JOIN (
    SELECT l_partkey AS agg_partkey, 0.2 * AVG(l_quantity) AS avg_quantity
    FROM lineitem
    GROUP BY l_partkey
) part_agg ON lineitem.l_partkey = part_agg.agg_partkey
WHERE part.p_brand = 'Brand#41'
  AND part.p_container = 'WRAP BAG'
  AND lineitem.l_quantity < part_agg.avg_quantity
LIMIT ALL;