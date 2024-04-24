-- Calculate the threshold value once and use it in the main query
WITH france_parts AS (
    SELECT ps_partkey, ps_suppkey, ps_supplycost, ps_availqty
    FROM partsupp, supplier, nation
    WHERE ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'FRANCE'
),
threshold AS (
    SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000 AS threshold_value
    FROM france_parts
)
SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS value
FROM france_parts
GROUP BY ps_partkey
HAVING SUM(ps_supplycost * ps_availqty) > (SELECT threshold_value FROM threshold)
ORDER BY value DESC
LIMIT ALL;