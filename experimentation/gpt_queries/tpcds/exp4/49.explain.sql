explain select channel, item, return_ratio, return_rank, currency_rank
FROM (
    SELECT 'web' AS channel,
           ws.ws_item_sk AS item,
           return_ratio,
           return_rank,
           currency_rank
    FROM (
        SELECT ws.ws_item_sk,
               CAST(SUM(COALESCE(wr.wr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_quantity) AS DECIMAL(15,4)), 0) AS return_ratio,
               CAST(SUM(COALESCE(wr.wr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_net_paid) AS DECIMAL(15,4)), 0) AS currency_ratio,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(wr.wr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_quantity) AS DECIMAL(15,4)), 0)) AS return_rank,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(wr.wr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_net_paid) AS DECIMAL(15,4)), 0)) AS currency_rank
        FROM web_sales ws
        LEFT JOIN web_returns wr ON ws.ws_order_number = wr.wr_order_number AND ws.ws_item_sk = wr.wr_item_sk
        JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
        WHERE wr.wr_return_amt > 10000 AND ws.ws_net_profit > 1 AND ws.ws_net_paid > 0 AND ws.ws_quantity > 0 AND d.d_year = 1998 AND d.d_moy = 11
        GROUP BY ws.ws_item_sk
    ) AS web_sales_data
    WHERE return_rank <= 10 OR currency_rank <= 10

    UNION ALL

    SELECT 'catalog' AS channel,
           cs.cs_item_sk AS item,
           return_ratio,
           return_rank,
           currency_rank
    FROM (
        SELECT cs.cs_item_sk,
               CAST(SUM(COALESCE(cr.cr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_quantity) AS DECIMAL(15,4)), 0) AS return_ratio,
               CAST(SUM(COALESCE(cr.cr_return_amount, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_net_paid) AS DECIMAL(15,4)), 0) AS currency_ratio,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(cr.cr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_quantity) AS DECIMAL(15,4)), 0)) AS return_rank,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(cr.cr_return_amount, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_net_paid) AS DECIMAL(15,4)), 0)) AS currency_rank
        FROM catalog_sales cs
        LEFT JOIN catalog_returns cr ON cs.cs_order_number = cr.cr_order_number AND cs.cs_item_sk = cr.cr_item_sk
        JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
        WHERE cr.cr_return_amount > 10000 AND cs.cs_net_profit > 1 AND cs.cs_net_paid > 0 AND cs.cs_quantity > 0 AND d.d_year = 1998 AND d.d_moy = 11
        GROUP BY cs.cs_item_sk
    ) AS catalog_sales_data
    WHERE return_rank <= 10 OR currency_rank <= 10

    UNION ALL

    SELECT 'store' AS channel,
           ss.ss_item_sk AS item,
           return_ratio,
           return_rank,
           currency_rank
    FROM (
        SELECT ss.ss_item_sk,
               CAST(SUM(COALESCE(sr.sr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_quantity) AS DECIMAL(15,4)), 0) AS return_ratio,
               CAST(SUM(COALESCE(sr.sr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_net_paid) AS DECIMAL(15,4)), 0) AS currency_ratio,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(sr.sr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_quantity) AS DECIMAL(15,4)), 0)) AS return_rank,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(sr.sr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_net_paid) AS DECIMAL(15,4)), 0)) AS currency_rank
        FROM store_sales ss
        LEFT JOIN store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number AND ss.ss_item_sk = sr.sr_item_sk
        JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE sr.sr_return_amt > 10000 AND ss.ss_net_profit > 1 AND ss.ss_net_paid > 0 AND ss.ss_quantity > 0 AND d.d_year = 1998 AND d.d_moy = 11
        GROUP BY ss.ss_item_sk
    ) AS store_sales_data
    WHERE return_rank <= 10 OR currency_rank <= 10
) AS final_results
ORDER BY channel, return_rank, currency_rank, item
LIMIT 100;SELECT channel, item, return_ratio, return_rank, currency_rank
FROM (
    SELECT 'web' AS channel,
           ws.ws_item_sk AS item,
           return_ratio,
           return_rank,
           currency_rank
    FROM (
        SELECT ws.ws_item_sk,
               CAST(SUM(COALESCE(wr.wr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_quantity) AS DECIMAL(15,4)), 0) AS return_ratio,
               CAST(SUM(COALESCE(wr.wr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_net_paid) AS DECIMAL(15,4)), 0) AS currency_ratio,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(wr.wr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_quantity) AS DECIMAL(15,4)), 0)) AS return_rank,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(wr.wr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ws.ws_net_paid) AS DECIMAL(15,4)), 0)) AS currency_rank
        FROM web_sales ws
        LEFT JOIN web_returns wr ON ws.ws_order_number = wr.wr_order_number AND ws.ws_item_sk = wr.wr_item_sk
        JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
        WHERE wr.wr_return_amt > 10000 AND ws.ws_net_profit > 1 AND ws.ws_net_paid > 0 AND ws.ws_quantity > 0 AND d.d_year = 1998 AND d.d_moy = 11
        GROUP BY ws.ws_item_sk
    ) AS web_sales_data
    WHERE return_rank <= 10 OR currency_rank <= 10

    UNION ALL

    SELECT 'catalog' AS channel,
           cs.cs_item_sk AS item,
           return_ratio,
           return_rank,
           currency_rank
    FROM (
        SELECT cs.cs_item_sk,
               CAST(SUM(COALESCE(cr.cr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_quantity) AS DECIMAL(15,4)), 0) AS return_ratio,
               CAST(SUM(COALESCE(cr.cr_return_amount, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_net_paid) AS DECIMAL(15,4)), 0) AS currency_ratio,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(cr.cr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_quantity) AS DECIMAL(15,4)), 0)) AS return_rank,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(cr.cr_return_amount, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(cs.cs_net_paid) AS DECIMAL(15,4)), 0)) AS currency_rank
        FROM catalog_sales cs
        LEFT JOIN catalog_returns cr ON cs.cs_order_number = cr.cr_order_number AND cs.cs_item_sk = cr.cr_item_sk
        JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
        WHERE cr.cr_return_amount > 10000 AND cs.cs_net_profit > 1 AND cs.cs_net_paid > 0 AND cs.cs_quantity > 0 AND d.d_year = 1998 AND d.d_moy = 11
        GROUP BY cs.cs_item_sk
    ) AS catalog_sales_data
    WHERE return_rank <= 10 OR currency_rank <= 10

    UNION ALL

    SELECT 'store' AS channel,
           ss.ss_item_sk AS item,
           return_ratio,
           return_rank,
           currency_rank
    FROM (
        SELECT ss.ss_item_sk,
               CAST(SUM(COALESCE(sr.sr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_quantity) AS DECIMAL(15,4)), 0) AS return_ratio,
               CAST(SUM(COALESCE(sr.sr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_net_paid) AS DECIMAL(15,4)), 0) AS currency_ratio,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(sr.sr_return_quantity, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_quantity) AS DECIMAL(15,4)), 0)) AS return_rank,
               rank() OVER (ORDER BY CAST(SUM(COALESCE(sr.sr_return_amt, 0)) AS DECIMAL(15,4)) / NULLIF(CAST(SUM(ss.ss_net_paid) AS DECIMAL(15,4)), 0)) AS currency_rank
        FROM store_sales ss
        LEFT JOIN store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number AND ss.ss_item_sk = sr.sr_item_sk
        JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
        WHERE sr.sr_return_amt > 10000 AND ss.ss_net_profit > 1 AND ss.ss_net_paid > 0 AND ss.ss_quantity > 0 AND d.d_year = 1998 AND d.d_moy = 11
        GROUP BY ss.ss_item_sk
    ) AS store_sales_data
    WHERE return_rank <= 10 OR currency_rank <= 10
) AS final_results
ORDER BY channel, return_rank, currency_rank, item
LIMIT 100;