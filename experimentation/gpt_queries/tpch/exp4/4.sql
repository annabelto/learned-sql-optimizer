SELECT o_orderpriority, COUNT(DISTINCT orders.o_orderkey) AS order_count
FROM orders
JOIN lineitem ON orders.o_orderkey = lineitem.l_orderkey AND lineitem.l_commitdate < lineitem.l_receiptdate
WHERE orders.o_orderdate >= DATE '1996-01-01'
  AND orders.o_orderdate < DATE '1996-01-01' + INTERVAL '3' month
GROUP BY o_orderpriority
ORDER BY o_orderpriority
LIMIT ALL;