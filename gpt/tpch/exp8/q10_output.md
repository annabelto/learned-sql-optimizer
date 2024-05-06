### Optimized Query
```sql
SELECT 
    c_custkey, 
    c_name, 
    SUM(l_extendedprice * (1 - l_discount)) AS revenue, 
    c_acctbal, 
    n_name, 
    c_address, 
    c_phone, 
    c_comment 
FROM 
    customer
JOIN 
    orders ON customer.c_custkey = orders.o_custkey
    AND orders.o_orderdate >= DATE '1995-01-01' 
    AND orders.o_orderdate < DATE '1995-01-01' + INTERVAL '3' month
JOIN 
    lineitem ON orders.o_orderkey = lineitem.l_orderkey
    AND lineitem.l_returnflag = 'R'
JOIN 
    nation ON customer.c_nationkey = nation.n_nationkey
GROUP BY 
    c_custkey, 
    c_name, 
    c_acctbal, 
    n_name, 
    c_address, 
    c_phone, 
    c_comment 
ORDER BY 
    revenue DESC 
LIMIT 20;
```

This query revision aims to optimize performance by pushing the filtering conditions into the JOIN clauses where applicable. This can potentially reduce the number of rows processed in the joins before they reach the aggregation stage, which might improve performance depending on the database's execution plan and indexing strategy.