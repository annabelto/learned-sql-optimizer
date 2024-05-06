explain select o_orderpriority, COUNT(*) AS order_count
FROM orders
JOIN lineitem ON l_orderkey = o_orderkey
WHERE o_orderdate >= DATE '1996-01-01'
  AND o_orderdate < DATE '1996-01-01' + INTERVAL '3' month
  AND l_commitdate < l_receiptdate
GROUP BY o_orderpriority
ORDER BY o_orderpriority;SELECT o_orderpriority, COUNT(*) AS order_count
FROM orders
JOIN lineitem ON l_orderkey = o_orderkey
WHERE o_orderdate >= DATE '1996-01-01'
  AND o_orderdate < DATE '1996-01-01' + INTERVAL '3' month
  AND l_commitdate < l_receiptdate
GROUP BY o_orderpriority
ORDER BY o_orderpriority;