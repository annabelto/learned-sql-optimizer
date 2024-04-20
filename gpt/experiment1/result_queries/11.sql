WITH filtered_nation AS (
    SELECT n_nationkey
    FROM nation
    WHERE n_name = ':1'
),
aggregated_value AS (
    SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS total_value
    FROM partsupp
    JOIN supplier ON ps_suppkey = s_suppkey
    JOIN filtered_nation ON s_nationkey = filtered_nation.n_nationkey
    GROUP BY ps_partkey
),
total_aggregate AS (
    SELECT SUM(total_value) * :2 AS threshold
    FROM aggregated_value
)
SELECT ps_partkey, total_value AS value
FROM aggregated_value
WHERE total_value > (SELECT threshold FROM total_aggregate)
ORDER BY value DESC;