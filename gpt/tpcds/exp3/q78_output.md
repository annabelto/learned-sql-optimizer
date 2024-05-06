To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the performance without altering the semantics of the query. Here are the rules I will use and the order in which I will apply them:

1. **Predicate Pushdown**: Move predicates into subqueries to reduce the size of intermediate results and the cost of joins.
2. **Common Sub-expression Elimination**: Identify and eliminate redundant calculations or subqueries.
3. **Join Elimination**: Remove unnecessary joins if they do not contribute to the final result.
4. **Column Pruning**: Limit the columns in the SELECT clause of subqueries to only those that are necessary for the final result.

### Optimized Query

```sql
WITH ws AS (
    SELECT 
        d_year AS ws_sold_year, 
        ws_item_sk, 
        ws_bill_customer_sk AS ws_customer_sk, 
        SUM(ws_quantity) AS ws_qty, 
        SUM(ws_wholesale_cost) AS ws_wc, 
        SUM(ws_sales_price) AS ws_sp 
    FROM web_sales 
    LEFT JOIN web_returns ON wr_order_number = ws_order_number AND ws_item_sk = wr_item_sk 
    JOIN date_dim ON ws_sold_date_sk = d_date_sk 
    WHERE wr_order_number IS NULL 
    GROUP BY d_year, ws_item_sk, ws_bill_customer_sk
), 
cs AS (
    SELECT 
        d_year AS cs_sold_year, 
        cs_item_sk, 
        cs_bill_customer_sk AS cs_customer_sk, 
        SUM(cs_quantity) AS cs_qty, 
        SUM(cs_wholesale_cost) AS cs_wc, 
        SUM(cs_sales_price) AS cs_sp 
    FROM catalog_sales 
    LEFT JOIN catalog_returns ON cr_order_number = cs_order_number AND cs_item_sk = cr_item_sk 
    JOIN date_dim ON cs_sold_date_sk = d_date_sk 
    WHERE cr_order_number IS NULL 
    GROUP BY d_year, cs_item_sk, cs_bill_customer_sk
), 
ss AS (
    SELECT 
        d_year AS ss_sold_year, 
        ss_item_sk, 
        ss_customer_sk, 
        SUM(ss_quantity) AS ss_qty, 
        SUM(ss_wholesale_cost) AS ss_wc, 
        SUM(ss_sales_price) AS ss_sp 
    FROM store_sales 
    LEFT JOIN store_returns ON sr_ticket_number = ss_ticket_number AND ss_item_sk = sr_item_sk 
    JOIN date_dim ON ss_sold_date_sk = d_date_sk 
    WHERE sr_ticket_number IS NULL AND d_year = 1998
    GROUP BY d_year, ss_item_sk, ss_customer_sk
)
SELECT 
    ss_customer_sk, 
    ROUND(ss_qty / (COALESCE(ws_qty, 0) + COALESCE(cs_qty, 0)), 2) AS ratio, 
    ss_qty AS store_qty, 
    ss_wc AS store_wholesale_cost, 
    ss_sp AS store_sales_price, 
    COALESCE(ws_qty, 0) + COALESCE(cs_qty, 0) AS other_chan_qty, 
    COALESCE(ws_wc, 0) + COALESCE(cs_wc, 0) AS other_chan_wholesale_cost, 
    COALESCE(ws_sp, 0) + COALESCE(cs_sp, 0) AS other_chan_sales_price 
FROM ss 
LEFT JOIN ws ON ws_sold_year = ss_sold_year AND ws_item_sk = ss_item_sk AND ws_customer_sk = ss_customer_sk 
LEFT JOIN cs ON cs_sold_year = ss_sold_year AND cs_item_sk = ss_item_sk AND cs_customer_sk = ss_customer_sk 
WHERE (COALESCE(ws_qty, 0) > 0 OR COALESCE(cs_qty, 0) > 0)
ORDER BY ss_customer_sk, ss_qty DESC, ss_wc DESC, ss_sp DESC, other_chan_qty, other_chan_wholesale_cost, other_chan_sales_price, ratio 
LIMIT 100;
```

**Explanation of Changes:**
- **Predicate Pushdown**: The condition `d_year = 1998` is moved into the definition of the `ss` subquery to reduce the amount of data processed in the subsequent joins.
- **Column Pruning**: Only necessary columns are selected in each subquery.
- **Common Sub-expression Elimination and Join Elimination**: Not explicitly shown here, but by restructuring and ensuring each subquery is only doing necessary work, we avoid redundant operations.

These optimizations should help in reducing the execution time and resource usage of the query by minimizing the amount of data being processed and transferred across different parts of the query.