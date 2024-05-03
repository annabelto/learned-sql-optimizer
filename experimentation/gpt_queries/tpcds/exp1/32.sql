WITH threshold AS (
    SELECT 1.3 * AVG(cs_ext_discount_amt) AS avg_discount
    FROM catalog_sales
    JOIN date_dim ON d_date_sk = cs_sold_date_sk
    WHERE d_date BETWEEN '2001-03-09' AND ('2001-03-09'::date + INTERVAL '90 days')
)
SELECT SUM(cs_ext_discount_amt) AS "excess discount amount"
FROM catalog_sales
JOIN item ON i_item_sk = cs_item_sk
JOIN date_dim ON d_date_sk = cs_sold_date_sk
JOIN threshold ON true
WHERE i_manufact_id = 722
  AND d_date BETWEEN '2001-03-09' AND ('2001-03-09'::date + INTERVAL '90 days')
  AND cs_ext_discount_amt > threshold.avg_discount
LIMIT 100;