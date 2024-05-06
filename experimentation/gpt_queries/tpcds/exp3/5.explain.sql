WITH ssr AS (
    SELECT 
        s_store_id, 
        SUM(sales_price) AS sales, 
        SUM(profit) AS profit, 
        SUM(return_amt) AS returns, 
        SUM(net_loss) AS profit_loss 
    FROM (
        SELECT 
            ss_store_sk AS store_sk, 
            ss_sold_date_sk AS date_sk, 
            ss_ext_sales_price AS sales_price, 
            ss_net_profit AS profit, 
            CAST(0 AS DECIMAL(7,2)) AS return_amt, 
            CAST(0 AS DECIMAL(7,2)) AS net_loss 
        FROM 
            store_sales

        UNION ALL 

        SELECT 
            sr_store_sk AS store_sk, 
            sr_returned_date_sk AS date_sk, 
            CAST(0 AS DECIMAL(7,2)) AS sales_price, 
            CAST(0 AS DECIMAL(7,2)) AS profit, 
            sr_return_amt AS return_amt, 
            sr_net_loss AS net_loss 
        FROM 
            store_returns
    ) salesreturns
    JOIN 
        date_dim ON date_sk = d_date_sk 
    JOIN 
        store ON store_sk = s_store_sk 
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date 
    GROUP BY 
        s_store_id
), 
csr AS (
    SELECT 
        cp_catalog_page_id, 
        SUM(sales_price) AS sales, 
        SUM(profit) AS profit, 
        SUM(return_amt) AS returns, 
        SUM(net_loss) AS profit_loss 
    FROM (
        SELECT 
            cs_catalog_page_sk AS page_sk, 
            cs_sold_date_sk AS date_sk, 
            cs_ext_sales_price AS sales_price, 
            cs_net_profit AS profit, 
            CAST(0 AS DECIMAL(7,2)) AS return_amt, 
            CAST(0 AS DECIMAL(7,2)) AS net_loss 
        FROM 
            catalog_sales

        UNION ALL 

        SELECT 
            cr_catalog_page_sk AS page_sk, 
            cr_returned_date_sk AS date_sk, 
            CAST(0 AS DECIMAL(7,2)) AS sales_price, 
            CAST(0 AS DECIMAL(7,2)) AS profit, 
            cr_return_amount AS return_amt, 
            cr_net_loss AS net_loss 
        FROM 
            catalog_returns
    ) salesreturns
    JOIN 
        date_dim ON date_sk = d_date_sk 
    JOIN 
        catalog_page ON page_sk = cp_catalog_page_sk 
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date 
    GROUP BY 
        cp_catalog_page_id
), 
wsr AS (
    SELECT 
        web_site_id, 
        SUM(sales_price) AS sales, 
        SUM(profit) AS profit, 
        SUM(return_amt) AS returns, 
        SUM(net_loss) AS profit_loss 
    FROM (
        SELECT 
            ws_web_site_sk AS site_sk, 
            ws_sold_date_sk AS date_sk, 
            ws_ext_sales_price AS sales_price, 
            ws_net_profit AS profit, 
            CAST(0 AS DECIMAL(7,2)) AS return_amt, 
            CAST(0 AS DECIMAL(7,2)) AS net_loss 
        FROM 
            web_sales

        UNION ALL 

        SELECT 
            wr_web_page_sk AS site_sk, 
            wr_returned_date_sk AS date_sk, 
            CAST(0 AS DECIMAL(7,2)) AS sales_price, 
            CAST(0 AS DECIMAL(7,2)) AS profit, 
            wr_return_amt AS return_amt, 
            wr_net_loss AS net_loss 
        FROM 
            web_returns
    ) salesreturns
    JOIN 
        date_dim ON date_sk = d_date_sk 
    JOIN 
        web_site ON site_sk = web_site_sk 
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date 
    GROUP BY 
        web_site_id
)
explain select 
    channel, 
    id, 
    SUM(sales) AS sales, 
    SUM(returns) AS returns, 
    SUM(profit - profit_loss) AS profit 
FROM (
    SELECT 'store channel' AS channel, 'store' || s_store_id AS id, sales, returns, profit, profit_loss FROM ssr
    UNION ALL 
    SELECT 'catalog channel' AS channel, 'catalog_page' || cp_catalog_page_id AS id, sales, returns, profit, profit_loss FROM csr
    UNION ALL 
    SELECT 'web channel' AS channel, 'web_site' || web_site_id AS id, sales, returns, profit, profit_loss FROM wsr
) x 
GROUP BY ROLLUP (channel, id) 
ORDER BY channel, id 
LIMIT 100;WITH ssr AS (
    SELECT 
        s_store_id, 
        SUM(sales_price) AS sales, 
        SUM(profit) AS profit, 
        SUM(return_amt) AS returns, 
        SUM(net_loss) AS profit_loss 
    FROM (
        SELECT 
            ss_store_sk AS store_sk, 
            ss_sold_date_sk AS date_sk, 
            ss_ext_sales_price AS sales_price, 
            ss_net_profit AS profit, 
            CAST(0 AS DECIMAL(7,2)) AS return_amt, 
            CAST(0 AS DECIMAL(7,2)) AS net_loss 
        FROM 
            store_sales

        UNION ALL 

        SELECT 
            sr_store_sk AS store_sk, 
            sr_returned_date_sk AS date_sk, 
            CAST(0 AS DECIMAL(7,2)) AS sales_price, 
            CAST(0 AS DECIMAL(7,2)) AS profit, 
            sr_return_amt AS return_amt, 
            sr_net_loss AS net_loss 
        FROM 
            store_returns
    ) salesreturns
    JOIN 
        date_dim ON date_sk = d_date_sk 
    JOIN 
        store ON store_sk = s_store_sk 
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date 
    GROUP BY 
        s_store_id
), 
csr AS (
    SELECT 
        cp_catalog_page_id, 
        SUM(sales_price) AS sales, 
        SUM(profit) AS profit, 
        SUM(return_amt) AS returns, 
        SUM(net_loss) AS profit_loss 
    FROM (
        SELECT 
            cs_catalog_page_sk AS page_sk, 
            cs_sold_date_sk AS date_sk, 
            cs_ext_sales_price AS sales_price, 
            cs_net_profit AS profit, 
            CAST(0 AS DECIMAL(7,2)) AS return_amt, 
            CAST(0 AS DECIMAL(7,2)) AS net_loss 
        FROM 
            catalog_sales

        UNION ALL 

        SELECT 
            cr_catalog_page_sk AS page_sk, 
            cr_returned_date_sk AS date_sk, 
            CAST(0 AS DECIMAL(7,2)) AS sales_price, 
            CAST(0 AS DECIMAL(7,2)) AS profit, 
            cr_return_amount AS return_amt, 
            cr_net_loss AS net_loss 
        FROM 
            catalog_returns
    ) salesreturns
    JOIN 
        date_dim ON date_sk = d_date_sk 
    JOIN 
        catalog_page ON page_sk = cp_catalog_page_sk 
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date 
    GROUP BY 
        cp_catalog_page_id
), 
wsr AS (
    SELECT 
        web_site_id, 
        SUM(sales_price) AS sales, 
        SUM(profit) AS profit, 
        SUM(return_amt) AS returns, 
        SUM(net_loss) AS profit_loss 
    FROM (
        SELECT 
            ws_web_site_sk AS site_sk, 
            ws_sold_date_sk AS date_sk, 
            ws_ext_sales_price AS sales_price, 
            ws_net_profit AS profit, 
            CAST(0 AS DECIMAL(7,2)) AS return_amt, 
            CAST(0 AS DECIMAL(7,2)) AS net_loss 
        FROM 
            web_sales

        UNION ALL 

        SELECT 
            wr_web_page_sk AS site_sk, 
            wr_returned_date_sk AS date_sk, 
            CAST(0 AS DECIMAL(7,2)) AS sales_price, 
            CAST(0 AS DECIMAL(7,2)) AS profit, 
            wr_return_amt AS return_amt, 
            wr_net_loss AS net_loss 
        FROM 
            web_returns
    ) salesreturns
    JOIN 
        date_dim ON date_sk = d_date_sk 
    JOIN 
        web_site ON site_sk = web_site_sk 
    WHERE 
        d_date BETWEEN '2000-08-19'::date AND '2000-09-02'::date 
    GROUP BY 
        web_site_id
)
SELECT 
    channel, 
    id, 
    SUM(sales) AS sales, 
    SUM(returns) AS returns, 
    SUM(profit - profit_loss) AS profit 
FROM (
    SELECT 'store channel' AS channel, 'store' || s_store_id AS id, sales, returns, profit, profit_loss FROM ssr
    UNION ALL 
    SELECT 'catalog channel' AS channel, 'catalog_page' || cp_catalog_page_id AS id, sales, returns, profit, profit_loss FROM csr
    UNION ALL 
    SELECT 'web channel' AS channel, 'web_site' || web_site_id AS id, sales, returns, profit, profit_loss FROM wsr
) x 
GROUP BY ROLLUP (channel, id) 
ORDER BY channel, id 
LIMIT 100;