explain select sum(l_extendedprice * l_discount) AS revenue
FROM lineitem
WHERE l_shipdate >= date '1995-01-01'
  AND l_shipdate < date '1996-01-01'
  AND l_discount BETWEEN 0.02 AND 0.04
  AND l_quantity < 25;SELECT sum(l_extendedprice * l_discount) AS revenue
FROM lineitem
WHERE l_shipdate >= date '1995-01-01'
  AND l_shipdate < date '1996-01-01'
  AND l_discount BETWEEN 0.02 AND 0.04
  AND l_quantity < 25;