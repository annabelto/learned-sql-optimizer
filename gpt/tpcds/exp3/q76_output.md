To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the performance without altering the semantics of the query. Here are the steps and rules applied:

1. **Predicate Pushdown**: This rule moves predicates (conditions) into the subqueries. This reduces the amount of data that needs to be processed in the outer query by filtering data earlier in the subqueries.

2. **Projection Pushdown**: This rule moves the projection of columns as close as possible to where they are first used. This reduces the number of columns being processed and carried through the query execution plan.

3. **Eliminate Redundant Columns**: Remove columns from the SELECT clause that are not used elsewhere in the query outside of the subquery.

4. **Use of Proper Joins**: Replace implicit joins (comma-separated in the FROM clause) with explicit JOIN syntax for clarity and potentially better optimization by the query planner.

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
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN item ON ss_item_sk = i_item_sk
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
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN item ON ws_item_sk = i_item_sk
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
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
        JOIN item ON cs_item_sk = i_item_sk
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

### Explanation of Changes:
- **Predicate Pushdown**: Moved the `WHERE` conditions into each respective subquery.
- **Projection Pushdown**: Ensured only necessary columns are selected in the subqueries.
- **Eliminate Redundant Columns**: Ensured that only columns used in the final output or conditions are selected.
- **Use of Proper Joins**: Changed the implicit joins to explicit `JOIN` syntax for better readability and optimization potential.

These changes should help in reducing the computational overhead and improving the query execution time by minimizing the amount of data shuffled and processed through different stages of the query.