WITH wss AS (
    SELECT 
        d_week_seq, 
        ss_store_sk, 
        sum(CASE WHEN (d_day_name='Sunday') THEN ss_sales_price ELSE NULL END) AS sun_sales,
        sum(CASE WHEN (d_day_name='Monday') THEN ss_sales_price ELSE NULL END) AS mon_sales,
        sum(CASE WHEN (d_day_name='Tuesday') THEN ss_sales_price ELSE NULL END) AS tue_sales,
        sum(CASE WHEN (d_day_name='Wednesday') THEN ss_sales_price ELSE NULL END) AS wed_sales,
        sum(CASE WHEN (d_day_name='Thursday') THEN ss_sales_price ELSE NULL END) AS thu_sales,
        sum(CASE WHEN (d_day_name='Friday') THEN ss_sales_price ELSE NULL END) AS fri_sales,
        sum(CASE WHEN (d_day_name='Saturday') THEN ss_sales_price ELSE NULL END) AS sat_sales
    FROM 
        store_sales
    JOIN 
        date_dim ON d_date_sk = ss_sold_date_sk
    GROUP BY 
        d_week_seq, ss_store_sk
)
explain select 
    s_store_name1,
    s_store_id1,
    d_week_seq1,
    sun_sales1/sun_sales2 AS sun_ratio,
    mon_sales1/mon_sales2 AS mon_ratio,
    tue_sales1/tue_sales2 AS tue_ratio,
    wed_sales1/wed_sales2 AS wed_ratio,
    thu_sales1/thu_sales2 AS thu_ratio,
    fri_sales1/fri_sales2 AS fri_ratio,
    sat_sales1/sat_sales2 AS sat_ratio
FROM (
    SELECT 
        store.s_store_name AS s_store_name1,
        store.s_store_id AS s_store_id1,
        wss.d_week_seq AS d_week_seq1,
        wss.sun_sales AS sun_sales1,
        wss.mon_sales AS mon_sales1,
        wss.tue_sales AS tue_sales1,
        wss.wed_sales AS wed_sales1,
        wss.thu_sales AS thu_sales1,
        wss.fri_sales AS fri_sales1,
        wss.sat_sales AS sat_sales1
    FROM 
        wss
    JOIN 
        store ON wss.ss_store_sk = store.s_store_sk
    WHERE 
        EXISTS (
            SELECT 1 FROM date_dim d WHERE d.d_week_seq = wss.d_week_seq AND d.d_month_seq BETWEEN 1195 AND 1195 + 11
        )
) y
JOIN (
    SELECT 
        store.s_store_name AS s_store_name2,
        store.s_store_id AS s_store_id2,
        wss.d_week_seq AS d_week_seq2,
        wss.sun_sales AS sun_sales2,
        wss.mon_sales AS mon_sales2,
        wss.tue_sales AS tue_sales2,
        wss.wed_sales AS wed_sales2,
        wss.thu_sales AS thu_sales2,
        wss.fri_sales AS fri_sales2,
        wss.sat_sales AS sat_sales2
    FROM 
        wss
    JOIN 
        store ON wss.ss_store_sk = store.s_store_sk
    WHERE 
        EXISTS (
            SELECT 1 FROM date_dim d WHERE d.d_week_seq = wss.d_week_seq AND d.d_month_seq BETWEEN 1195 + 12 AND 1195 + 23
        )
) x ON y.s_store_id1 = x.s_store_id2 AND y.d_week_seq1 = x.d_week_seq2 - 52
ORDER BY 
    s_store_name1, s_store_id1, d_week_seq1
LIMIT 100;WITH wss AS (
    SELECT 
        d_week_seq, 
        ss_store_sk, 
        sum(CASE WHEN (d_day_name='Sunday') THEN ss_sales_price ELSE NULL END) AS sun_sales,
        sum(CASE WHEN (d_day_name='Monday') THEN ss_sales_price ELSE NULL END) AS mon_sales,
        sum(CASE WHEN (d_day_name='Tuesday') THEN ss_sales_price ELSE NULL END) AS tue_sales,
        sum(CASE WHEN (d_day_name='Wednesday') THEN ss_sales_price ELSE NULL END) AS wed_sales,
        sum(CASE WHEN (d_day_name='Thursday') THEN ss_sales_price ELSE NULL END) AS thu_sales,
        sum(CASE WHEN (d_day_name='Friday') THEN ss_sales_price ELSE NULL END) AS fri_sales,
        sum(CASE WHEN (d_day_name='Saturday') THEN ss_sales_price ELSE NULL END) AS sat_sales
    FROM 
        store_sales
    JOIN 
        date_dim ON d_date_sk = ss_sold_date_sk
    GROUP BY 
        d_week_seq, ss_store_sk
)
SELECT 
    s_store_name1,
    s_store_id1,
    d_week_seq1,
    sun_sales1/sun_sales2 AS sun_ratio,
    mon_sales1/mon_sales2 AS mon_ratio,
    tue_sales1/tue_sales2 AS tue_ratio,
    wed_sales1/wed_sales2 AS wed_ratio,
    thu_sales1/thu_sales2 AS thu_ratio,
    fri_sales1/fri_sales2 AS fri_ratio,
    sat_sales1/sat_sales2 AS sat_ratio
FROM (
    SELECT 
        store.s_store_name AS s_store_name1,
        store.s_store_id AS s_store_id1,
        wss.d_week_seq AS d_week_seq1,
        wss.sun_sales AS sun_sales1,
        wss.mon_sales AS mon_sales1,
        wss.tue_sales AS tue_sales1,
        wss.wed_sales AS wed_sales1,
        wss.thu_sales AS thu_sales1,
        wss.fri_sales AS fri_sales1,
        wss.sat_sales AS sat_sales1
    FROM 
        wss
    JOIN 
        store ON wss.ss_store_sk = store.s_store_sk
    WHERE 
        EXISTS (
            SELECT 1 FROM date_dim d WHERE d.d_week_seq = wss.d_week_seq AND d.d_month_seq BETWEEN 1195 AND 1195 + 11
        )
) y
JOIN (
    SELECT 
        store.s_store_name AS s_store_name2,
        store.s_store_id AS s_store_id2,
        wss.d_week_seq AS d_week_seq2,
        wss.sun_sales AS sun_sales2,
        wss.mon_sales AS mon_sales2,
        wss.tue_sales AS tue_sales2,
        wss.wed_sales AS wed_sales2,
        wss.thu_sales AS thu_sales2,
        wss.fri_sales AS fri_sales2,
        wss.sat_sales AS sat_sales2
    FROM 
        wss
    JOIN 
        store ON wss.ss_store_sk = store.s_store_sk
    WHERE 
        EXISTS (
            SELECT 1 FROM date_dim d WHERE d.d_week_seq = wss.d_week_seq AND d.d_month_seq BETWEEN 1195 + 12 AND 1195 + 23
        )
) x ON y.s_store_id1 = x.s_store_id2 AND y.d_week_seq1 = x.d_week_seq2 - 52
ORDER BY 
    s_store_name1, s_store_id1, d_week_seq1
LIMIT 100;