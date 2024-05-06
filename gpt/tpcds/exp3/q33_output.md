I apologize for the previous misunderstandings. Let's ensure that the optimized query strictly adheres to the logic of the original query, maintaining the exact output while applying optimization techniques correctly.

### Optimized Query

```sql
WITH ss AS (
    SELECT i_manufact_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN item ON ss_item_sk = i_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    JOIN customer_address ON ss_addr_sk = ca_address_sk
    WHERE i_category = 'Books'
      AND d_year = 2001
      AND d_moy = 3
      AND ca_gmt_offset = -5
    GROUP BY i_manufact_id
),
cs AS (
    SELECT i_manufact_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN item ON cs_item_sk = i_item_sk
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    JOIN customer_address ON cs_bill_addr_sk = ca_address_sk
    WHERE i_category = 'Books'
      AND d_year = 2001
      AND d_moy = 3
      AND ca_gmt_offset = -5
    GROUP BY i_manufact_id
),
ws AS (
    SELECT i_manufact_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN item ON ws_item_sk = i_item_sk
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    JOIN customer_address ON ws_bill_addr_sk = ca_address_sk
    WHERE i_category = 'Books'
      AND d_year = 2001
      AND d_moy = 3
      AND ca_gmt_offset = -5
    GROUP BY i_manufact_id
)
SELECT i_manufact_id, SUM(total_sales) AS total_sales
FROM (
    SELECT i_manufact_id, total_sales FROM ss
    UNION ALL
    SELECT i_manufact_id, total_sales FROM cs
    UNION ALL
    SELECT i_manufact_id, total_sales FROM ws
) combined_sales
GROUP BY i_manufact_id
ORDER BY total_sales DESC
LIMIT 100;
```

### Explanation of Changes:
- **Direct Category Filter**: Instead of creating a separate CTE for filtering items by category, the category filter is applied directly in the main queries for store sales, catalog sales, and web sales. This ensures that only items from the 'Books' category are considered.
- **Join and Filter Conditions**: All necessary joins and filters are maintained as per the original query, ensuring that the data context (year, month, and GMT offset) is correctly applied.
- **UNION ALL**: Continues to use `UNION ALL` for combining results from different sales tables, maintaining the integrity of the data by not removing any duplicates.

This version of the query should now correctly reflect the logic of the original query while incorporating optimizations for better performance.