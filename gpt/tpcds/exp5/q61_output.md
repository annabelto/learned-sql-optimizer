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
    promotions,
    total,
    CAST(promotions AS DECIMAL(15,4)) / CAST(total AS DECIMAL(15,4)) * 100
FROM 
    (
        SELECT 
            SUM(ss_ext_sales_price) AS promotions
        FROM 
            store_sales
            JOIN store ON ss_store_sk = s_store_sk
            JOIN promotion ON ss_promo_sk = p_promo_sk
            JOIN date_dim ON ss_sold_date_sk = d_date_sk
            JOIN customer ON ss_customer_sk = c_customer_sk
            JOIN customer_address ON ca_address_sk = c_current_addr_sk
            JOIN item ON ss_item_sk = i_item_sk
        WHERE 
            ca_gmt_offset = -7 
            AND i_category = 'Home'
            AND (p_channel_dmail = 'Y' OR p_channel_email = 'Y' OR p_channel_tv = 'Y')
            AND s_gmt_offset = -7
            AND d_year = 2000
            AND d_moy = 12
    ) AS promotional_sales
CROSS JOIN 
    (
        SELECT 
            SUM(ss_ext_sales_price) AS total
        FROM 
            store_sales
            JOIN store ON ss_store_sk = s_store_sk
            JOIN date_dim ON ss_sold_date_sk = d_date_sk
            JOIN customer ON ss_customer_sk = c_customer_sk
            JOIN customer_address ON ca_address_sk = c_current_addr_sk
            JOIN item ON ss_item_sk = i_item_sk
        WHERE 
            ca_gmt_offset = -7 
            AND i_category = 'Home'
            AND s_gmt_offset = -7
            AND d_year = 2000
            AND d_moy = 12
    ) AS all_sales
ORDER BY 
    promotions, 
    total 
LIMIT 100;
```

### Explanation of Changes:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated list of tables with explicit `JOIN` clauses, specifying the join conditions using the `ON` keyword. This makes the query more readable and aligns with modern SQL practices.
- **Rule 6:** I moved conditions related to the join (like `ss_store_sk = s_store_sk`) from the `WHERE` clause to the `ON` clause of the respective joins. Conditions that are not directly related to the join (like `ca_gmt_offset = -7`) remain in the `WHERE` clause.
- I used `CROSS JOIN` for combining the results of the two subqueries (`promotional_sales` and `all_sales`) because there is no direct join condition between these two result sets. This is appropriate as each subquery aggregates data independently.

These changes should help in improving the readability and potentially the performance of the query by making better use of indexes and join optimizations available in PostgreSQL.