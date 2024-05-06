WITH frequent_ss_items AS (
    SELECT substr(i_item_desc, 1, 30) AS itemdesc, i_item_sk AS item_sk, d_date AS solddate, COUNT(*) AS cnt
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE date_dim.d_year IN (2000, 2001, 2002, 2003)
    GROUP BY substr(i_item_desc, 1, 30), i_item_sk, d_date
    HAVING COUNT(*) > 4
), 
max_store_sales AS (
    SELECT MAX(csales) AS tpcds_cmax
    FROM (
        SELECT c_customer_sk, SUM(ss_quantity * ss_sales_price) AS csales
        FROM store_sales
        JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        WHERE date_dim.d_year IN (2000, 2001, 2002, 2003)
        GROUP BY c_customer_sk
    ) AS sales_summary
), 
best_ss_customer AS (
    SELECT c_customer_sk, SUM(ss_quantity * ss_sales_price) AS ssales
    FROM store_sales
    JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
    GROUP BY c_customer_sk
    HAVING SUM(ss_quantity * ss_sales_price) > (95 / 100.0) * (SELECT tpcds_cmax FROM max_store_sales)
)
SELECT SUM(sales)
FROM (
    SELECT cs_quantity * cs_list_price AS sales
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    WHERE date_dim.d_year = 2000 AND date_dim.d_moy = 7
      AND catalog_sales.cs_item_sk IN (SELECT item_sk FROM frequent_ss_items)
      AND catalog_sales.cs_bill_customer_sk IN (SELECT c_customer_sk FROM best_ss_customer)
    UNION ALL
    SELECT ws_quantity * ws_list_price AS sales
    FROM web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    WHERE date_dim.d_year = 2000 AND date_dim.d_moy = 7
      AND web_sales.ws_item_sk IN (SELECT item_sk FROM frequent_ss_items)
      AND web_sales.ws_bill_customer_sk IN (SELECT c_customer_sk FROM best_ss_customer)
) AS total_sales
LIMIT 100;