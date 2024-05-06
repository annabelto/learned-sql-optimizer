explain select s_name, COUNT(*) AS numwait
FROM nation
JOIN supplier ON s_nationkey = n_nationkey
JOIN lineitem l1 ON s_suppkey = l1.l_suppkey
JOIN orders ON o_orderkey = l1.l_orderkey AND o_orderstatus = 'F'
WHERE n_name = 'KENYA'
  AND l1.l_receiptdate > l1.l_commitdate
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
ORDER BY numwait DESC, s_name
LIMIT ALL;SELECT s_name, COUNT(*) AS numwait
FROM nation
JOIN supplier ON s_nationkey = n_nationkey
JOIN lineitem l1 ON s_suppkey = l1.l_suppkey
JOIN orders ON o_orderkey = l1.l_orderkey AND o_orderstatus = 'F'
WHERE n_name = 'KENYA'
  AND l1.l_receiptdate > l1.l_commitdate
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
ORDER BY numwait DESC, s_name
LIMIT ALL;