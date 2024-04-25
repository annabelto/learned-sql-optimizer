WITH total_value AS (
    SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000 AS total 
    FROM partsupp 
    JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey 
    JOIN nation ON supplier.s_nationkey = nation.n_nationkey 
    WHERE nation.n_name = 'FRANCE'
)
explain select ps_partkey, 
       SUM(ps_supplycost * ps_availqty) AS value 
FROM partsupp 
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey 
JOIN nation ON supplier.s_nationkey = nation.n_nationkey 
WHERE nation.n_name = 'FRANCE' 
GROUP BY ps_partkey 
HAVING SUM(ps_supplycost * ps_availqty) > (SELECT total FROM total_value) 
ORDER BY value DESC;WITH total_value AS (
    SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000 AS total 
    FROM partsupp 
    JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey 
    JOIN nation ON supplier.s_nationkey = nation.n_nationkey 
    WHERE nation.n_name = 'FRANCE'
)
SELECT ps_partkey, 
       SUM(ps_supplycost * ps_availqty) AS value 
FROM partsupp 
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey 
JOIN nation ON supplier.s_nationkey = nation.n_nationkey 
WHERE nation.n_name = 'FRANCE' 
GROUP BY ps_partkey 
HAVING SUM(ps_supplycost * ps_availqty) > (SELECT total FROM total_value) 
ORDER BY value DESC;