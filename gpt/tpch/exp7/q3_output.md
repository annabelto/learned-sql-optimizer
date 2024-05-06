To optimize the provided query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Optimized Query

```sql
SELECT 
    l_orderkey, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
    o_orderdate, 
    o_shippriority 
FROM 
    customer 
JOIN 
    orders ON c_custkey = o_custkey 
JOIN 
    lineitem ON l_orderkey = o_orderkey 
WHERE 
    c_mktsegment = 'AUTOMOBILE' 
    AND o_orderdate < DATE '1995-03-20' 
    AND l_shipdate > DATE '1995-03-20' 
GROUP BY 
    l_orderkey, o_orderdate, o_shippriority 
ORDER BY 
    revenue DESC, o_orderdate 
LIMIT ALL;
```

### Explanation of Changes

1. **Rule 1, 2, 3, 4, 5**: I replaced the comma-separated list of tables in the FROM clause with explicit JOIN syntax. Each table is now joined using the JOIN keyword, and the conditions that link these tables are specified in the ON clause of each JOIN.

2. **Rule 6**: I moved the join conditions from the WHERE clause to the ON clause in the JOINs. This helps in clearly separating the join conditions from the filter conditions, which can improve readability and potentially the performance, as the join conditions can be evaluated early in the query execution plan.

This rewritten query now uses explicit JOIN syntax and separates join conditions from filter conditions, adhering to best practices for SQL queries in PostgreSQL.