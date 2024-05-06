WITH ValidSales AS (
    SELECT cs_order_number, cs_ext_ship_cost, cs_net_profit, cs_ship_date_sk, cs_ship_addr_sk, cs_call_center_sk
    FROM catalog_sales
    WHERE NOT EXISTS (
        SELECT 1
        FROM catalog_returns cr1
        WHERE catalog_sales.cs_order_number = cr1.cr_order_number
    )
    AND EXISTS (
        SELECT 1
        FROM catalog_sales cs2
        WHERE catalog_sales.cs_order_number = cs2.cs_order_number
          AND catalog_sales.cs_warehouse_sk <> cs2.cs_warehouse_sk
    )
),
FilteredSales AS (
    SELECT vs.cs_order_number, vs.cs_ext_ship_cost, vs.cs_net_profit
    FROM ValidSales vs
    JOIN date_dim d ON vs.cs_ship_date_sk = d.d_date_sk
    JOIN customer_address ca ON vs.cs_ship_addr_sk = ca.ca_address_sk
    JOIN call_center cc ON vs.cs_call_center_sk = cc.cc_call_center_sk
    WHERE d.d_date BETWEEN '2002-04-01' AND '2002-06-01'
      AND ca.ca_state = 'PA'
      AND cc.cc_county = 'Williamson County'
)
SELECT COUNT(DISTINCT cs_order_number) AS "order count",
       SUM(cs_ext_ship_cost) AS "total shipping cost",
       SUM(cs_net_profit) AS "total net profit"
FROM FilteredSales
ORDER BY COUNT(DISTINCT cs_order_number)
LIMIT 100;