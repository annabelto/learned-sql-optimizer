To optimize the given SQL query, we can apply several data-independent rewrite rules that improve the performance without altering the result. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves filters as close as possible to the data source. By applying this rule, we can reduce the number of rows processed in the joins by filtering data earlier in the query execution.

2. **Join Reordering**: This rule changes the order of joins to minimize the size of intermediate results. It's beneficial to join smaller tables or the most restrictive tables earlier.

3. **Use of Explicit Joins**: Changing implicit joins (comma-separated in the FROM clause) to explicit JOIN syntax can improve readability and often performance, as it makes the join conditions clearer and allows the database more flexibility in execution planning.

Here's the optimized query with the rules applied:

```sql
SELECT 
    n1.n_name AS supp_nation, 
    n2.n_name AS cust_nation, 
    EXTRACT(year FROM l.l_shipdate) AS l_year, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue
FROM 
    supplier s
JOIN 
    nation n1 ON s.s_nationkey = n1.n_nationkey
JOIN 
    lineitem l ON s.s_suppkey = l.l_suppkey
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
JOIN 
    customer c ON o.c_custkey = c.c_custkey
JOIN 
    nation n2 ON c.c_nationkey = n2.n_nationkey
WHERE 
    ((n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA'))
    AND l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
GROUP BY 
    n1.n_name, n2.n_name, EXTRACT(year FROM l.l_shipdate)
ORDER BY 
    n1.n_name, n2.n_name, EXTRACT(year FROM l.l_shipdate)
LIMIT ALL;
```

### Explanation of Changes:
- **Predicate Pushdown**: The conditions on `l_shipdate` and the nations' names are pushed down into the WHERE clause before the joins occur. This reduces the number of rows being joined.
- **Join Reordering**: The joins are reordered to start with `supplier` and `nation`, which are filtered by nation keys and then connected to `lineitem`, `orders`, and `customer`. This order might be more efficient depending on the distribution and indexing of the keys.
- **Use of Explicit Joins**: The query now uses explicit JOIN syntax, which is generally clearer and can be more efficient.

These changes should help in optimizing the query execution by reducing the amount of data being processed and clarifying the join conditions for the query planner.