WITH ssr AS (
    SELECT 
        s_store_id, 
        SUM(ss_ext_sales_price) AS sales, 
        SUM(ss_net_profit) AS profit, 
        SUM(0) AS returns, 
        SUM(0) AS profit_loss 
    FROM 
        store_sales
    JOIN 
        date_dim ON ss_sold_date_sk = d_date_sk
    JOIN 
        store ON ss_store_sk = s_store_sk
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-08-19'::date + INTERVAL '14 days'
    GROUP BY 
        s_store_id
), 
csr AS (
    SELECT 
        cp_catalog_page_id, 
        SUM(cs_ext_sales_price) AS sales, 
        SUM(cs_net_profit) AS profit, 
        SUM(0) AS returns, 
        SUM(0) AS profit_loss 
    FROM 
        catalog_sales
    JOIN 
        date_dim ON cs_sold_date_sk = d_date_sk
    JOIN 
        catalog_page ON cs_catalog_page_sk = cp_catalog_page_sk
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-08-19'::date + INTERVAL '14 days'
    GROUP BY 
        cp_catalog_page_id
), 
wsr AS (
    SELECT 
        web_site_id, 
        SUM(ws_ext_sales_price) AS sales, 
        SUM(ws_net_profit) AS profit, 
        SUM(0) AS returns, 
        SUM(0) AS profit_loss 
    FROM 
        web_sales
    JOIN 
        date_dim ON ws_sold_date_sk = d_date_sk
    JOIN 
        web_site ON ws_web_site_sk = web_site_sk
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-08-19'::date + INTERVAL '14 days'
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
    SELECT 'store channel' AS channel, 'store' || s_store_id AS id, sales, returns, profit - profit_loss AS profit FROM ssr
    UNION ALL
    SELECT 'catalog channel' AS channel, 'catalog_page' || cp_catalog_page_id AS id, sales, returns, profit - profit_loss AS profit FROM csr
    UNION ALL
    SELECT 'web channel' AS channel, 'web_site' || web_site_id AS id, sales, returns, profit - profit_loss AS profit FROM wsr
) x 
GROUP BY ROLLUP (channel, id) 
ORDER BY channel, id 
LIMIT 100;