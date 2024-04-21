To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the amount of data processed and the complexity of the operations. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates (filters) closer to the data source. By applying filters as early as possible, we reduce the number of rows and hence the amount of data that needs to be processed in later stages of the query.

2. **Use of JOIN Instead of Subquery**: Convert the subquery used with `NOT IN` into a `LEFT JOIN` and check for `NULL` values. This can be more efficient as it allows the database to better optimize the execution plan, especially when indexes are available.

3. **Elimination of Redundant Columns**: Remove columns from the SELECT clause that are not necessary for the final output or for the computations of aggregates.

Here's the optimized query with explanations for each step:

```sql
SELECT 
    p.p_brand, 
    p.p_type, 
    p.p_size, 
    COUNT(DISTINCT ps.ps_suppkey) AS supplier_cnt
FROM 
    part p
JOIN 
    partsupp ps ON p.p_partkey = ps.ps_partkey
LEFT JOIN 
    supplier s ON ps.ps_suppkey = s.s_suppkey AND s.s_comment LIKE '%Customer%Complaints%'
WHERE 
    p.p_brand <> 'Brand#24'
    AND p.p_type NOT LIKE 'STANDARD BURNISHED%'
    AND p.p_size IN (44, 6, 46, 36, 42, 17, 26, 18)
    AND s.s_suppkey IS NULL
GROUP BY 
    p.p_brand, 
    p.p_type, 
    p.p_size
ORDER BY 
    supplier_cnt DESC, 
    p.p_brand, 
    p.p_type, 
    p.p_size
LIMIT ALL;
```

### Explanation of Changes:
- **Predicate Pushdown**: Filters on `p_brand`, `p_type`, and `p_size` are applied directly in the `WHERE` clause of the main query, reducing the number of rows joined with `partsupp`.
- **Use of JOIN Instead of Subquery**: The subquery checking for `ps_suppkey` not in certain suppliers is replaced by a `LEFT JOIN` with the `supplier` table where `s_comment` matches a pattern, and then checking for `s.s_suppkey IS NULL` in the `WHERE` clause. This effectively filters out `partsupp` entries linked to the unwanted suppliers.
- **Elimination of Redundant Columns**: Only necessary columns for grouping and final output are included in the `SELECT` and `GROUP BY` clauses.

These optimizations should make the query more efficient by reducing the amount of data processed and leveraging joins and indexes more effectively.