To optimize the given SQL query, we can apply several data-independent rewrite rules that help in reducing the amount of data processed and improve the execution plan. Here are the steps and rules applied:

1. **Push Selections Down (Predicate Pushdown)**: This rule moves the selection (filter) conditions as close as possible to the data sources. This reduces the number of rows processed in the subsequent steps of the query.

2. **Push Joins Down**: This rule rearranges joins to reduce the size of intermediate results by performing more selective joins earlier.

3. **Use of Proper Join Types**: Depending on the data distribution and indexes, using the appropriate join type (e.g., hash join, nested loop) can improve performance.

Here's the optimized query with explanations for each step:

```sql
SELECT 
    c.c_custkey, 
    c.c_name, 
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue,
    c.c_acctbal, 
    n.n_name, 
    c.c_address, 
    c.c_phone, 
    c.c_comment 
FROM 
    customer c
JOIN 
    orders o ON c.c_custkey = o.o_custkey
JOIN 
    lineitem l ON l.l_orderkey = o.o_orderkey
JOIN 
    nation n ON c.c_nationkey = n.n_nationkey
WHERE 
    o.o_orderdate >= DATE ':1' AND 
    o.o_orderdate < DATE ':1' + INTERVAL '3' MONTH AND 
    l.l_returnflag = 'R'
GROUP BY 
    c.c_custkey, c.c_name, c.c_acctbal, c.c_phone, n.n_name, c.c_address, c.c_comment 
ORDER BY 
    revenue DESC;
```

### Applied Rules and Explanation:

1. **Push Selections Down**: The conditions on `o_orderdate` and `l_returnflag` are applied directly in the `WHERE` clause, which is as close as possible to the table scans of `orders` and `lineitem`. This ensures that only relevant rows from these tables are considered early in the query processing.

2. **Push Joins Down**: The joins are structured in a way that filters through the `customer`, `orders`, and `lineitem` tables sequentially, which is likely efficient given the foreign key relationships and the filtering conditions. This reduces the size of intermediate results before they are combined, especially beneficial if `orders` and `lineitem` are large tables.

3. **Use of Proper Join Types**: While the specific join type (e.g., hash join) is typically chosen by the query optimizer based on statistics, ensuring that the joins are expressed clearly in the SQL can aid the optimizer. The use of explicit `JOIN` syntax (instead of commas in the `FROM` clause) helps clarify the relationships and can influence the optimizer's decisions.

By applying these rules, the query is structured to minimize the amount of data carried through the different stages of query execution, which should lead to improved performance. The exact impact, however, would depend on the specific database schema, indexes, and data distribution.