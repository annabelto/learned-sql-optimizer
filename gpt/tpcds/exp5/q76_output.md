To optimize the given query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Optimized Query

```sql
SELECT 
    channel, 
    col_name, 
    d_year, 
    d_qoy, 
    i_category, 
    COUNT(*) AS sales_cnt, 
    SUM(ext_sales_price) AS sales_amt 
FROM 
(
    SELECT 
        'store' AS channel, 
        'ss_customer_sk' AS col_name, 
        d_year, 
        d_qoy, 
        i_category, 
        ss_ext_sales_price AS ext_sales_price 
    FROM 
        store_sales
        JOIN item ON ss_item_sk = i_item_sk
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE 
        ss_customer_sk IS NULL

    UNION ALL 

    SELECT 
        'web' AS channel, 
        'ws_promo_sk' AS col_name, 
        d_year, 
        d_qoy, 
        i_category, 
        ws_ext_sales_price AS ext_sales_price 
    FROM 
        web_sales
        JOIN item ON ws_item_sk = i_item_sk
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
    WHERE 
        ws_promo_sk IS NULL

    UNION ALL 

    SELECT 
        'catalog' AS channel, 
        'cs_bill_customer_sk' AS col_name, 
        d_year, 
        d_qoy, 
        i_category, 
        cs_ext_sales_price AS ext_sales_price 
    FROM 
        catalog_sales
        JOIN item ON cs_item_sk = i_item_sk
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
    WHERE 
        cs_bill_customer_sk IS NULL
) foo 
GROUP BY 
    channel, 
    col_name, 
    d_year, 
    d_qoy, 
    i_category 
ORDER BY 
    channel, 
    col_name, 
    d_year, 
    d_qoy, 
    i_category 
LIMIT 100;
```

### Explanation of Changes

- **Rule 1, 2, 3, 4, 5**: I replaced the comma-separated table list in the FROM clause with explicit JOIN syntax and specified the join conditions using the ON clause. This makes the query more readable and aligns with modern SQL practices.
- **Rule 6**: I moved the conditions that link the tables (e.g., `ss_sold_date_sk = d_date_sk`) from the WHERE clause to the ON clause in the JOINs. This helps in understanding the relationship between the tables directly in the JOIN clause and can help the database optimizer to create a more efficient execution plan.

These changes should make the query more efficient and easier to maintain.