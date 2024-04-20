To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the amount of data processed and improve the execution plan. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves the predicates (conditions) as close as possible to the base tables in the query. This reduces the number of rows processed early in the execution plan, which can significantly improve performance.

2. **Join Reordering**: This rule changes the order of joins to start with those that reduce the result set the most, based on the available predicates.

3. **Projection Pushdown**: This rule moves the projection (selection of columns) closer to the source tables to reduce the number of columns processed in the subsequent operations.

Here's the optimized query with explanations for each step:

```sql
SELECT n_name, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM region
JOIN nation ON n_regionkey = r_regionkey
JOIN supplier ON s_nationkey = n_nationkey
JOIN customer ON c_nationkey = s_nationkey
JOIN orders ON c_custkey = o_custkey
JOIN lineitem ON l_orderkey = o_orderkey AND l_suppkey = s_suppkey
WHERE r_name = ':1'
  AND o_orderdate >= DATE ':2'
  AND o_orderdate < DATE ':2' + INTERVAL '1' year
GROUP BY n_name
ORDER BY revenue DESC;
```

### Explanation of Optimization Steps:

1. **Predicate Pushdown**:
   - The conditions `r_name = ':1'`, `o_orderdate >= DATE ':2'`, and `o_orderdate < DATE ':2' + INTERVAL '1' year` are pushed down to filter rows as early as possible in the query execution.

2. **Join Reordering**:
   - The query starts with the `region` table, which is likely to have fewer rows after applying the `r_name` filter.
   - It then proceeds to join with `nation`, `supplier`, `customer`, `orders`, and finally `lineitem`. This order is chosen based on the assumption that filtering by date on `orders` and by region on `region` will significantly reduce the number of rows early in the join sequence.

3. **Projection Pushdown**:
   - Only the necessary columns for joins and final projection (`n_name`, `l_extendedprice`, `l_discount`) are carried through the query, reducing the amount of data processed.

By applying these rules, the query is structured to minimize the amount of data read and processed, which should lead to better performance on large datasets.