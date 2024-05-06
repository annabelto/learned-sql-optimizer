SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS value
FROM partsupp
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
WHERE nation.n_name = 'FRANCE'
GROUP BY ps_partkey
HAVING SUM(ps_supplycost * ps_availqty) > (
    SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000
    FROM partsupp
    JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
    JOIN nation ON supplier.s_nationkey = nation.n_nationkey
    WHERE nation.n_name = 'FRANCE'
)
ORDER BY value DESC
LIMIT ALL;