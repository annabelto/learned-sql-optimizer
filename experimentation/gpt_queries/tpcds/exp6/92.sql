SELECT SUM(ws.ws_ext_discount_amt) AS "Excess Discount Amount"
FROM web_sales ws
JOIN item i ON i.i_item_sk = ws.ws_item_sk
JOIN date_dim d ON d.d_date_sk = ws.ws_sold_date_sk
WHERE i.i_manufact_id = 714
AND d.d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
AND ws.ws_ext_discount_amt > (
    SELECT 1.3 * AVG(ws_inner.ws_ext_discount_amt)
    FROM web_sales ws_inner
    JOIN date_dim d_inner ON d_inner.d_date_sk = ws_inner.ws_sold_date_sk
    WHERE ws_inner.ws_item_sk = i.i_item_sk
    AND d_inner.d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
)
ORDER BY SUM(ws.ws_ext_discount_amt)
LIMIT 100;