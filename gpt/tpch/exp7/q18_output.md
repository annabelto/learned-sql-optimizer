To optimize the provided query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Original Query:
```sql
select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_quantity)
from customer, orders, lineitem
where o_orderkey in (
    select l_orderkey
    from lineitem
    group by l_orderkey
    having sum(l_quantity) > 313
)
and c_custkey = o_custkey
and o_orderkey = l_orderkey
group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice
order by o_totalprice desc, o_orderdate
LIMIT ALL;
```

### Step-by-step Optimization:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause**:
   Replace the comma-separated list of tables with explicit JOIN syntax.

2. **Replace implicit joins with explicit joins** and **Use JOIN instead of WHERE for linking tables**:
   Convert the WHERE conditions that link tables into explicit JOIN conditions.

3. **Use explicit join conditions** and **Move conditions from WHERE clause to ON clause in JOINs**:
   Move the join-related conditions from the WHERE clause to the ON clause of the corresponding JOIN.

### Optimized Query:
```sql
SELECT c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, SUM(l_quantity)
FROM customer
JOIN orders ON c_custkey = o_custkey
JOIN lineitem ON o_orderkey = l_orderkey
WHERE o_orderkey IN (
    SELECT l_orderkey
    FROM lineitem
    GROUP BY l_orderkey
    HAVING SUM(l_quantity) > 313
)
GROUP BY c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice
ORDER BY o_totalprice DESC, o_orderdate
LIMIT ALL;
```

This rewritten query uses explicit JOIN syntax and moves conditions to the appropriate ON clauses, making the query easier to read and potentially more efficient for execution by the database engine, as it can better optimize join operations.