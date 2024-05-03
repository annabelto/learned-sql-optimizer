WITH filtered_date AS (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_year = 2000
),
filtered_store AS (
    SELECT s_store_sk, s_store_name, s_store_id
    FROM store
    WHERE s_gmt_offset = -5
),
joined_data AS (
    SELECT 
        s_store_name, 
        s_store_id, 
        ss_sales_price, 
        d_day_name
    FROM store_sales
    JOIN filtered_date ON d_date_sk = ss_sold_date_sk
    JOIN filtered_store ON s_store_sk = ss_store_sk
)
SELECT
    s_store_name,
    s_store_id,
    SUM(CASE WHEN d_day_name = 'Sunday' THEN ss_sales_price ELSE NULL END) AS sun_sales,
    SUM(CASE WHEN d_day_name = 'Monday' THEN ss_sales_price ELSE NULL END) AS mon_sales,
    SUM(CASE WHEN d_day_name = 'Tuesday' THEN ss_sales_price ELSE NULL END) AS tue_sales,
    SUM(CASE WHEN d_day_name = 'Wednesday' THEN ss_sales_price ELSE NULL END) AS wed_sales,
    SUM(CASE WHEN d_day_name = 'Thursday' THEN ss_sales_price ELSE NULL END) AS thu_sales,
    SUM(CASE WHEN d_day_name = 'Friday' THEN ss_sales_price ELSE NULL END) AS fri_sales,
    SUM(CASE WHEN d_day_name = 'Saturday' THEN ss_sales_price ELSE NULL END) AS sat_sales
FROM joined_data
GROUP BY s_store_name, s_store_id
ORDER BY s_store_name, s_store_id, sun_sales, mon_sales, tue_sales, wed_sales, thu_sales, fri_sales, sat_sales
LIMIT 100;