explain select 
    promotional_sales.promotions,
    all_sales.total,
    CAST(promotional_sales.promotions AS DECIMAL(15,4)) / CAST(all_sales.total AS DECIMAL(15,4)) * 100 AS promotion_ratio
FROM 
    (
        SELECT 
            SUM(ss_ext_sales_price) AS promotions
        FROM 
            store_sales
            INNER JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
            INNER JOIN store ON store_sales.ss_store_sk = store.s_store_sk
            INNER JOIN item ON store_sales.ss_item_sk = item.i_item_sk
            INNER JOIN promotion ON store_sales.ss_promo_sk = promotion.p_promo_sk
            INNER JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
            INNER JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
        WHERE 
            date_dim.d_year = 2000 AND 
            date_dim.d_moy = 12 AND 
            store.s_gmt_offset = -7 AND 
            item.i_category = 'Home' AND 
            (promotion.p_channel_dmail = 'Y' OR promotion.p_channel_email = 'Y' OR promotion.p_channel_tv = 'Y') AND 
            customer_address.ca_gmt_offset = -7
    ) AS promotional_sales,
    (
        SELECT 
            SUM(ss_ext_sales_price) AS total
        FROM 
            store_sales
            INNER JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
            INNER JOIN store ON store_sales.ss_store_sk = store.s_store_sk
            INNER JOIN item ON store_sales.ss_item_sk = item.i_item_sk
            INNER JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
            INNER JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
        WHERE 
            date_dim.d_year = 2000 AND 
            date_dim.d_moy = 12 AND 
            store.s_gmt_offset = -7 AND 
            item.i_category = 'Home' AND 
            customer_address.ca_gmt_offset = -7
    ) AS all_sales
ORDER BY 
    promotions, 
    total 
LIMIT 100;SELECT 
    promotional_sales.promotions,
    all_sales.total,
    CAST(promotional_sales.promotions AS DECIMAL(15,4)) / CAST(all_sales.total AS DECIMAL(15,4)) * 100 AS promotion_ratio
FROM 
    (
        SELECT 
            SUM(ss_ext_sales_price) AS promotions
        FROM 
            store_sales
            INNER JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
            INNER JOIN store ON store_sales.ss_store_sk = store.s_store_sk
            INNER JOIN item ON store_sales.ss_item_sk = item.i_item_sk
            INNER JOIN promotion ON store_sales.ss_promo_sk = promotion.p_promo_sk
            INNER JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
            INNER JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
        WHERE 
            date_dim.d_year = 2000 AND 
            date_dim.d_moy = 12 AND 
            store.s_gmt_offset = -7 AND 
            item.i_category = 'Home' AND 
            (promotion.p_channel_dmail = 'Y' OR promotion.p_channel_email = 'Y' OR promotion.p_channel_tv = 'Y') AND 
            customer_address.ca_gmt_offset = -7
    ) AS promotional_sales,
    (
        SELECT 
            SUM(ss_ext_sales_price) AS total
        FROM 
            store_sales
            INNER JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
            INNER JOIN store ON store_sales.ss_store_sk = store.s_store_sk
            INNER JOIN item ON store_sales.ss_item_sk = item.i_item_sk
            INNER JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
            INNER JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
        WHERE 
            date_dim.d_year = 2000 AND 
            date_dim.d_moy = 12 AND 
            store.s_gmt_offset = -7 AND 
            item.i_category = 'Home' AND 
            customer_address.ca_gmt_offset = -7
    ) AS all_sales
ORDER BY 
    promotions, 
    total 
LIMIT 100;