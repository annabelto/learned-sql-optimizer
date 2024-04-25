WITH date_range AS (
    SELECT d_date_sk, d_date
    FROM date_dim
    WHERE d_month_seq BETWEEN 1212 AND 1223
),
web_v1 AS (
    SELECT ws_item_sk AS item_sk, d_date, 
           SUM(ws_sales_price) OVER (PARTITION BY ws_item_sk ORDER BY d_date 
                                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cume_sales
    FROM web_sales
    JOIN date_range ON ws_sold_date_sk = date_range.d_date_sk
    WHERE ws_item_sk IS NOT NULL
    GROUP BY ws_item_sk, d_date
),
store_v1 AS (
    SELECT ss_item_sk AS item_sk, d_date, 
           SUM(ss_sales_price) OVER (PARTITION BY ss_item_sk ORDER BY d_date 
                                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cume_sales
    FROM store_sales
    JOIN date_range ON ss_sold_date_sk = date_range.d_date_sk
    WHERE ss_item_sk IS NOT NULL
    GROUP BY ss_item_sk, d_date
)
explain select *
FROM (
    SELECT item_sk, d_date, web_sales, store_sales,
           MAX(web_sales) OVER (PARTITION BY item_sk ORDER BY d_date 
                                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS web_cumulative,
           MAX(store_sales) OVER (PARTITION BY item_sk ORDER BY d_date 
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_cumulative
    FROM (
        SELECT COALESCE(web.item_sk, store.item_sk) AS item_sk,
               COALESCE(web.d_date, store.d_date) AS d_date,
               web.cume_sales AS web_sales,
               store.cume_sales AS store_sales
        FROM web_v1 web
        FULL OUTER JOIN store_v1 store ON web.item_sk = store.item_sk AND web.d_date = store.d_date
    ) x
) y
WHERE web_cumulative > store_cumulative
ORDER BY item_sk, d_date
LIMIT 100;WITH date_range AS (
    SELECT d_date_sk, d_date
    FROM date_dim
    WHERE d_month_seq BETWEEN 1212 AND 1223
),
web_v1 AS (
    SELECT ws_item_sk AS item_sk, d_date, 
           SUM(ws_sales_price) OVER (PARTITION BY ws_item_sk ORDER BY d_date 
                                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cume_sales
    FROM web_sales
    JOIN date_range ON ws_sold_date_sk = date_range.d_date_sk
    WHERE ws_item_sk IS NOT NULL
    GROUP BY ws_item_sk, d_date
),
store_v1 AS (
    SELECT ss_item_sk AS item_sk, d_date, 
           SUM(ss_sales_price) OVER (PARTITION BY ss_item_sk ORDER BY d_date 
                                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cume_sales
    FROM store_sales
    JOIN date_range ON ss_sold_date_sk = date_range.d_date_sk
    WHERE ss_item_sk IS NOT NULL
    GROUP BY ss_item_sk, d_date
)
SELECT *
FROM (
    SELECT item_sk, d_date, web_sales, store_sales,
           MAX(web_sales) OVER (PARTITION BY item_sk ORDER BY d_date 
                                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS web_cumulative,
           MAX(store_sales) OVER (PARTITION BY item_sk ORDER BY d_date 
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_cumulative
    FROM (
        SELECT COALESCE(web.item_sk, store.item_sk) AS item_sk,
               COALESCE(web.d_date, store.d_date) AS d_date,
               web.cume_sales AS web_sales,
               store.cume_sales AS store_sales
        FROM web_v1 web
        FULL OUTER JOIN store_v1 store ON web.item_sk = store.item_sk AND web.d_date = store.d_date
    ) x
) y
WHERE web_cumulative > store_cumulative
ORDER BY item_sk, d_date
LIMIT 100;