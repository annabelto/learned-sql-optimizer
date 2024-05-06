To optimize the provided query, I will apply the following rules:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Optimized Query

```sql
WITH ss AS (
    SELECT i_item_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN item ON ss_item_sk = i_item_sk
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    JOIN customer_address ON ss_addr_sk = ca_address_sk
    WHERE i_item_id IN (SELECT i_item_id FROM item WHERE i_category IN ('Jewelry'))
      AND d_year = 2000
      AND d_moy = 10
      AND ca_gmt_offset = -5
    GROUP BY i_item_id
), 
cs AS (
    SELECT i_item_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN item ON cs_item_sk = i_item_sk
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    JOIN customer_address ON cs_bill_addr_sk = ca_address_sk
    WHERE i_item_id IN (SELECT i_item_id FROM item WHERE i_category IN ('Jewelry'))
      AND d_year = 2000
      AND d_moy = 10
      AND ca_gmt_offset = -5
    GROUP BY i_item_id
), 
ws AS (
    SELECT i_item_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN item ON ws_item_sk = i_item_sk
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    JOIN customer_address ON ws_bill_addr_sk = ca_address_sk
    WHERE i_item_id IN (SELECT i_item_id FROM item WHERE i_category IN ('Jewelry'))
      AND d_year = 2000
      AND d_moy = 10
      AND ca_gmt_offset = -5
    GROUP BY i_item_id
)
SELECT i_item_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) AS tmp1
GROUP BY i_item_id
ORDER BY i_item_id, total_sales
LIMIT 100;
```

### Explanation of Changes:
- **Rule 1, 2, 3, 4, 5:** I replaced the comma-separated table list in the FROM clause with explicit JOIN syntax and moved the join conditions from the WHERE clause to the ON clause of the respective JOINs. This makes the query more readable and aligns with modern SQL practices.
- **Rule 6:** Conditions that were logically part of the join (such as linking foreign keys and primary keys) were moved to the ON clause. This can help the query optimizer by reducing the dataset earlier during query execution.
- **General:** The subquery for `i_item_id` in the WHERE clause remains unchanged as it is a filtering condition based on the item category, which does not directly relate to the JOIN operations.

These changes should make the query more efficient and easier to understand and maintain.