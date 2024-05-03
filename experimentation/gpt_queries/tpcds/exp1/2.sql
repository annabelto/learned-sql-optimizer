WITH wscs AS (
    SELECT sold_date_sk, sales_price
    FROM (
        SELECT ws_sold_date_sk AS sold_date_sk, ws_ext_sales_price AS sales_price
        FROM web_sales
        UNION ALL
        SELECT cs_sold_date_sk AS sold_date_sk, cs_ext_sales_price AS sales_price
        FROM catalog_sales
    ) AS foo
),
wswscs AS (
    SELECT d_week_seq,
           SUM(CASE WHEN d_day_name = 'Sunday' THEN sales_price ELSE NULL END) AS sun_sales,
           SUM(CASE WHEN d_day_name = 'Monday' THEN sales_price ELSE NULL END) AS mon_sales,
           SUM(CASE WHEN d_day_name = 'Tuesday' THEN sales_price ELSE NULL END) AS tue_sales,
           SUM(CASE WHEN d_day_name = 'Wednesday' THEN sales_price ELSE NULL END) AS wed_sales,
           SUM(CASE WHEN d_day_name = 'Thursday' THEN sales_price ELSE NULL END) AS thu_sales,
           SUM(CASE WHEN d_day_name = 'Friday' THEN sales_price ELSE NULL END) AS fri_sales,
           SUM(CASE WHEN d_day_name = 'Saturday' THEN sales_price ELSE NULL END) AS sat_sales
    FROM wscs
    JOIN date_dim ON d_date_sk = sold_date_sk
    GROUP BY d_week_seq
),
yearly_sales AS (
    SELECT d_week_seq, sun_sales, mon_sales, tue_sales, wed_sales, thu_sales, fri_sales, sat_sales
    FROM wswscs
    JOIN date_dim ON date_dim.d_week_seq = wswscs.d_week_seq
    WHERE d_year IN (1998, 1999)
)
SELECT y.d_week_seq AS d_week_seq1,
       ROUND(y.sun_sales / z.sun_sales, 2) AS sun_ratio,
       ROUND(y.mon_sales / z.mon_sales, 2) AS mon_ratio,
       ROUND(y.tue_sales / z.tue_sales, 2) AS tue_ratio,
       ROUND(y.wed_sales / z.wed_sales, 2) AS wed_ratio,
       ROUND(y.thu_sales / z.thu_sales, 2) AS thu_ratio,
       ROUND(y.fri_sales / z.fri_sales, 2) AS fri_ratio,
       ROUND(y.sat_sales / z.sat_sales, 2) AS sat_ratio
FROM yearly_sales y
JOIN yearly_sales z ON y.d_week_seq = z.d_week_seq - 53
WHERE y.d_year = 1998 AND z.d_year = 1999
ORDER BY y.d_week_seq;