WITH AvgDiscount AS (
    SELECT 1.3 * AVG(ws_ext_discount_amt) AS avg_discount
    FROM web_sales
    INNER JOIN date_dim ON date_dim.d_date_sk = web_sales.ws_sold_date_sk
    WHERE date_dim.d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
)
SELECT SUM(ws_ext_discount_amt) AS "Excess Discount Amount"
FROM web_sales
INNER JOIN item ON item.i_item_sk = web_sales.ws_item_sk
INNER JOIN date_dim ON date_dim.d_date_sk = web_sales.ws_sold_date_sk
, AvgDiscount
WHERE item.i_manufact_id = 714
  AND date_dim.d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
  AND ws_ext_discount_amt > (SELECT avg_discount FROM AvgDiscount)
ORDER BY SUM(ws_ext_discount_amt)
LIMIT 100;