To optimize the given query, I will apply the following rules:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Original Query:
```sql
select s_name, count(*) as numwait 
from supplier, lineitem l1, orders, nation 
where s_suppkey = l1.l_suppkey 
and o_orderkey = l1.l_orderkey 
and o_orderstatus = 'F' 
and l1.l_receiptdate > l1.l_commitdate 
and exists (
    select * 
    from lineitem l2 
    where l2.l_orderkey = l1.l_orderkey 
    and l2.l_suppkey <> l1.l_suppkey
) 
and not exists (
    select * 
    from lineitem l3 
    where l3.l_orderkey = l1.l_orderkey 
    and l3.l_suppkey <> l1.l_suppkey 
    and l3.l_receiptdate > l3.l_commitdate
) 
and s_nationkey = n_nationkey 
and n_name = 'KENYA' 
group by s_name 
order by numwait desc, s_name 
LIMIT ALL;
```

### Optimized Query:
```sql
SELECT s_name, COUNT(*) AS numwait
FROM supplier
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
JOIN lineitem l1 ON supplier.s_suppkey = l1.l_suppkey
JOIN orders ON orders.o_orderkey = l1.l_orderkey AND orders.o_orderstatus = 'F'
WHERE l1.l_receiptdate > l1.l_commitdate
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
AND nation.n_name = 'KENYA'
GROUP BY s_name
ORDER BY numwait DESC, s_name
LIMIT ALL;
```

### Explanation of Changes:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated list of tables in the FROM clause with explicit JOIN syntax, specifying the join conditions using the ON clause. This makes the query more readable and aligns with modern SQL practices.
- **Rule 6:** I moved conditions that were part of the WHERE clause into the ON clause of the JOINs where appropriate. This can help improve performance by reducing the number of rows that need to be processed in the later stages of the query execution.
- Conditions related to the EXISTS and NOT EXISTS subqueries remain in the WHERE clause as they involve checking conditions across multiple rows and are not direct join conditions.

This rewritten query should be more efficient and easier to understand and maintain.