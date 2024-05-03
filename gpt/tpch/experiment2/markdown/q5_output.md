### Original Query
```sql
SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM customer, orders, lineitem, supplier, nation, region
WHERE c_custkey = o_custkey
  AND l_orderkey = o_orderkey
  AND l_suppkey = s_suppkey
  AND c_nationkey = s_nationkey
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = 'MIDDLE EAST'
  AND o_orderdate >= DATE '1995-01-01'
  AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' YEAR
GROUP BY n_name
ORDER BY revenue DESC
LIMIT ALL;
```

### Optimization Steps

1. **Predicate Pushdown**: Move conditions as close as possible to the table they filter to reduce the size of intermediate results.
2. **Join Reordering**: Reorder joins to start with the smallest tables or those most reduced by filtering to minimize the size of intermediate results.
3. **Use Explicit JOIN Syntax**: Replace implicit joins (comma-separated FROM clause) with explicit JOIN syntax for better readability and control.
4. **Remove Redundant LIMIT**: `LIMIT ALL` is redundant as it does not limit the result set.

### Applying Optimization Rules

1. **Predicate Pushdown**: 
   - Push `r_name = 'MIDDLE EAST'` closer to the `region` table.
   - Push date conditions on `orders`.

2. **Use Explicit JOIN Syntax**:
   - Convert the query to use explicit JOINs instead of commas in the FROM clause.

3. **Join Reordering**:
   - Start with `region` since it's highly reduced by `r_name = 'MIDDLE EAST'`.
   - Then join `nation`, followed by `supplier`, `customer`, `orders`, and `lineitem`.

4. **Remove Redundant LIMIT**:
   - Remove `LIMIT ALL` as it serves no purpose.

### Optimized Query
```sql
SELECT n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM region
JOIN nation ON n_regionkey = r_regionkey
JOIN supplier ON s_nationkey = n_nationkey
JOIN customer ON c_nationkey = s_nationkey
JOIN orders ON c_custkey = o_custkey
  AND o_orderdate >= DATE '1995-01-01'
  AND o_orderdate < DATE '1995-01-01' + INTERVAL '1' YEAR
JOIN lineitem ON l_orderkey = o_orderkey
  AND l_suppkey = s_suppkey
WHERE r_name = 'MIDDLE EAST'
GROUP BY n_name
ORDER BY revenue DESC;
```

This rewritten query should perform better due to more efficient use of joins and filtering, reducing the amount of data processed and improving overall query execution time.