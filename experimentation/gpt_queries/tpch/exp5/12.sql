SELECT l_shipmode,
       COUNT(*) FILTER (WHERE o_orderpriority = '1-URGENT' OR o_orderpriority = '2-HIGH') AS high_line_count,
       COUNT(*) FILTER (WHERE o_orderpriority <> '1-URGENT' AND o_orderpriority <> '2-HIGH') AS low_line_count
FROM orders
JOIN lineitem ON o_orderkey = l_orderkey
WHERE l_shipmode IN ('RAIL', 'TRUCK')
  AND l_commitdate < l_receiptdate
  AND l_shipdate < l_commitdate
  AND l_receiptdate >= DATE '1995-01-01'
  AND l_receiptdate < DATE '1996-01-01'
GROUP BY l_shipmode
ORDER BY l_shipmode;