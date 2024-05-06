explain select SUM(ws_ext_discount_amt) AS "Excess Discount Amount"
FROM web_sales
JOIN item ON i_item_sk = ws_item_sk AND i_manufact_id = 714
JOIN date_dim ON d_date_sk = ws_sold_date_sk AND d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
WHERE ws_ext_discount_amt > (
    SELECT 1.3 * AVG(ws_ext_discount_amt)
    FROM web_sales ws2
    JOIN item i2 ON ws2.ws_item_sk = i2.i_item_sk
    JOIN date_dim d2 ON ws2.ws_sold_date_sk = d2.d_date_sk
    WHERE d2.d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
    AND i2.i_manufact_id = 714
)
ORDER BY SUM(ws_ext_discount_amt)
LIMIT 100;SELECT SUM(ws_ext_discount_amt) AS "Excess Discount Amount"
FROM web_sales
JOIN item ON i_item_sk = ws_item_sk AND i_manufact_id = 714
JOIN date_dim ON d_date_sk = ws_sold_date_sk AND d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
WHERE ws_ext_discount_amt > (
    SELECT 1.3 * AVG(ws_ext_discount_amt)
    FROM web_sales ws2
    JOIN item i2 ON ws2.ws_item_sk = i2.i_item_sk
    JOIN date_dim d2 ON ws2.ws_sold_date_sk = d2.d_date_sk
    WHERE d2.d_date BETWEEN '2000-02-01' AND (CAST('2000-02-01' AS DATE) + 90)
    AND i2.i_manufact_id = 714
)
ORDER BY SUM(ws_ext_discount_amt)
LIMIT 100;