WITH ssr AS (
    SELECT 
        s_store_id AS store_id, 
        SUM(ss_ext_sales_price) AS sales, 
        SUM(COALESCE(sr_return_amt, 0)) AS returns, 
        SUM(ss_net_profit - COALESCE(sr_net_loss, 0)) AS profit 
    FROM 
        store_sales
        LEFT OUTER JOIN store_returns ON ss_item_sk = sr_item_sk AND ss_ticket_number = sr_ticket_number
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN store ON ss_store_sk = s_store_sk
        JOIN item ON ss_item_sk = i_item_sk
        JOIN promotion ON ss_promo_sk = p_promo_sk
    WHERE 
        d_date BETWEEN CAST('2002-08-14' AS DATE) AND (CAST('2002-08-14' AS DATE) + INTERVAL '30 day')
        AND i_current_price > 50 
        AND p_channel_tv = 'N'
    GROUP BY 
        s_store_id
), 
csr AS (
    SELECT 
        cp_catalog_page_id AS catalog_page_id, 
        SUM(cs_ext_sales_price) AS sales, 
        SUM(COALESCE(cr_return_amount, 0)) AS returns, 
        SUM(cs_net_profit - COALESCE(cr_net_loss, 0)) AS profit 
    FROM 
        catalog_sales
        LEFT OUTER JOIN catalog_returns ON cs_item_sk = cr_item_sk AND cs_order_number = cr_order_number
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
        JOIN catalog_page ON cs_catalog_page_sk = cp_catalog_page_sk
        JOIN item ON cs_item_sk = i_item_sk
        JOIN promotion ON cs_promo_sk = p_promo_sk
    WHERE 
        d_date BETWEEN CAST('2002-08-14' AS DATE) AND (CAST('2002-08-14' AS DATE) + INTERVAL '30 day')
        AND i_current_price > 50 
        AND p_channel_tv = 'N'
    GROUP BY 
        cp_catalog_page_id
), 
wsr AS (
    SELECT 
        web_site_id, 
        SUM(ws_ext_sales_price) AS sales, 
        SUM(COALESCE(wr_return_amt, 0)) AS returns, 
        SUM(ws_net_profit - COALESCE(wr_net_loss, 0)) AS profit 
    FROM 
        web_sales
        LEFT OUTER JOIN web_returns ON ws_item_sk = wr_item_sk AND ws_order_number = wr_order_number
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN web_site ON ws_web_site_sk = web_site_sk
        JOIN item ON ws_item_sk = i_item_sk
        JOIN promotion ON ws_promo_sk = p_promo_sk
    WHERE 
        d_date BETWEEN CAST('2002-08-14' AS DATE) AND (CAST('2002-08-14' AS DATE) + INTERVAL '30 day')
        AND i_current_price > 50 
        AND p_channel_tv = 'N'
    GROUP BY 
        web_site_id
)
explain select 
    channel, 
    id, 
    SUM(sales) AS sales, 
    SUM(returns) AS returns, 
    SUM(profit) AS profit 
FROM (
    SELECT 'store channel' AS channel, 'store' || store_id AS id, sales, returns, profit FROM ssr
    UNION ALL
    SELECT 'catalog channel' AS channel, 'catalog_page' || catalog_page_id AS id, sales, returns, profit FROM csr
    UNION ALL
    SELECT 'web channel' AS channel, 'web_site' || web_site_id AS id, sales, returns, profit FROM wsr
) x 
GROUP BY ROLLUP (channel, id) 
ORDER BY channel, id 
LIMIT 100;WITH ssr AS (
    SELECT 
        s_store_id AS store_id, 
        SUM(ss_ext_sales_price) AS sales, 
        SUM(COALESCE(sr_return_amt, 0)) AS returns, 
        SUM(ss_net_profit - COALESCE(sr_net_loss, 0)) AS profit 
    FROM 
        store_sales
        LEFT OUTER JOIN store_returns ON ss_item_sk = sr_item_sk AND ss_ticket_number = sr_ticket_number
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN store ON ss_store_sk = s_store_sk
        JOIN item ON ss_item_sk = i_item_sk
        JOIN promotion ON ss_promo_sk = p_promo_sk
    WHERE 
        d_date BETWEEN CAST('2002-08-14' AS DATE) AND (CAST('2002-08-14' AS DATE) + INTERVAL '30 day')
        AND i_current_price > 50 
        AND p_channel_tv = 'N'
    GROUP BY 
        s_store_id
), 
csr AS (
    SELECT 
        cp_catalog_page_id AS catalog_page_id, 
        SUM(cs_ext_sales_price) AS sales, 
        SUM(COALESCE(cr_return_amount, 0)) AS returns, 
        SUM(cs_net_profit - COALESCE(cr_net_loss, 0)) AS profit 
    FROM 
        catalog_sales
        LEFT OUTER JOIN catalog_returns ON cs_item_sk = cr_item_sk AND cs_order_number = cr_order_number
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
        JOIN catalog_page ON cs_catalog_page_sk = cp_catalog_page_sk
        JOIN item ON cs_item_sk = i_item_sk
        JOIN promotion ON cs_promo_sk = p_promo_sk
    WHERE 
        d_date BETWEEN CAST('2002-08-14' AS DATE) AND (CAST('2002-08-14' AS DATE) + INTERVAL '30 day')
        AND i_current_price > 50 
        AND p_channel_tv = 'N'
    GROUP BY 
        cp_catalog_page_id
), 
wsr AS (
    SELECT 
        web_site_id, 
        SUM(ws_ext_sales_price) AS sales, 
        SUM(COALESCE(wr_return_amt, 0)) AS returns, 
        SUM(ws_net_profit - COALESCE(wr_net_loss, 0)) AS profit 
    FROM 
        web_sales
        LEFT OUTER JOIN web_returns ON ws_item_sk = wr_item_sk AND ws_order_number = wr_order_number
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN web_site ON ws_web_site_sk = web_site_sk
        JOIN item ON ws_item_sk = i_item_sk
        JOIN promotion ON ws_promo_sk = p_promo_sk
    WHERE 
        d_date BETWEEN CAST('2002-08-14' AS DATE) AND (CAST('2002-08-14' AS DATE) + INTERVAL '30 day')
        AND i_current_price > 50 
        AND p_channel_tv = 'N'
    GROUP BY 
        web_site_id
)
SELECT 
    channel, 
    id, 
    SUM(sales) AS sales, 
    SUM(returns) AS returns, 
    SUM(profit) AS profit 
FROM (
    SELECT 'store channel' AS channel, 'store' || store_id AS id, sales, returns, profit FROM ssr
    UNION ALL
    SELECT 'catalog channel' AS channel, 'catalog_page' || catalog_page_id AS id, sales, returns, profit FROM csr
    UNION ALL
    SELECT 'web channel' AS channel, 'web_site' || web_site_id AS id, sales, returns, profit FROM wsr
) x 
GROUP BY ROLLUP (channel, id) 
ORDER BY channel, id 
LIMIT 100;