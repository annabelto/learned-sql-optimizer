SELECT 
    SUM(ws_ext_discount_amt) AS "Excess Discount Amount"
FROM 
    web_sales
JOIN 
    item ON i_item_sk = ws_item_sk
JOIN 
    date_dim ON d_date_sk = ws_sold_date_sk
WHERE 
    i_manufact_id = 714
    AND d_date BETWEEN '2000-02-01' AND ('2000-02-01'::date + INTERVAL '90 days')
    AND ws_ext_discount_amt > (
        SELECT 1.3 * AVG(ws_ext_discount_amt)
        FROM web_sales
        JOIN date_dim ON d_date_sk = ws_sold_date_sk
        WHERE ws_item_sk = i_item_sk
          AND d_date BETWEEN '2000-02-01' AND ('2000-02-01'::date + INTERVAL '90 days')
    )
ORDER BY 
    SUM(ws_ext_discount_amt)
LIMIT 100;