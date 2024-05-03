To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the performance without altering the result set. The rules applied here include:

1. **Predicate Pushdown**: Move filter conditions closer to the data source to reduce the amount of data processed and transferred in the later stages of the query.
2. **Common Sub-expression Elimination**: Identify and eliminate redundant calculations or subqueries to avoid repeated work.
3. **Join Elimination**: Remove unnecessary joins if they do not contribute to the final result.
4. **Column Pruning**: Select only the necessary columns in the subqueries to reduce the amount of data processed.

### Original Query Analysis
The original query consists of three common table expressions (CTEs) `ws`, `cs`, and `ss`, which represent aggregated sales data from web, catalog, and store channels respectively. These CTEs are then joined and used in the final SELECT statement to compute various metrics.

### Applying Optimization Rules

#### 1. Predicate Pushdown
We can push the condition `ss_sold_year=1998` into the CTE `ss` to reduce the amount of data processed in this CTE.

#### 2. Common Sub-expression Elimination
The expressions `coalesce(ws_qty,0)`, `coalesce(cs_qty,0)`, `coalesce(ws_wc,0)`, `coalesce(cs_wc,0)`, `coalesce(ws_sp,0)`, and `coalesce(cs_sp,0)` are used multiple times in the final SELECT statement. We can compute these once in each respective CTE and reuse them.

#### 3. Join Elimination
Currently, all joins appear necessary for the final output, so no joins can be eliminated without changing the result.

#### 4. Column Pruning
Ensure that only necessary columns are fetched in each subquery.

### Optimized Query
```sql
WITH ws AS (
    SELECT
        d_year AS ws_sold_year,
        ws_item_sk,
        ws_bill_customer_sk AS ws_customer_sk,
        sum(ws_quantity) AS ws_qty,
        sum(ws_wholesale_cost) AS ws_wc,
        sum(ws_sales_price) AS ws_sp,
        coalesce(sum(ws_quantity), 0) AS co_ws_qty,
        coalesce(sum(ws_wholesale_cost), 0) AS co_ws_wc,
        coalesce(sum(ws_sales_price), 0) AS co_ws_sp
    FROM web_sales
    LEFT JOIN web_returns ON wr_order_number = ws_order_number AND ws_item_sk = wr_item_sk
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    WHERE wr_order_number IS NULL
    GROUP BY d_year, ws_item_sk, ws_bill_customer_sk
), cs AS (
    SELECT
        d_year AS cs_sold_year,
        cs_item_sk,
        cs_bill_customer_sk AS cs_customer_sk,
        sum(cs_quantity) AS cs_qty,
        sum(cs_wholesale_cost) AS cs_wc,
        sum(cs_sales_price) AS cs_sp,
        coalesce(sum(cs_quantity), 0) AS co_cs_qty,
        coalesce(sum(cs_wholesale_cost), 0) AS co_cs_wc,
        coalesce(sum(cs_sales_price), 0) AS co_cs_sp
    FROM catalog_sales
    LEFT JOIN catalog_returns ON cr_order_number = cs_order_number AND cs_item_sk = cr_item_sk
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    WHERE cr_order_number IS NULL
    GROUP BY d_year, cs_item_sk, cs_bill_customer_sk
), ss AS (
    SELECT
        d_year AS ss_sold_year,
        ss_item_sk,
        ss_customer_sk,
        sum(ss_quantity) AS ss_qty,
        sum(ss_wholesale_cost) AS ss_wc,
        sum(ss_sales_price) AS ss_sp
    FROM store_sales
    LEFT JOIN store_returns ON sr_ticket_number = ss_ticket_number AND ss_item_sk = sr_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE sr_ticket_number IS NULL AND d_year = 1998
    GROUP BY d_year, ss_item_sk, ss_customer_sk
)
SELECT
    ss_customer_sk,
    round(ss_qty / (co_ws_qty + co_cs_qty), 2) AS ratio,
    ss_qty AS store_qty,
    ss_wc AS store_wholesale_cost,
    ss_sp AS store_sales_price,
    co_ws_qty + co_cs_qty AS other_chan_qty,
    co_ws_wc + co_cs_wc AS other_chan_wholesale_cost,
    co_ws_sp + co_cs_sp AS other_chan_sales_price
FROM ss
LEFT JOIN ws ON ws_sold_year = ss_sold_year AND ws_item_sk = ss_item_sk AND ws_customer_sk = ss_customer_sk
LEFT JOIN cs ON cs_sold_year = ss_sold_year AND cs_item_sk = ss_item_sk AND cs_customer_sk = ss_customer_sk
WHERE (co_ws_qty > 0 OR co_cs_qty > 0)
ORDER BY ss_customer_sk, ss_qty DESC, ss_wc DESC, ss_sp DESC, other_chan_qty, other_chan_wholesale_cost, other_chan_sales_price, ratio
LIMIT 100;
```

This optimized query should perform better due to reduced data processing and more efficient use of resources.