explain select ca_zip, SUM(cs_sales_price)
FROM catalog_sales
JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
WHERE date_dim.d_year = 2001 AND date_dim.d_qoy = 2
  AND (customer_address.ca_state IN ('CA', 'WA', 'GA') OR
       SUBSTR(customer_address.ca_zip, 1, 5) IN ('85669', '86197', '88274', '83405', '86475', '85392', '85460', '80348', '81792') OR
       catalog_sales.cs_sales_price > 500)
GROUP BY ca_zip
ORDER BY ca_zip
LIMIT 100;SELECT ca_zip, SUM(cs_sales_price)
FROM catalog_sales
JOIN customer ON catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
WHERE date_dim.d_year = 2001 AND date_dim.d_qoy = 2
  AND (customer_address.ca_state IN ('CA', 'WA', 'GA') OR
       SUBSTR(customer_address.ca_zip, 1, 5) IN ('85669', '86197', '88274', '83405', '86475', '85392', '85460', '80348', '81792') OR
       catalog_sales.cs_sales_price > 500)
GROUP BY ca_zip
ORDER BY ca_zip
LIMIT 100;