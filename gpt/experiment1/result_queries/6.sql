SELECT SUM(l_extendedprice * l_discount) AS revenue
FROM lineitem
WHERE l_shipdate >= date ':1'
  AND l_shipdate < date ':1' + interval '1' year
  AND l_discount BETWEEN :2 - 0.01 AND :2 + 0.01
  AND l_quantity < :3;