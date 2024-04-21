WITH france_suppliers AS (
    SELECT s_suppkey
    FROM supplier
    JOIN nation ON s_nationkey = n_nationkey
    WHERE n_name = 'FRANCE'
),
total_value AS (
    SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000 AS threshold
    FROM partsupp
    JOIN france_suppliers ON ps_suppkey = france_suppliers.s_suppkey
)
explain select ps_partkey, SUM(ps_supplycost * ps_availqty) AS value
FROM partsupp
JOIN france_suppliers ON ps_suppkey = france_suppliers.s_suppkey
GROUP BY ps_partkey
HAVING SUM(ps_supplycost * ps_availqty) > (SELECT threshold FROM total_value)
ORDER BY value DESC
LIMIT ALL;WITH france_suppliers AS (
    SELECT s_suppkey
    FROM supplier
    JOIN nation ON s_nationkey = n_nationkey
    WHERE n_name = 'FRANCE'
),
total_value AS (
    SELECT SUM(ps_supplycost * ps_availqty) * 0.0001000000 AS threshold
    FROM partsupp
    JOIN france_suppliers ON ps_suppkey = france_suppliers.s_suppkey
)
SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS value
FROM partsupp
JOIN france_suppliers ON ps_suppkey = france_suppliers.s_suppkey
GROUP BY ps_partkey
HAVING SUM(ps_supplycost * ps_availqty) > (SELECT threshold FROM total_value)
ORDER BY value DESC
LIMIT ALL;