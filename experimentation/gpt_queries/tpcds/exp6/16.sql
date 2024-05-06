SELECT COUNT(DISTINCT cs1.cs_order_number) AS "order count",
       SUM(cs1.cs_ext_ship_cost) AS "total shipping cost",
       SUM(cs1.cs_net_profit) AS "total net profit"
FROM catalog_sales cs1
JOIN call_center cc ON cs1.cs_call_center_sk = cc.cc_call_center_sk
                     AND cc.cc_county = 'Williamson County'
JOIN customer_address ca ON cs1.cs_ship_addr_sk = ca.ca_address_sk
                          AND ca.ca_state = 'PA'
JOIN date_dim d ON cs1.cs_ship_date_sk = d.d_date_sk
                AND d.d_date BETWEEN '2002-4-01' AND (CAST('2002-4-01' AS DATE) + 60)
WHERE NOT EXISTS (
      SELECT 1 FROM catalog_returns cr1
      WHERE cs1.cs_order_number = cr1.cr_order_number
  )
  AND EXISTS (
      SELECT 1 FROM catalog_sales cs2
      WHERE cs1.cs_order_number = cs2.cs_order_number
        AND cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk
  )
ORDER BY COUNT(DISTINCT cs1.cs_order_number)
LIMIT 100;