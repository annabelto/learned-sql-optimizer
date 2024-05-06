To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the performance without altering the semantics of the query. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates into the subqueries (or views) to reduce the number of rows processed and returned by each subquery. By applying filters earlier, we reduce the amount of data combined in the final stages of the query.

2. **Projection Pushdown**: This rule reduces the number of columns processed in the subqueries by pushing the projection of only necessary columns to the earliest possible point in the query.

3. **Eliminate Redundant Columns**: Remove columns from the SELECT clause that are not used elsewhere in the outer query or in the ORDER BY, GROUP BY clauses.

4. **Use of Proper Joins**: Replace implicit joins (comma-separated in FROM clause) with explicit JOIN syntax for better readability and potentially more efficient execution plans.

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
            d.d_year, 
            d.d_qoy, 
            i.i_category, 
            ss.ss_ext_sales_price AS ext_sales_price 
        FROM 
            store_sales ss
            JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
            JOIN item i ON ss.ss_item_sk = i.i_item_sk
        WHERE 
            ss.ss_customer_sk IS NULL

        UNION ALL 

        SELECT 
            'web' AS channel, 
            'ws_promo_sk' AS col_name, 
            d.d_year, 
            d.d_qoy, 
            i.i_category, 
            ws.ws_ext_sales_price AS ext_sales_price 
        FROM 
            web_sales ws
            JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
            JOIN item i ON ws.ws_item_sk = i.i_item_sk
        WHERE 
            ws.ws_promo_sk IS NULL

        UNION ALL 

        SELECT 
            'catalog' AS channel, 
            'cs_bill_customer_sk' AS col_name, 
            d.d_year, 
            d.d_qoy, 
            i.i_category, 
            cs.cs_ext_sales_price AS ext_sales_price 
        FROM 
            catalog_sales cs
            JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
            JOIN item i ON cs.cs_item_sk = i.i_item_sk
        WHERE 
            cs.cs_bill_customer_sk IS NULL
    ) foo 
GROUP BY 
    channel, col_name, d_year, d_qoy, i_category 
ORDER BY 
    channel, col_name, d_year, d_qoy, i_category 
LIMIT 100;
```

### Explanation:
- **Predicate Pushdown**: Filters like `ss_customer_sk IS NULL` are pushed down into the respective subqueries.
- **Projection Pushdown**: Only the necessary columns for the final output or required for JOINs and conditions are selected in the subqueries.
- **Eliminate Redundant Columns**: Removed any redundant columns that were not used.
- **Use of Proper Joins**: Changed the implicit joins to explicit JOIN syntax for clarity and potential performance improvement.

These optimizations should help in reducing the computational overhead and improving the query execution time by minimizing the amount of data shuffled between operations and focusing processing on relevant subsets of data.