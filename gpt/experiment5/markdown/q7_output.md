To further optimize the query and potentially achieve better performance than the original, we can consider additional strategies such as:

1. **Indexing**: Ensure that appropriate indexes are in place for the columns involved in joins and where conditions. This is not directly a query rewrite but a recommendation for database schema optimization.

2. **Materialized Views**: If the query is run frequently with the same parameters, consider using a materialized view to store the result of the subquery. This is more of a structural change and depends on the use case.

3. **Columnar Storage**: For analytical queries like this, using a columnar storage format can significantly improve performance. This is also a structural change.

4. **Reduce Row Width in Joins**: Minimize the data carried through the joins by selecting only the necessary columns early in the subqueries.

5. **Re-examine Join Conditions and Filters**: Ensure that the most selective filters are applied as early as possible.

Given that the previous optimizations did not yield the expected results, let's attempt a different approach while keeping the query structure mostly intact but focusing on the application of filters and joins.

### Optimized Query
```sql
SELECT 
    supp_nation, 
    cust_nation, 
    l_year, 
    SUM(volume) AS revenue
FROM 
    (
        SELECT 
            n1.n_name AS supp_nation, 
            n2.n_name AS cust_nation, 
            EXTRACT(year FROM l.l_shipdate) AS l_year, 
            l.l_extendedprice * (1 - l.l_discount) AS volume
        FROM 
            supplier AS s
        JOIN 
            nation AS n1 ON s.s_nationkey = n1.n_nationkey
        JOIN 
            lineitem AS l ON s.s_suppkey = l.l_suppkey
        JOIN 
            orders AS o ON l.l_orderkey = o.o_orderkey
        JOIN 
            customer AS c ON o.o_custkey = c.c_custkey
        JOIN 
            nation AS n2 ON c.c_nationkey = n2.n_nationkey
        WHERE 
            l.l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND ((n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') OR (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA'))
    ) AS shipping
GROUP BY 
    supp_nation, 
    cust_nation, 
    l_year
ORDER BY 
    supp_nation, 
    cust_nation, 
    l_year
LIMIT ALL;
```

### Changes Made:
- **Reordered Joins**: The joins are reordered to ensure that the most selective filters (`l.l_shipdate` and nation names) are applied as early as possible.
- **Selective Join Conditions**: Applied join conditions directly related to filtering criteria to reduce the amount of data being processed.

This query aims to utilize selective join conditions effectively and ensure that filtering happens early in the execution plan. Make sure to test this query and compare its performance against the original. If performance issues persist, consider structural changes like indexing or using a columnar storage format.