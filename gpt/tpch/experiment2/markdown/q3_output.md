### Original Query
```sql
SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM customer, orders, lineitem 
WHERE c_mktsegment = 'AUTOMOBILE' 
  AND c_custkey = o_custkey 
  AND l_orderkey = o_orderkey 
  AND o_orderdate < DATE '1995-03-20' 
  AND l_shipdate > DATE '1995-03-20' 
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate 
LIMIT ALL;
```

### Optimization Steps

1. **Predicate Pushdown**: Move conditions as close as possible to where the data originates. This reduces the amount of data that needs to be processed in later stages of the query.
2. **Join Reordering**: Reorder joins to start with the smallest or most restricted dataset. This can reduce the size of intermediate results.
3. **Explicit JOIN Syntax**: Use explicit JOIN syntax instead of commas in the FROM clause for better readability and control over join behavior.
4. **Remove Redundant LIMIT**: The `LIMIT ALL` clause is redundant as it does not limit the number of rows returned. Removing it simplifies the query.

### Applying Optimization Rules

1. **Predicate Pushdown**:
   - Push `c_mktsegment = 'AUTOMOBILE'` to the `customer` table.
   - Push `o_orderdate < DATE '1995-03-20'` to the `orders` table.
   - Push `l_shipdate > DATE '1995-03-20'` to the `lineitem` table.

2. **Explicit JOIN Syntax**:
   - Convert the implicit joins (comma-separated FROM clause) to explicit JOINs.

3. **Join Reordering**:
   - Assuming statistics suggest `customer` has fewer rows for 'AUTOMOBILE', start with `customer`.

4. **Remove Redundant LIMIT**:
   - Remove `LIMIT ALL`.

### Optimized Query
```sql
SELECT l_orderkey, 
       SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
       o_orderdate, 
       o_shippriority 
FROM customer 
JOIN orders ON c_custkey = o_custkey 
JOIN lineitem ON l_orderkey = o_orderkey 
WHERE c_mktsegment = 'AUTOMOBILE' 
  AND o_orderdate < DATE '1995-03-20' 
  AND l_shipdate > DATE '1995-03-20' 
GROUP BY l_orderkey, o_orderdate, o_shippriority 
ORDER BY revenue DESC, o_orderdate;
```

This rewritten query should perform better due to more efficient use of joins and filtering, and improved readability and maintainability.