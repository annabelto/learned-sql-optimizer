To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the amount of data processed and the complexity of the query execution. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates (filter conditions) closer to the data sources. It helps in reducing the number of tuples processed in the joins by filtering the data as early as possible.

2. **Join Reordering**: This rule changes the order of joins to minimize the size of intermediate results. It's beneficial to perform joins that reduce the result size early.

3. **Use of Explicit Joins**: Changing implicit joins (in the WHERE clause) to explicit JOIN syntax can improve readability and sometimes performance, as it allows the database engine to better understand the join conditions.

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
WHERE r_name = 'MIDDLE EAST'
  AND o_orderdate >= DATE '1995-01-01'
  AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' year
GROUP BY n_name
ORDER BY revenue DESC
LIMIT ALL;
```

### Explanation of Optimization Steps:

1. **Predicate Pushdown**:
   - The conditions `r_name = 'MIDDLE EAST'`, `o_orderdate >= DATE '1995-01-01'`, and `o_orderdate < DATE '1995-01-01' + INTERVAL '1' year` are pushed down. This means they are applied as soon as their respective tables (`region` and `orders`) are accessed. This reduces the number of rows from `region` and `orders` that participate in subsequent joins.

2. **Join Reordering**:
   - The order of joins is rearranged to start with `region` and `nation`, followed by `supplier`, `customer`, `orders`, and `lineitem`. This order is chosen based on the assumption that filtering by `region` (a likely smaller table and highly selective filter `r_name = 'MIDDLE EAST'`) will reduce the dataset size early in the query execution.

3. **Use of Explicit Joins**:
   - The query uses explicit `JOIN` syntax instead of listing all tables in the `FROM` clause and specifying join conditions in the `WHERE` clause. This makes the join conditions clearer and can help the database optimizer understand the query structure better.

These optimizations aim to reduce the computational load by minimizing the amount of data carried through the various stages of the query, thus potentially improving execution speed and efficiency.