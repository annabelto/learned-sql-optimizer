SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem
JOIN part ON p_partkey = l_partkey
JOIN (
  SELECT l_partkey AS sub_l_partkey, 0.2 * AVG(l_quantity) AS avg_qty
  FROM lineitem
  GROUP BY l_partkey
) AS subquery ON subquery.sub_l_partkey = l_partkey
WHERE p_brand = ':1'
  AND p_container = ':2'
  AND l_quantity < subquery.avg_qty;