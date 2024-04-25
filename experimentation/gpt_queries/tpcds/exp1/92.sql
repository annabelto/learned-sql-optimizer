WITH avg_discount AS (
  SELECT 1.3 * avg(ws_ext_discount_amt) AS avg_disc
  FROM web_sales
  JOIN date_dim ON d_date_sk = ws_sold_date_sk
  WHERE d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
)
SELECT sum(ws_ext_discount_amt) AS "Excess Discount Amount"
FROM web_sales
JOIN item ON i_item_sk = ws_item_sk
JOIN date_dim ON d_date_sk = ws_sold_date_sk
JOIN avg_discount ON ws_ext_discount_amt > avg_discount.avg_disc
WHERE i_manufact_id = 714
  AND d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
ORDER BY sum(ws_ext_discount_amt)
LIMIT 100;