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