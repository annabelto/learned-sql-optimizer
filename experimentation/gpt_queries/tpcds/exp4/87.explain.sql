-- Assuming appropriate indexes are present on the join and filter columns

-- Optimized query using predicate pushdown and efficient joins
explain select COUNT(*)
FROM (
    (SELECT DISTINCT c_last_name, c_first_name, d_date
     FROM store_sales
     JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk AND date_dim.d_month_seq BETWEEN 1202 AND 1213
     JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk)
    EXCEPT
    (SELECT DISTINCT c_last_name, c_first_name, d_date
     FROM catalog_sales
     JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk AND date_dim.d_month_seq BETWEEN 1202 AND 1213
     JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk)
    EXCEPT
    (SELECT DISTINCT c_last_name, c_first_name, d_date
     FROM web_sales
     JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk AND date_dim.d_month_seq BETWEEN 1202 AND 1213
     JOIN customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk)
) AS cool_cust;-- Assuming appropriate indexes are present on the join and filter columns

-- Optimized query using predicate pushdown and efficient joins
SELECT COUNT(*)
FROM (
    (SELECT DISTINCT c_last_name, c_first_name, d_date
     FROM store_sales
     JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk AND date_dim.d_month_seq BETWEEN 1202 AND 1213
     JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk)
    EXCEPT
    (SELECT DISTINCT c_last_name, c_first_name, d_date
     FROM catalog_sales
     JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk AND date_dim.d_month_seq BETWEEN 1202 AND 1213
     JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk)
    EXCEPT
    (SELECT DISTINCT c_last_name, c_first_name, d_date
     FROM web_sales
     JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk AND date_dim.d_month_seq BETWEEN 1202 AND 1213
     JOIN customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk)
) AS cool_cust;