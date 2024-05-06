To ensure the optimized query matches the output of the original query while addressing the type mismatch issues and maintaining the logical structure, let's carefully reconstruct the query with correct joins and subquery usage.

### Optimized Query
```sql
WITH jewelry_items AS (
    SELECT i_item_id
    FROM item
    WHERE i_category = 'Jewelry'
),
ss AS (
    SELECT i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    JOIN customer_address ON ss_addr_sk = ca_address_sk
    JOIN item ON ss_item_sk = item.i_item_sk
    WHERE d_year = 2000 AND d_moy = 10 AND ca_gmt_offset = -5
    AND item.i_item_id IN (SELECT i_item_id FROM jewelry_items)
    GROUP BY i_item_id
),
cs AS (
    SELECT i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    JOIN customer_address ON cs_bill_addr_sk = ca_address_sk
    JOIN item ON cs_item_sk = item.i_item_sk
    WHERE d_year = 2000 AND d_moy = 10 AND ca_gmt_offset = -5
    AND item.i_item_id IN (SELECT i_item_id FROM jewelry_items)
    GROUP BY i_item_id
),
ws AS (
    SELECT i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    JOIN customer_address ON ws_bill_addr_sk = ca_address_sk
    JOIN item ON ws_item_sk = item.i_item_sk
    WHERE d_year = 2000 AND d_moy = 10 AND ca_gmt_offset = -5
    AND item.i_item_id IN (SELECT i_item_id FROM jewelry_items)
    GROUP BY i_item_id
)
SELECT i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) AS combined_sales
GROUP BY i_item_id
ORDER BY i_item_id, total_sales DESC
LIMIT 100;
```

### Explanation:
1. **CTE `jewelry_items`**: This CTE selects `i_item_id` from the `item` table where the category is 'Jewelry'. This is used to filter items in each sales table (`store_sales`, `catalog_sales`, `web_sales`).

2. **Subqueries `ss`, `cs`, `ws`**: Each subquery joins the respective sales table with `date_dim`, `customer_address`, and `item`. The `WHERE` clause includes conditions on `d_year`, `d_moy`, `ca_gmt_offset`, and checks if `item.i_item_id` is in the list of jewelry item IDs. This ensures that only sales for jewelry items are considered.

3. **Final Selection**: The final SELECT statement aggregates total sales from all three sources (`ss`, `cs`, `ws`), grouped by `i_item_id`. The results are ordered by `i_item_id` and `total_sales` in descending order, with a limit of 100 rows.

This query should now correctly optimize the original query by maintaining the logical structure and ensuring data type compatibility in joins, while also potentially improving performance by filtering early in the subqueries.