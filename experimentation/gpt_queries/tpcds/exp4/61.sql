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