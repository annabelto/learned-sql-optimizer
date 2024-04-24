The given query is already syntactically correct. However, it can be optimized by reducing the number of tables in the join operation, using indexes, and using subqueries for filtering data. 

Here are the steps to optimize the query:

1. **Filtering Early**: Apply the filter conditions as early as possible to reduce the amount of data that needs to be processed. This can be done by using subqueries to filter data from the tables before joining them.

2. **Reducing Join Operations**: Reduce the number of tables in the join operation. If a table is only used for filtering data and not used in the select or group by clause, it can be moved to a subquery.

3. **Using Indexes**: Use indexes on the columns used in the join and where conditions. This can significantly speed up the query execution. 

4. **Avoiding Division Operation**: The division operation is expensive. If possible, avoid it by calculating the sum separately and then doing the division in the application code.

Here is the optimized query:

### Optimized Query

```sql
SELECT 
    o_year, 
    sum(case when nation = 'MOZAMBIQUE' then volume else 0 end) as mozambique_volume,
    sum(volume) as total_volume
FROM 
    (
        SELECT 
            extract(year from o_orderdate) as o_year, 
            l_extendedprice * (1 - l_discount) as volume, 
            n2.n_name as nation 
        FROM 
            part
        JOIN 
            lineitem ON p_partkey = l_partkey
        JOIN 
            orders ON l_orderkey = o_orderkey
        JOIN 
            (
                SELECT 
                    c_custkey, 
                    n1.n_nationkey 
                FROM 
                    customer
                JOIN 
                    nation n1 ON c_nationkey = n1.n_nationkey
                JOIN 
                    region ON n1.n_regionkey = r_regionkey
                WHERE 
                    r_name = 'AFRICA'
            ) sub1 ON o_custkey = sub1.c_custkey
        JOIN 
            (
                SELECT 
                    s_suppkey, 
                    n2.n_name 
                FROM 
                    supplier
                JOIN 
                    nation n2 ON s_nationkey = n2.n_nationkey
            ) sub2 ON l_suppkey = sub2.s_suppkey
        WHERE 
            o_orderdate between date '1995-01-01' and date '1996-12-31' 
            AND p_type = 'PROMO BRUSHED BRASS'
    ) as all_nations 
GROUP BY 
    o_year 
ORDER BY 
    o_year 
LIMIT ALL;
```

In this optimized query, the division operation is avoided by calculating the sum separately. The tables 'customer', 'nation', and 'region' are moved to a subquery to reduce the number of tables in the join operation. The filter conditions are applied in the subqueries to reduce the amount of data that needs to be processed.