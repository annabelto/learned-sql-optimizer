SELECT ca_zip, ca_city, SUM(ws_sales_price)
FROM web_sales
JOIN customer ON ws_bill_customer_sk = c_customer_sk
JOIN customer_address ON c_current_addr_sk = ca_address_sk
JOIN item ON ws_item_sk = i_item_sk
JOIN date_dim ON ws_sold_date_sk = d_date_sk AND d_qoy = 1 AND d_year = 2000
WHERE substr(ca_zip, 1, 5) IN ('85669', '86197', '88274', '83405', '86475', '85392', '85460', '80348', '81792')
      OR EXISTS (
          SELECT 1
          FROM item AS item_sub
          WHERE item_sub.i_item_id = item.i_item_id
          AND item_sub.i_item_sk IN (2, 3, 5, 7, 11, 13, 17, 19, 23, 29)
      )
GROUP BY ca_zip, ca_city
ORDER BY ca_zip, ca_city
LIMIT 100;