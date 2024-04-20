To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the complexity and improving the performance of the query. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates (filters) closer to the data source. It is beneficial to apply filters as early as possible to reduce the size of intermediate results.

2. **Common Sub-expression Elimination**: This rule identifies and eliminates redundancy by computing common expressions once and reusing the result.

3. **Join Elimination**: If a join does not contribute additional columns or rows to the final result, it can be eliminated.

Here's the optimized query with explanations for each step:

### Original Query
```sql
SELECT ps_partkey, SUM(ps_supplycost * ps_availqty) AS value
FROM partsupp, supplier, nation
WHERE ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = ':1'
GROUP BY ps_partkey
HAVING SUM(ps_supplycost * ps_availqty) > (
    SELECT SUM(ps_supplycost * ps_availqty) * :2
    FROM partsupp, supplier, nation
    WHERE ps_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = ':1'
)
ORDER BY value DESC;
```

### Step 1: Predicate Pushdown
Move the filter `n_name = ':1'` closer to the table `nation` to reduce the number of rows joined with `partsupp` and `supplier`.

### Step 2: Common Sub-expression Elimination
The subquery in the `HAVING` clause is recalculating the sum for the same conditions. We can calculate this once and reuse it.

### Step 3: Join Elimination
After applying predicate pushdown, if certain joins are not contributing to additional columns used in SELECT or WHERE, consider their elimination. However, in this case, all joins seem necessary due to the conditions and the columns used in calculations.

### Optimized Query
```sql
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
```

### Explanation:
- **WITH Clauses**: Used to define `filtered_nation` which filters nations by name early. `aggregated_value` computes the sum of `ps_supplycost * ps_availqty` grouped by `ps_partkey`. `total_aggregate` computes the threshold value from the aggregated values.
- **Main SELECT**: Uses the results from the `WITH` clauses to filter and order the final output based on the computed values.

This optimized query reduces redundant calculations and leverages common sub-expressions, improving performance by minimizing the amount of data processed in later stages of the query.