SELECT SUM(cs_ext_discount_amt) AS "excess discount amount"
FROM catalog_sales
JOIN item ON i_item_sk = cs_item_sk
JOIN date_dim ON d_date_sk = cs_sold_date_sk
WHERE i_manufact_id = 722
  AND d_date BETWEEN '2001-03-09' AND (CAST('2001-03-09' AS DATE) + INTERVAL '90 days')
  AND cs_ext_discount_amt > (
    SELECT 1.3 * AVG(cs_ext_discount_amt)
    FROM catalog_sales
    JOIN date_dim ON d_date_sk = cs_sold_date_sk
    WHERE cs_item_sk = i_item_sk
      AND d_date BETWEEN '2001-03-09' AND (CAST('2001-03-09' AS DATE) + INTERVAL '90 days')
  )
LIMIT 100;