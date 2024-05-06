To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the query's performance without altering the result set. The rules applied here include:

1. **Predicate Pushdown**: Move conditions into the subquery or join condition to reduce the number of rows processed early in the execution.
2. **Projection Pushdown**: Limit the columns retrieved in the early stages of the query to only those necessary for the final result.
3. **Join Reordering**: Although not explicitly applied here due to the lack of multiple join paths, it's generally a good practice to consider the size and filters of each table being joined.
4. **Use of Common Table Expressions (CTEs)**: This can make the query more readable and sometimes helps in execution by materializing intermediate results.

### Optimized Query

```sql
WITH filtered_date AS (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_year = 2000
),
filtered_store AS (
    SELECT s_store_sk, s_store_name, s_store_id
    FROM store
    WHERE s_gmt_offset = -5
),
joined_data AS (
    SELECT 
        s_store_name, 
        s_store_id, 
        ss_sales_price, 
        d_day_name
    FROM store_sales
    JOIN filtered_date ON d_date_sk = ss_sold_date_sk
    JOIN filtered_store ON s_store_sk = ss_store_sk
)
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
FROM joined_data
GROUP BY s_store_name, s_store_id
ORDER BY s_store_name, s_store_id, sun_sales, mon_sales, tue_sales, wed_sales, thu_sales, fri_sales, sat_sales
LIMIT 100;
```

### Explanation of Changes:
- **CTEs**: `filtered_date` and `filtered_store` are used to pre-filter `date_dim` and `store` tables based on the conditions provided. This reduces the amount of data joined in `joined_data`.
- **Join Conditions**: Moved the conditions into the join itself, which can help the database optimize the join order and method.
- **Column Selection**: In the CTEs, only necessary columns are selected to reduce data movement and improve cache usage.

These changes should help in reducing the execution time and resource usage of the query by minimizing the amount of data processed and focusing on necessary computations.