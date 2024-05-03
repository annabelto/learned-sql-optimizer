explain select sum(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem
JOIN (SELECT * FROM part WHERE p_brand = 'Brand#41' AND p_container = 'WRAP BAG') AS filtered_part
  ON filtered_part.p_partkey = lineitem.l_partkey
JOIN (SELECT l_partkey AS agg_partkey, 0.2 * avg(l_quantity) AS avg_quantity 
      FROM lineitem 
      GROUP BY l_partkey
      HAVING l_quantity < (SELECT 0.2 * avg(l_quantity) FROM lineitem WHERE l_partkey = lineitem.l_partkey)) part_agg 
  ON part_agg.agg_partkey = lineitem.l_partkey;SELECT sum(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem
JOIN (SELECT * FROM part WHERE p_brand = 'Brand#41' AND p_container = 'WRAP BAG') AS filtered_part
  ON filtered_part.p_partkey = lineitem.l_partkey
JOIN (SELECT l_partkey AS agg_partkey, 0.2 * avg(l_quantity) AS avg_quantity 
      FROM lineitem 
      GROUP BY l_partkey
      HAVING l_quantity < (SELECT 0.2 * avg(l_quantity) FROM lineitem WHERE l_partkey = lineitem.l_partkey)) part_agg 
  ON part_agg.agg_partkey = lineitem.l_partkey;