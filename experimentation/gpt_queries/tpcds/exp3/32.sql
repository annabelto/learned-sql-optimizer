SELECT
    SUM(cs_ext_discount_amt) AS "excess discount amount"
FROM
    catalog_sales
JOIN
    item ON item.i_item_sk = catalog_sales.cs_item_sk
JOIN
    date_dim ON date_dim.d_date_sk = catalog_sales.cs_sold_date_sk
LEFT JOIN
    (SELECT
         cs_item_sk AS subq_item_sk,
         1.3 * AVG(cs_ext_discount_amt) AS avg_discount
     FROM
         catalog_sales
     JOIN
         date_dim ON date_dim.d_date_sk = catalog_sales.cs_sold_date_sk
     WHERE
         date_dim.d_date BETWEEN '2001-03-09' AND ('2001-03-09'::date + INTERVAL '90 day')
     GROUP BY
         cs_item_sk) AS subq ON subq.subq_item_sk = catalog_sales.cs_item_sk
WHERE
    item.i_manufact_id = 722
    AND date_dim.d_date BETWEEN '2001-03-09' AND ('2001-03-09'::date + INTERVAL '90 day')
    AND catalog_sales.cs_ext_discount_amt > subq.avg_discount
LIMIT 100;