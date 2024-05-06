WITH ss AS (
    SELECT ss_store_sk AS store_sk, 
           SUM(ss_ext_sales_price) AS sales, 
           SUM(ss_net_profit) AS profit 
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-08-10'::date AND '2000-09-09'::date
    GROUP BY ss_store_sk
), 
sr AS (
    SELECT sr_store_sk AS store_sk, 
           SUM(sr_return_amt) AS returns, 
           SUM(sr_net_loss) AS profit_loss 
    FROM store_returns
    JOIN date_dim ON sr_returned_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-08-10'::date AND '2000-09-09'::date
    GROUP BY sr_store_sk
), 
cs AS (
    SELECT cs_call_center_sk AS call_center_sk, 
           SUM(cs_ext_sales_price) AS sales, 
           SUM(cs_net_profit) AS profit 
    FROM catalog_sales
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-08-10'::date AND '2000-09-09'::date
    GROUP BY cs_call_center_sk
), 
cr AS (
    SELECT cr_call_center_sk AS call_center_sk, 
           SUM(cr_return_amount) AS returns, 
           SUM(cr_net_loss) AS profit_loss 
    FROM catalog_returns
    JOIN date_dim ON cr_returned_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-08-10'::date AND '2000-09-09'::date
    GROUP BY cr_call_center_sk
), 
ws AS (
    SELECT ws_web_page_sk AS web_page_sk, 
           SUM(ws_ext_sales_price) AS sales, 
           SUM(ws_net_profit) AS profit 
    FROM web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-08-10'::date AND '2000-09-09'::date
    GROUP BY ws_web_page_sk
), 
wr AS (
    SELECT wr_web_page_sk AS web_page_sk, 
           SUM(wr_return_amt) AS returns, 
           SUM(wr_net_loss) AS profit_loss 
    FROM web_returns
    JOIN date_dim ON wr_returned_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-08-10'::date AND '2000-09-09'::date
    GROUP BY wr_web_page_sk
)
SELECT channel, 
       id, 
       SUM(sales) AS sales, 
       SUM(returns) AS returns, 
       SUM(profit) AS profit 
FROM (
    SELECT 'store channel' AS channel, 
           ss.store_sk AS id, 
           ss.sales, 
           COALESCE(sr.returns, 0) AS returns, 
           (ss.profit - COALESCE(sr.profit_loss, 0)) AS profit 
    FROM ss 
    LEFT JOIN sr ON ss.store_sk = sr.store_sk 
    UNION ALL 
    SELECT 'catalog channel' AS channel, 
           cs.call_center_sk AS id, 
           cs.sales, 
           COALESCE(cr.returns, 0) AS returns, 
           (cs.profit - COALESCE(cr.profit_loss, 0)) AS profit 
    FROM cs 
    LEFT JOIN cr ON cs.call_center_sk = cr.call_center_sk 
    UNION ALL 
    SELECT 'web channel' AS channel, 
           ws.web_page_sk AS id, 
           ws.sales, 
           COALESCE(wr.returns, 0) AS returns, 
           (ws.profit - COALESCE(wr.profit_loss, 0)) AS profit 
    FROM ws 
    LEFT JOIN wr ON ws.web_page_sk = wr.web_page_sk
) x 
GROUP BY ROLLUP (channel, id) 
ORDER BY channel, id 
LIMIT 100;