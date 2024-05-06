WITH ssr AS (
    SELECT 
        s_store_id, 
        SUM(ss_ext_sales_price) AS sales, 
        SUM(ss_net_profit) AS profit, 
        SUM(sr_return_amt) AS returns, 
        SUM(sr_net_loss) AS net_loss
    FROM 
        store_sales
    LEFT JOIN 
        store_returns ON store_sales.ss_store_sk = store_returns.sr_store_sk AND store_sales.ss_sold_date_sk = store_returns.sr_returned_date_sk
    JOIN 
        date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE 
        date_dim.d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date
    GROUP BY 
        s_store_id
), 
csr AS (
    SELECT 
        cp_catalog_page_id, 
        SUM(cs_ext_sales_price) AS sales, 
        SUM(cs_net_profit) AS profit, 
        SUM(cr_return_amount) AS returns, 
        SUM(cr_net_loss) AS net_loss
    FROM 
        catalog_sales
    LEFT JOIN 
        catalog_returns ON catalog_sales.cs_catalog_page_sk = catalog_returns.cr_catalog_page_sk AND catalog_sales.cs_sold_date_sk = catalog_returns.cr_returned_date_sk
    JOIN 
        date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    WHERE 
        date_dim.d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date
    GROUP BY 
        cp_catalog_page_id
), 
wsr AS (
    SELECT 
        web_site_id, 
        SUM(ws_ext_sales_price) AS sales, 
        SUM(ws_net_profit) AS profit, 
        SUM(wr_return_amt) AS returns, 
        SUM(wr_net_loss) AS net_loss
    FROM 
        web_sales
    LEFT JOIN 
        web_returns ON web_sales.ws_web_site_sk = web_returns.wr_web_site_sk AND web_sales.ws_sold_date_sk = web_returns.wr_returned_date_sk
    JOIN 
        date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    WHERE 
        date_dim.d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date
    GROUP BY 
        web_site_id
)
SELECT 
    channel, 
    id, 
    SUM(sales) AS sales, 
    SUM(returns) AS returns, 
    SUM(profit - net_loss) AS profit 
FROM (
    SELECT 
        'store channel' AS channel, 
        'store' || s_store_id AS id, 
        sales, 
        returns, 
        profit, 
        net_loss 
    FROM 
        ssr 
    UNION ALL 
    SELECT 
        'catalog channel' AS channel, 
        'catalog_page' || cp_catalog_page_id AS id, 
        sales, 
        returns, 
        profit, 
        net_loss 
    FROM 
        csr 
    UNION ALL 
    SELECT 
        'web channel' AS channel, 
        'web_site' || web_site_id AS id, 
        sales, 
        returns, 
        profit, 
        net_loss 
    FROM 
        wsr 
) x 
GROUP BY 
    ROLLUP (channel, id) 
ORDER BY 
    channel, id 
LIMIT 100;