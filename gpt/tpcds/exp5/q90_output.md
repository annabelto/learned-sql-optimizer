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
    CAST(amc AS DECIMAL(15,4)) / CAST(pmc AS DECIMAL(15,4)) AS am_pm_ratio 
FROM 
    (
        SELECT COUNT(*) AS amc 
        FROM web_sales
        JOIN time_dim ON ws_sold_time_sk = time_dim.t_time_sk
        JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
        JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
        WHERE time_dim.t_hour BETWEEN 12 AND 13
          AND household_demographics.hd_dep_count = 6
          AND web_page.wp_char_count BETWEEN 5000 AND 5200
    ) AS at,
    (
        SELECT COUNT(*) AS pmc 
        FROM web_sales
        JOIN time_dim ON ws_sold_time_sk = time_dim.t_time_sk
        JOIN household_demographics ON ws_ship_hdemo_sk = household_demographics.hd_demo_sk
        JOIN web_page ON ws_web_page_sk = web_page.wp_web_page_sk
        WHERE time_dim.t_hour BETWEEN 14 AND 15
          AND household_demographics.hd_dep_count = 6
          AND web_page.wp_char_count BETWEEN 5000 AND 5200
    ) AS pt
ORDER BY am_pm_ratio 
LIMIT 100;
```

### Explanation of Changes:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated table list in the FROM clause with explicit JOIN syntax, specifying the join conditions using the ON keyword. This makes the query more readable and aligns with modern SQL practices.
- **Rule 6:** I moved the conditions related to specific tables directly into the ON clauses of the respective JOINs where possible. However, in this case, the conditions that are not directly part of the join (like `time_dim.t_hour BETWEEN 12 AND 13`) remain in the WHERE clause as they do not directly relate to the join condition but rather filter the results post-join.

This optimized query should be more efficient and clearer in intent, especially in terms of how tables are related and how data is filtered.