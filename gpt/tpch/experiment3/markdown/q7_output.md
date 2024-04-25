### Original Query

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
            EXTRACT(YEAR FROM l_shipdate) AS l_year, 
            l_extendedprice * (1 - l_discount) AS volume 
        FROM 
            supplier, 
            lineitem, 
            orders, 
            customer, 
            nation n1, 
            nation n2 
        WHERE 
            s_suppkey = l_suppkey 
            AND o_orderkey = l_orderkey 
            AND c_custkey = o_custkey 
            AND s_nationkey = n1.n_nationkey 
            AND c_nationkey = n2.n_nationkey 
            AND 
            (
                (n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') 
                OR 
                (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA')
            ) 
            AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
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

### Rewrite Rules

1. **Join Decomposition**: Break down the multiple table join into individual joins.
2. **Predicate Pushdown**: Move the predicates as close as possible to the base tables.
3. **Join Reordering**: Reorder the joins to reduce the size of intermediate results.

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
            EXTRACT(YEAR FROM l_shipdate) AS l_year, 
            l_extendedprice * (1 - l_discount) AS volume 
        FROM 
            lineitem 
        JOIN 
            supplier ON s_suppkey = l_suppkey 
        JOIN 
            nation n1 ON s_nationkey = n1.n_nationkey 
        JOIN 
            orders ON o_orderkey = l_orderkey 
        JOIN 
            customer ON c_custkey = o_custkey 
        JOIN 
            nation n2 ON c_nationkey = n2.n_nationkey 
        WHERE 
            l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND 
            (
                (n1.n_name = 'CANADA' AND n2.n_name = 'MOZAMBIQUE') 
                OR 
                (n1.n_name = 'MOZAMBIQUE' AND n2.n_name = 'CANADA')
            )
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