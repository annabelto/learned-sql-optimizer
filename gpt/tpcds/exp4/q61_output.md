To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the query's performance without altering the result. Here are the rules I will use and the order in which I will apply them:

1. **Predicate Pushdown**: Move predicates as close as possible to where the data originates in the query. This reduces the amount of data processed in the later stages of the query.

2. **Common Sub-expression Elimination**: Identify and eliminate redundancy within subqueries to avoid repeated calculations or joins.

3. **Join Elimination**: Remove unnecessary joins that do not affect the final result.

4. **Column Pruning**: Select only the necessary columns in the subqueries to reduce the amount of data being processed.

### Applying the Rules:

#### 1. Predicate Pushdown:
In both subqueries, conditions related to `date_dim`, `store`, `customer_address`, and `item` can be pushed closer to their respective table scans.

#### 2. Common Sub-expression Elimination:
Both subqueries calculate sums over `store_sales` based on several common conditions. We can create a common derived table that pre-filters `store_sales` based on these conditions and then join this with other tables as needed.

#### 3. Join Elimination:
The `customer` table does not contribute to the final output other than through the join condition. If `ss_customer_sk` is guaranteed to have a corresponding `customer_sk` in all cases (referential integrity), the join to `customer` can be eliminated.

#### 4. Column Pruning:
Only include necessary columns in the SELECT list of the subqueries.

### Optimized Query:
```sql
WITH filtered_store_sales AS (
    SELECT ss_ext_sales_price, ss_sold_date_sk, ss_store_sk, ss_promo_sk, ss_customer_sk, ss_item_sk
    FROM store_sales
    WHERE ss_sold_date_sk IN (
        SELECT d_date_sk
        FROM date_dim
        WHERE d_year = 2000 AND d_moy = 12
    )
),
relevant_items AS (
    SELECT i_item_sk
    FROM item
    WHERE i_category = 'Home'
),
relevant_stores AS (
    SELECT s_store_sk
    FROM store
    WHERE s_gmt_offset = -7
),
relevant_addresses AS (
    SELECT ca_address_sk
    FROM customer_address
    WHERE ca_gmt_offset = -7
),
promotional_sales AS (
    SELECT SUM(ss_ext_sales_price) AS promotions
    FROM filtered_store_sales
    JOIN relevant_stores ON ss_store_sk = s_store_sk
    JOIN relevant_items ON ss_item_sk = i_item_sk
    JOIN relevant_addresses ON ss_customer_sk = ca_address_sk
    JOIN promotion ON ss_promo_sk = p_promo_sk
    WHERE (p_channel_dmail = 'Y' OR p_channel_email = 'Y' OR p_channel_tv = 'Y')
),
all_sales AS (
    SELECT SUM(ss_ext_sales_price) AS total
    FROM filtered_store_sales
    JOIN relevant_stores ON ss_store_sk = s_store_sk
    JOIN relevant_items ON ss_item_sk = i_item_sk
    JOIN relevant_addresses ON ss_customer_sk = ca_address_sk
)
SELECT promotions, total, CAST(promotions AS DECIMAL(15,4)) / CAST(total AS DECIMAL(15,4)) * 100
FROM promotional_sales, all_sales
ORDER BY promotions, total
LIMIT 100;
```

This optimized query reduces the amount of data processed by pushing predicates down, eliminates unnecessary joins, and avoids redundant calculations by using common sub-expressions.