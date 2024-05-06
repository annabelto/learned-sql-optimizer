SELECT o.o_orderpriority, COUNT(*) AS order_count
FROM orders o
WHERE o.o_orderdate >= DATE '1996-01-01'
  AND o.o_orderdate < DATE '1996-01-01' + INTERVAL '3' month
  AND EXISTS (
    SELECT 1
    FROM lineitem l
    WHERE l.l_orderkey = o.o_orderkey
      AND l.l_commitdate < l.l_receiptdate
  )
GROUP BY o.o_orderpriority
ORDER BY o.o_orderpriority
LIMIT ALL;