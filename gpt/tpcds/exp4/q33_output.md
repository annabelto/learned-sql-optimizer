To ensure the optimized query matches the output of the original query while still improving performance, I will carefully review and adjust the optimization techniques applied. The focus will be on maintaining the logical structure and correctness of the original query, ensuring that the optimizations do not alter the results.

### Optimized Query

```sql
WITH item_manufact_ids AS (
    SELECT DISTINCT i_manufact_id
    FROM item
    WHERE i_category = 'Books'
),
ss AS (
    SELECT i.i_manufact_id, SUM(ss_ext_sales_price) AS total_sales
    FROM store_sales
    JOIN item i ON ss_item_sk = i.i_item_sk
    JOIN date_dim d ON ss_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ss_addr_sk = ca_address_sk
    WHERE d_year = 2001 AND d_moy = 3 AND ca_gmt_offset = -5
      AND i.i_manufact_id IN (SELECT i_manufact_id FROM item_manufact_ids)
    GROUP BY i.i_manufact_id
),
cs AS (
    SELECT i.i_manufact_id, SUM(cs_ext_sales_price) AS total_sales
    FROM catalog_sales
    JOIN item i ON cs_item_sk = i.i_item_sk
    JOIN date_dim d ON cs_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON cs_bill_addr_sk = ca_address_sk
    WHERE d_year = 2001 AND d_moy = 3 AND ca_gmt_offset = -5
      AND i.i_manufact_id IN (SELECT i_manufact_id FROM item_manufact_ids)
    GROUP BY i.i_manufact_id
),
ws AS (
    SELECT i.i_manufact_id, SUM(ws_ext_sales_price) AS total_sales
    FROM web_sales
    JOIN item i ON ws_item_sk = i.i_item_sk
    JOIN date_dim d ON ws_sold_date_sk = d.d_date_sk
    JOIN customer_address ca ON ws_bill_addr_sk = ca_address_sk
    WHERE d_year = 2001 AND d_moy = 3 AND ca_gmt_offset = -5
      AND i.i_manufact_id IN (SELECT i_manufact_id FROM item_manufact_ids)
    GROUP BY i.i_manufact_id
)
SELECT i_manufact_id, SUM(total_sales) AS total_sales
FROM (
    SELECT * FROM ss
    UNION ALL
    SELECT * FROM cs
    UNION ALL
    SELECT * FROM ws
) combined_sales
GROUP BY i_manufact_id
ORDER BY total_sales DESC
LIMIT 100;
```

### Explanation of Changes

1. **Common Sub-expression Elimination**: The subquery that identifies `i_manufact_id` from items in the 'Books' category is extracted into a CTE named `item_manufact_ids`. This CTE is used in all three sales subqueries (`ss`, `cs`, `ws`), ensuring that the item filtering logic is consistent and not repeated.

2. **Predicate Pushdown**: The predicates related to the `date_dim` and `customer_address` tables are pushed down into the respective joins in each sales subquery. This ensures that filtering happens as early as possible, reducing the amount of data processed in subsequent operations.

3. **Maintaining Logical Structure**: The overall structure of the query, including the use of `UNION ALL` and the final aggregation, remains unchanged to ensure that the results match the original query.

These optimizations aim to reduce redundancy and improve the efficiency of data processing without altering the results of the query.