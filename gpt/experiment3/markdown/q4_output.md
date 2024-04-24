### Original Query
```sql
SELECT o_orderpriority, COUNT(*) AS order_count 
FROM orders 
WHERE o_orderdate >= date '1996-01-01' 
AND o_orderdate < date '1996-01-01' + interval '3' month 
AND EXISTS ( SELECT * 
             FROM lineitem 
             WHERE l_orderkey = o_orderkey 
             AND l_commitdate < l_receiptdate ) 
GROUP BY o_orderpriority 
ORDER BY o_orderpriority 
LIMIT ALL;
```

### Optimization Steps

1. **Use JOIN instead of subquery**: Subqueries can be slower than JOINs, especially in EXISTS clause. We can replace the subquery with a JOIN to the lineitem table.

2. **Use COUNT(column) instead of COUNT(*)**: COUNT(*) counts all rows, including nulls. If we know that a certain column will never be null, we can count that column instead, which can be faster.

3. **Remove unnecessary LIMIT clause**: The LIMIT ALL clause is unnecessary and can be removed. It doesn't limit the number of rows returned, so it doesn't affect the result of the query.

### Optimized Query
```sql
SELECT o.o_orderpriority, COUNT(o.o_orderkey) AS order_count 
FROM orders o
JOIN lineitem l ON o.o_orderkey = l.l_orderkey 
WHERE o.o_orderdate >= date '1996-01-01' 
AND o.o_orderdate < date '1996-01-01' + interval '3' month 
AND l.l_commitdate < l.l_receiptdate 
GROUP BY o.o_orderpriority 
ORDER BY o.o_orderpriority;
```