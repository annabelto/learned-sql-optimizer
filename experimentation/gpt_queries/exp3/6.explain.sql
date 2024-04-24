explain select SUM(sub.revenue) as total_revenue
FROM (
  SELECT l_extendedprice * l_discount as revenue
  FROM lineitem
  WHERE l_shipdate BETWEEN date '1995-01-01' AND date '1995-01-01' + interval '1' year - interval '1' day
    AND l_discount BETWEEN 0.03 - 0.01 AND 0.03 + 0.01
    AND l_quantity < 25
) sub;SELECT SUM(sub.revenue) as total_revenue
FROM (
  SELECT l_extendedprice * l_discount as revenue
  FROM lineitem
  WHERE l_shipdate BETWEEN date '1995-01-01' AND date '1995-01-01' + interval '1' year - interval '1' day
    AND l_discount BETWEEN 0.03 - 0.01 AND 0.03 + 0.01
    AND l_quantity < 25
) sub;