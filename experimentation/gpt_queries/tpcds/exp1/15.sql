SELECT ca_zip, SUM(cs_sales_price)
FROM 
  (SELECT cs_bill_customer_sk, cs_sales_price, cs_sold_date_sk
   FROM catalog_sales
   WHERE cs_sales_price > 500) cs
JOIN 
  (SELECT c_customer_sk, c_current_addr_sk
   FROM customer) c ON cs.cs_bill_customer_sk = c.c_customer_sk
JOIN 
  (SELECT ca_address_sk, ca_zip
   FROM customer_address
   WHERE substr(ca_zip, 1, 5) IN ('85669', '86197', '88274', '83405', '86475', '85392', '85460', '80348', '81792')
      OR ca_state IN ('CA', 'WA', 'GA')) ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
  (SELECT d_date_sk
   FROM date_dim
   WHERE d_qoy = 2 AND d_year = 2001) d ON cs.cs_sold_date_sk = d.d_date_sk
GROUP BY ca_zip
ORDER BY ca_zip
LIMIT 100;