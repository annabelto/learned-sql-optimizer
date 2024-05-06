SELECT ca_zip, ca_city, SUM(ws_sales_price)
FROM web_sales
JOIN customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk
JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
JOIN item ON web_sales.ws_item_sk = item.i_item_sk
LEFT JOIN item AS item_sub ON item.i_item_id = item_sub.i_item_id AND item_sub.i_item_sk IN (2, 3, 5, 7, 11, 13, 17, 19, 23, 29)
WHERE (SUBSTR(customer_address.ca_zip, 1, 5) IN ('85669', '86197', '88274', '83405', '86475', '85392', '85460', '80348', '81792')
       OR item_sub.i_item_id IS NOT NULL)
  AND date_dim.d_qoy = 1
  AND date_dim.d_year = 2000
GROUP BY ca_zip, ca_city
ORDER BY ca_zip, ca_city
LIMIT 100;