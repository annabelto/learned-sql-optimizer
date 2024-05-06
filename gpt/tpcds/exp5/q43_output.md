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
    s_store_name, 
    s_store_id, 
    SUM(CASE WHEN d_day_name = 'Sunday' THEN ss_sales_price ELSE NULL END) AS sun_sales, 
    SUM(CASE WHEN d_day_name = 'Monday' THEN ss_sales_price ELSE NULL END) AS mon_sales, 
    SUM(CASE WHEN d_day_name = 'Tuesday' THEN ss_sales_price ELSE NULL END) AS tue_sales, 
    SUM(CASE WHEN d_day_name = 'Wednesday' THEN ss_sales_price ELSE NULL END) AS wed_sales, 
    SUM(CASE WHEN d_day_name = 'Thursday' THEN ss_sales_price ELSE NULL END) AS thu_sales, 
    SUM(CASE WHEN d_day_name = 'Friday' THEN ss_sales_price ELSE NULL END) AS fri_sales, 
    SUM(CASE WHEN d_day_name = 'Saturday' THEN ss_sales_price ELSE NULL END) AS sat_sales 
FROM 
    store s
JOIN 
    store_sales ss ON s.s_store_sk = ss.ss_store_sk
JOIN 
    date_dim d ON d.d_date_sk = ss.ss_sold_date_sk
WHERE 
    s.s_gmt_offset = -5 
    AND d.d_year = 2000
GROUP BY 
    s_store_name, 
    s_store_id
ORDER BY 
    s_store_name, 
    s_store_id, 
    sun_sales, 
    mon_sales, 
    tue_sales, 
    wed_sales, 
    thu_sales, 
    fri_sales, 
    sat_sales 
LIMIT 100;
```

### Explanation of Changes

1. **Explicit Join Syntax**: I replaced the comma-separated list of tables in the FROM clause with explicit JOIN clauses.
2. **Explicit Join Conditions**: I moved the join conditions from the WHERE clause to the appropriate ON clauses in the JOIN statements.
3. **Filter Conditions**: Conditions that are not related to joining tables (such as `s.s_gmt_offset = -5` and `d.d_year = 2000`) remain in the WHERE clause, as they are filters applied after the joins are made.

These changes make the query more readable and maintainable, and they can also help the database optimizer to create more efficient execution plans by clearly distinguishing between join conditions and filters.