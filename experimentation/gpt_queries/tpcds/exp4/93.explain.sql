### Optimized Query
explain select ss_customer_sk, SUM(act_sales) AS sumsales
FROM (
    SELECT ss.ss_customer_sk,
           CASE 
               WHEN sr.sr_return_quantity IS NOT NULL THEN (ss.ss_quantity - sr.sr_return_quantity) * ss.ss_sales_price
               ELSE ss.ss_quantity * ss.ss_sales_price
           END AS act_sales
    FROM store_sales ss
    LEFT JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk AND ss.ss_ticket_number = sr.sr_ticket_number
    LEFT JOIN reason r ON sr.sr_reason_sk = r.r_reason_sk
    WHERE r.r_reason_desc = 'reason 58' OR r.r_reason_desc IS NULL
) AS sales_data
GROUP BY ss_customer_sk
ORDER BY sumsales DESC, ss_customer_sk
LIMIT 100;### Optimized Query
SELECT ss_customer_sk, SUM(act_sales) AS sumsales
FROM (
    SELECT ss.ss_customer_sk,
           CASE 
               WHEN sr.sr_return_quantity IS NOT NULL THEN (ss.ss_quantity - sr.sr_return_quantity) * ss.ss_sales_price
               ELSE ss.ss_quantity * ss.ss_sales_price
           END AS act_sales
    FROM store_sales ss
    LEFT JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk AND ss.ss_ticket_number = sr.sr_ticket_number
    LEFT JOIN reason r ON sr.sr_reason_sk = r.r_reason_sk
    WHERE r.r_reason_desc = 'reason 58' OR r.r_reason_desc IS NULL
) AS sales_data
GROUP BY ss_customer_sk
ORDER BY sumsales DESC, ss_customer_sk
LIMIT 100;