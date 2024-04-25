WITH frequent_ss_items AS (
    SELECT 
        substr(i_item_desc, 1, 30) AS itemdesc,
        i_item_sk AS item_sk,
        d_date AS solddate,
        count(*) AS cnt
    FROM 
        store_sales
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN item ON ss_item_sk = i_item_sk
    WHERE 
        d_year BETWEEN 2000 AND 2003
    GROUP BY 
        substr(i_item_desc, 1, 30), i_item_sk, d_date
    HAVING 
        count(*) > 4
), 
max_store_sales AS (
    SELECT 
        max(csales) AS tpcds_cmax
    FROM (
        SELECT 
            c_customer_sk,
            sum(ss_quantity * ss_sales_price) AS csales
        FROM 
            store_sales
            JOIN customer ON ss_customer_sk = c_customer_sk
            JOIN date_dim ON ss_sold_date_sk = d_date_sk
        WHERE 
            d_year BETWEEN 2000 AND 2003
        GROUP BY 
            c_customer_sk
    ) AS sales
), 
best_ss_customer AS (
    SELECT 
        c_customer_sk,
        sum(ss_quantity * ss_sales_price) AS ssales
    FROM 
        store_sales
        JOIN customer ON ss_customer_sk = c_customer_sk
    GROUP BY 
        c_customer_sk
    HAVING 
        sum(ss_quantity * ss_sales_price) > (95 / 100.0) * (SELECT tpcds_cmax FROM max_store_sales)
)
explain select 
    c_last_name,
    c_first_name,
    sum(sales) AS total_sales
FROM (
    SELECT 
        c_last_name,
        c_first_name,
        cs_quantity * cs_list_price AS sales
    FROM 
        catalog_sales
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
        JOIN customer ON cs_bill_customer_sk = c_customer_sk
    WHERE 
        d_year = 2000 AND d_moy = 7
        AND cs_item_sk IN (SELECT item_sk FROM frequent_ss_items)
        AND cs_bill_customer_sk IN (SELECT c_customer_sk FROM best_ss_customer)
    UNION ALL
    SELECT 
        c_last_name,
        c_first_name,
        ws_quantity * ws_list_price AS sales
    FROM 
        web_sales
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN customer ON ws_bill_customer_sk = c_customer_sk
    WHERE 
        d_year = 2000 AND d_moy = 7
        AND ws_item_sk IN (SELECT item_sk FROM frequent_ss_items)
        AND ws_bill_customer_sk IN (SELECT c_customer_sk FROM best_ss_customer)
) AS sales_data
GROUP BY 
    c_last_name, c_first_name
ORDER BY 
    c_last_name, c_first_name, total_sales DESC
LIMIT 100;WITH frequent_ss_items AS (
    SELECT 
        substr(i_item_desc, 1, 30) AS itemdesc,
        i_item_sk AS item_sk,
        d_date AS solddate,
        count(*) AS cnt
    FROM 
        store_sales
        JOIN date_dim ON ss_sold_date_sk = d_date_sk
        JOIN item ON ss_item_sk = i_item_sk
    WHERE 
        d_year BETWEEN 2000 AND 2003
    GROUP BY 
        substr(i_item_desc, 1, 30), i_item_sk, d_date
    HAVING 
        count(*) > 4
), 
max_store_sales AS (
    SELECT 
        max(csales) AS tpcds_cmax
    FROM (
        SELECT 
            c_customer_sk,
            sum(ss_quantity * ss_sales_price) AS csales
        FROM 
            store_sales
            JOIN customer ON ss_customer_sk = c_customer_sk
            JOIN date_dim ON ss_sold_date_sk = d_date_sk
        WHERE 
            d_year BETWEEN 2000 AND 2003
        GROUP BY 
            c_customer_sk
    ) AS sales
), 
best_ss_customer AS (
    SELECT 
        c_customer_sk,
        sum(ss_quantity * ss_sales_price) AS ssales
    FROM 
        store_sales
        JOIN customer ON ss_customer_sk = c_customer_sk
    GROUP BY 
        c_customer_sk
    HAVING 
        sum(ss_quantity * ss_sales_price) > (95 / 100.0) * (SELECT tpcds_cmax FROM max_store_sales)
)
SELECT 
    c_last_name,
    c_first_name,
    sum(sales) AS total_sales
FROM (
    SELECT 
        c_last_name,
        c_first_name,
        cs_quantity * cs_list_price AS sales
    FROM 
        catalog_sales
        JOIN date_dim ON cs_sold_date_sk = d_date_sk
        JOIN customer ON cs_bill_customer_sk = c_customer_sk
    WHERE 
        d_year = 2000 AND d_moy = 7
        AND cs_item_sk IN (SELECT item_sk FROM frequent_ss_items)
        AND cs_bill_customer_sk IN (SELECT c_customer_sk FROM best_ss_customer)
    UNION ALL
    SELECT 
        c_last_name,
        c_first_name,
        ws_quantity * ws_list_price AS sales
    FROM 
        web_sales
        JOIN date_dim ON ws_sold_date_sk = d_date_sk
        JOIN customer ON ws_bill_customer_sk = c_customer_sk
    WHERE 
        d_year = 2000 AND d_moy = 7
        AND ws_item_sk IN (SELECT item_sk FROM frequent_ss_items)
        AND ws_bill_customer_sk IN (SELECT c_customer_sk FROM best_ss_customer)
) AS sales_data
GROUP BY 
    c_last_name, c_first_name
ORDER BY 
    c_last_name, c_first_name, total_sales DESC
LIMIT 100;