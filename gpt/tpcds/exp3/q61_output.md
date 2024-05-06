I apologize for the confusion in previous responses. Let's ensure the optimized query maintains the exact logic and structure of the original query, focusing on correctness and potential optimizations that do not alter the output.

### Optimized Query
```sql
WITH promotional_sales AS (
    SELECT 
        SUM(ss_ext_sales_price) AS promotions
    FROM 
        store_sales
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    JOIN promotion ON store_sales.ss_promo_sk = promotion.p_promo_sk
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
    JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        customer_address.ca_gmt_offset = -7 AND
        item.i_category = 'Home' AND
        store.s_gmt_offset = -7 AND
        date_dim.d_year = 2000 AND
        date_dim.d_moy = 12 AND
        (promotion.p_channel_dmail = 'Y' OR promotion.p_channel_email = 'Y' OR promotion.p_channel_tv = 'Y')
),
all_sales AS (
    SELECT 
        SUM(ss_ext_sales_price) AS total
    FROM 
        store_sales
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
    JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        customer_address.ca_gmt_offset = -7 AND
        item.i_category = 'Home' AND
        store.s_gmt_offset = -7 AND
        date_dim.d_year = 2000 AND
        date_dim.d_moy = 12
)
SELECT 
    promotions,
    total,
    (CAST(promotions AS DECIMAL(15,4)) / CAST(total AS DECIMAL(15,4))) * 100 AS promotion_percentage
FROM 
    promotional_sales,
    all_sales
ORDER BY 
    promotions, 
    total 
LIMIT 100;
```

This query should now correctly replicate the functionality of the original query. The main changes include:

1. **Use of Common Table Expressions (CTEs)**: This helps in isolating the logic for calculating promotional and total sales, which can make the query easier to read and maintain. It also potentially allows the database engine to optimize the execution by materializing the intermediate results.

2. **Maintaining Original Logic**: All conditions and joins from the original query are preserved to ensure the output matches exactly.

3. **Correct Calculation of Percentage**: The percentage calculation now correctly uses the `CAST` function to ensure the division is performed in decimal context, matching the original query's intent.

This query should now provide the correct results as per the original query while being structured for better readability and potential performance improvements through the use of CTEs.