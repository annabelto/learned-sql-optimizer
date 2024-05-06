To further optimize the query for better performance, I will review the join order and ensure that filtering conditions are applied as early as possible to reduce the size of intermediate results. Additionally, I will ensure that the joins are structured in a way that leverages indexes effectively.

### Optimized Query

```sql
SELECT 
    n.n_name AS nation, 
    EXTRACT(YEAR FROM o.o_orderdate) AS o_year, 
    SUM(l.l_extendedprice * (1 - l.l_discount) - ps.ps_supplycost * l.l_quantity) AS sum_profit 
FROM 
    part p
    JOIN lineitem l ON p.p_partkey = l.l_partkey
    JOIN partsupp ps ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
    JOIN orders o ON o.o_orderkey = l.l_orderkey
    JOIN supplier s ON s.s_suppkey = l.l_suppkey
    JOIN nation n ON n.n_nationkey = s.s_nationkey
WHERE 
    p.p_name LIKE '%white%'
GROUP BY 
    n.n_name, 
    EXTRACT(YEAR FROM o.o_orderdate)
ORDER BY 
    n.n_name, 
    EXTRACT(YEAR FROM o.o_orderdate) DESC 
LIMIT ALL;
```

### Changes Made:

1. **Reordered Joins:** The joins have been reordered to start with the `part` table, which is filtered by `p_name LIKE '%white%'`. This should help in reducing the number of rows early in the query processing by leveraging the filter on the `part` table.

2. **Filtering Early:** By moving the filter on `p.p_name` to the earliest possible point in the join sequence, the query can eliminate many rows from consideration before performing more computationally expensive operations like multiple joins.

3. **Using Extract Function in Group By and Order By:** Directly using the `EXTRACT` function in the `GROUP BY` and `ORDER BY` clauses to ensure consistency and potentially leverage any functional indexes.

This approach aims to minimize the amount of data being processed by applying filters as early as possible and reordering joins to start with the most restrictive conditions. This should lead to performance improvements over the original query.