WITH FilteredData AS (
    SELECT ss.ss_ext_sales_price, ss.ss_promo_sk
    FROM store_sales ss
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
    JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
    JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    WHERE ca.ca_gmt_offset = -7
      AND i.i_category = 'Home'
      AND s.s_gmt_offset = -7
      AND d.d_year = 2000
      AND d.d_moy = 12
),
PromotionalSales AS (
    SELECT SUM(ss_ext_sales_price) AS promotions
    FROM FilteredData
    JOIN promotion p ON FilteredData.ss_promo_sk = p.p_promo_sk
    WHERE p.p_channel_dmail = 'Y' OR p.p_channel_email = 'Y' OR p.p_channel_tv = 'Y'
),
TotalSales AS (
    SELECT SUM(ss_ext_sales_price) AS total
    FROM FilteredData
)
explain select 
    p.promotions,
    t.total,
    CAST(p.promotions AS DECIMAL(15,4)) / CAST(t.total AS DECIMAL(15,4)) * 100 AS promotion_percentage
FROM PromotionalSales p, TotalSales t
ORDER BY p.promotions, t.total
LIMIT 100;WITH FilteredData AS (
    SELECT ss.ss_ext_sales_price, ss.ss_promo_sk
    FROM store_sales ss
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
    JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
    JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    WHERE ca.ca_gmt_offset = -7
      AND i.i_category = 'Home'
      AND s.s_gmt_offset = -7
      AND d.d_year = 2000
      AND d.d_moy = 12
),
PromotionalSales AS (
    SELECT SUM(ss_ext_sales_price) AS promotions
    FROM FilteredData
    JOIN promotion p ON FilteredData.ss_promo_sk = p.p_promo_sk
    WHERE p.p_channel_dmail = 'Y' OR p.p_channel_email = 'Y' OR p.p_channel_tv = 'Y'
),
TotalSales AS (
    SELECT SUM(ss_ext_sales_price) AS total
    FROM FilteredData
)
SELECT 
    p.promotions,
    t.total,
    CAST(p.promotions AS DECIMAL(15,4)) / CAST(t.total AS DECIMAL(15,4)) * 100 AS promotion_percentage
FROM PromotionalSales p, TotalSales t
ORDER BY p.promotions, t.total
LIMIT 100;