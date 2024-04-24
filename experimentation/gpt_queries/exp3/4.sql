SELECT o.o_orderpriority, COUNT(o.o_orderkey) AS order_count 
FROM orders o
JOIN lineitem l ON o.o_orderkey = l.l_orderkey 
WHERE o.o_orderdate >= date '1996-01-01' 
AND o.o_orderdate < date '1996-01-01' + interval '3' month 
AND l.l_commitdate < l.l_receiptdate 
GROUP BY o.o_orderpriority 
ORDER BY o.o_orderpriority;