SELECT o.o_orderpriority, COUNT(*) AS order_count
FROM orders o
INNER JOIN lineitem l ON o.o_orderkey = l.l_orderkey AND l.l_commitdate < l.l_receiptdate
WHERE o.o_orderdate >= DATE ':1'
  AND o.o_orderdate < DATE ':1' + INTERVAL '3' MONTH
GROUP BY o.o_orderpriority
ORDER BY o.o_orderpriority;