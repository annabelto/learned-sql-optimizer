### Original Query
```sql
SELECT s_name, COUNT(*) AS numwait
FROM supplier, lineitem l1, orders, nation
WHERE s_suppkey = l1.l_suppkey
  AND o_orderkey = l1.l_orderkey
  AND o_orderstatus = 'F'
  AND l1.l_receiptdate > l1.l_commitdate
  AND EXISTS (
    SELECT * 
    FROM lineitem l2 
    WHERE l2.l_orderkey = l1.l_orderkey 
      AND l2.l_suppkey <> l1.l_suppkey
  )
  AND NOT EXISTS (
    SELECT * 
    FROM lineitem l3 
    WHERE l3.l_orderkey = l1.l_orderkey 
      AND l3.l_suppkey <> l1.l_suppkey 
      AND l3.l_receiptdate > l3.l_commitdate
  )
  AND s_nationkey = n_nationkey
  AND n_name = 'KENYA'
GROUP BY s_name
ORDER BY numwait DESC, s_name
LIMIT ALL;
```

### Optimization Steps

1. **Use Explicit Joins**: Replace implicit joins with explicit `JOIN` syntax for better readability and control.
2. **Push Predicates**: Move conditions into the `ON` clause of the joins where possible, which can help the optimizer by reducing the number of rows early in the query processing.
3. **Column Pruning in Subqueries**: In the `EXISTS` and `NOT EXISTS` subqueries, select only 1 instead of `*` since we are only checking for existence.
4. **Remove Redundant `LIMIT ALL`**: `LIMIT ALL` is functionally the same as omitting the `LIMIT` clause entirely.

### Optimized Query
```sql
SELECT s_name, COUNT(*) AS numwait
FROM supplier
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
JOIN lineitem l1 ON supplier.s_suppkey = l1.l_suppkey
JOIN orders ON l1.l_orderkey = orders.o_orderkey
WHERE orders.o_orderstatus = 'F'
  AND l1.l_receiptdate > l1.l_commitdate
  AND nation.n_name = 'KENYA'
  AND EXISTS (
    SELECT 1
    FROM lineitem l2
    WHERE l2.l_orderkey = l1.l_orderkey
      AND l2.l_suppkey <> l1.l_suppkey
  )
  AND NOT EXISTS (
    SELECT 1
    FROM lineitem l3
    WHERE l3.l_orderkey = l1.l_orderkey
      AND l3.l_suppkey <> l1.l_suppkey
      AND l3.l_receiptdate > l3.l_commitdate
  )
GROUP BY s_name
ORDER BY numwait DESC, s_name;
```

This rewritten query uses explicit joins and moves conditions into the join clauses where appropriate, improving the potential for the query optimizer to execute the query more efficiently. The subqueries are simplified to check existence without retrieving unnecessary data, and the redundant `LIMIT ALL` is removed.