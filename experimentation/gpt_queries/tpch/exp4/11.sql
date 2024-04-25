WITH france_parts AS (
    SELECT ps_partkey, ps_suppkey, ps_supplycost, ps_availqty
    FROM partsupp
    JOIN supplier ON ps_suppkey = s_suppkey
    JOIN nation ON s_nationkey = n_nationkey
    WHERE n_name = 'FRANCE'
),
total_value AS (
    SELECT sum(ps_supplycost * ps_availqty) * 0.0001000000 AS threshold
    FROM france_parts
)
SELECT ps_partkey, sum(ps_supplycost * ps_availqty) AS value
FROM france_parts
GROUP BY ps_partkey
HAVING sum(ps_supplycost * ps_availqty) > (SELECT threshold FROM total_value)
ORDER BY value DESC
LIMIT ALL;