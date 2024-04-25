### Original Query
```sql
SELECT nation, o_year, SUM(amount) AS sum_profit
FROM (
    SELECT n_name AS nation, 
           EXTRACT(YEAR FROM o_orderdate) AS o_year, 
           l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount
    FROM part, supplier, lineitem, partsupp, orders, nation
    WHERE s_suppkey = l_suppkey 
      AND ps_suppkey = l_suppkey 
      AND ps_partkey = l_partkey 
      AND p_partkey = l_partkey 
      AND o_orderkey = l_orderkey 
      AND s_nationkey = n_nationkey 
      AND p_name LIKE '%white%'
) AS profit
GROUP BY nation, o_year
ORDER BY nation, o_year DESC
LIMIT ALL;
```

### Optimization Steps

1. **Predicate Pushdown**: Move the condition `p_name LIKE '%white%'` closer to the table `part` to reduce the number of rows early in the query processing.
2. **Join Reordering**: Reorder joins to start with smaller tables or those reduced significantly by filters, which can reduce the size of intermediate results.
3. **Use Explicit JOIN Syntax**: Replace implicit joins (comma-separated) with explicit JOIN syntax for better readability and control over join conditions.
4. **Remove Redundant LIMIT**: `LIMIT ALL` is redundant as it does not limit the number of rows, so it can be removed.

### Optimized Query
```sql
SELECT nation, o_year, SUM(amount) AS sum_profit
FROM (
    SELECT n.n_name AS nation, 
           EXTRACT(YEAR FROM o.o_orderdate) AS o_year, 
           l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity AS amount
    FROM part p
    JOIN partsupp ps ON p.p_partkey = ps.ps_partkey
    JOIN lineitem l ON l.l_partkey = p.p_partkey AND l.l_suppkey = ps.ps_suppkey
    JOIN orders o ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n ON n.n_nationkey = s.s_nationkey
    WHERE p.p_name LIKE '%white%'
) AS profit
GROUP BY nation, o_year
ORDER BY nation, o_year DESC;
```

### Explanation of Optimizations
- **Predicate Pushdown**: The filter `p_name LIKE '%white%'` is applied directly after the `part` table is accessed, reducing the number of rows processed in subsequent joins.
- **Join Reordering**: The joins are reordered to start with `part` and `partsupp`, which are likely reduced by the predicate on `p_name`. This can help in reducing the size of the dataset early.
- **Explicit JOIN Syntax**: Using explicit `JOIN` clauses makes the join conditions clear and separates them from other filtering conditions, improving readability and potentially execution plan quality.
- **Remove Redundant LIMIT**: Removing `LIMIT ALL` simplifies the query without changing its behavior, as it does not impose any actual limit.