WITH l2 AS (
    SELECT l_orderkey, l_suppkey
    FROM lineitem
    WHERE EXISTS (
        SELECT 1
        FROM lineitem
        WHERE l_orderkey = l1.l_orderkey
        AND l_suppkey <> l1.l_suppkey
    )
), l3 AS (
    SELECT l_orderkey, l_suppkey
    FROM lineitem
    WHERE NOT EXISTS (
        SELECT 1
        FROM lineitem
        WHERE l_orderkey = l1.l_orderkey
        AND l_suppkey <> l1.l_suppkey
        AND l_receiptdate > l_commitdate
    )
)
explain select s_name, COUNT(*) AS numwait
FROM supplier
JOIN lineitem l1 ON s_suppkey = l1.l_suppkey
JOIN orders ON o_orderkey = l1.l_orderkey
JOIN nation ON s_nationkey = n_nationkey
LEFT JOIN l2 ON l2.l_orderkey = l1.l_orderkey
LEFT JOIN l3 ON l3.l_orderkey = l1.l_orderkey
WHERE o_orderstatus = 'F'
AND l1.l_receiptdate > l1.l_commitdate
AND n_name = 'KENYA'
GROUP BY s_name
ORDER BY numwait DESC, s_name
LIMIT ALL;WITH l2 AS (
    SELECT l_orderkey, l_suppkey
    FROM lineitem
    WHERE EXISTS (
        SELECT 1
        FROM lineitem
        WHERE l_orderkey = l1.l_orderkey
        AND l_suppkey <> l1.l_suppkey
    )
), l3 AS (
    SELECT l_orderkey, l_suppkey
    FROM lineitem
    WHERE NOT EXISTS (
        SELECT 1
        FROM lineitem
        WHERE l_orderkey = l1.l_orderkey
        AND l_suppkey <> l1.l_suppkey
        AND l_receiptdate > l_commitdate
    )
)
SELECT s_name, COUNT(*) AS numwait
FROM supplier
JOIN lineitem l1 ON s_suppkey = l1.l_suppkey
JOIN orders ON o_orderkey = l1.l_orderkey
JOIN nation ON s_nationkey = n_nationkey
LEFT JOIN l2 ON l2.l_orderkey = l1.l_orderkey
LEFT JOIN l3 ON l3.l_orderkey = l1.l_orderkey
WHERE o_orderstatus = 'F'
AND l1.l_receiptdate > l1.l_commitdate
AND n_name = 'KENYA'
GROUP BY s_name
ORDER BY numwait DESC, s_name
LIMIT ALL;