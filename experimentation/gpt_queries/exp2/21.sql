SELECT s_name, COUNT(*) AS numwait
FROM supplier
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
JOIN lineitem l1 ON supplier.s_suppkey = l1.l_suppkey
JOIN orders ON l1.l_orderkey = orders.o_orderkey
WHERE orders.o_orderstatus = 'F'
  AND l1.l_receiptdate > l1.l_commitdate
  AND nation.n_name = 'KENYA'
  AND EXISTS (
    SELECT 1
    FROM lineitem l2
    WHERE l2.l_orderkey = l1.l_orderkey
      AND l2.l_suppkey <> l1.l_suppkey
  )
  AND NOT EXISTS (
    SELECT 1
    FROM lineitem l3
    WHERE l3.l_orderkey = l1.l_orderkey
      AND l3.l_suppkey <> l1.l_suppkey
      AND l3.l_receiptdate > l3.l_commitdate
  )
GROUP BY s_name
ORDER BY numwait DESC, s_name;