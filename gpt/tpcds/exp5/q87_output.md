To optimize the given query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Optimized Query

```sql
SELECT COUNT(*)
FROM (
    (
        SELECT DISTINCT c_last_name, c_first_name, d_date
        FROM store_sales
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
        WHERE d_month_seq BETWEEN 1202 AND 1213
    )
    EXCEPT
    (
        SELECT DISTINCT c_last_name, c_first_name, d_date
        FROM catalog_sales
        JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
        JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
        WHERE d_month_seq BETWEEN 1202 AND 1213
    )
    EXCEPT
    (
        SELECT DISTINCT c_last_name, c_first_name, d_date
        FROM web_sales
        JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
        JOIN customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk
        WHERE d_month_seq BETWEEN 1202 AND 1213
    )
) AS cool_cust;
```

### Explanation of Changes

1. **Explicit Join Syntax**: I replaced the comma-separated table list in the FROM clause with explicit JOIN clauses.
2. **Explicit Join Conditions**: I moved the join conditions from the WHERE clause to the ON clause of the respective JOINs.
3. **Filter Conditions**: I retained the filter conditions (`d_month_seq BETWEEN 1202 AND 1213`) in the WHERE clause as they are not directly related to the join conditions but are used to filter the result set after the joins are made.

These changes make the query more readable and maintainable, and they can potentially improve performance by allowing the database engine to better optimize the execution plan.