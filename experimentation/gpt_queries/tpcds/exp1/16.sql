SELECT 
    COUNT(DISTINCT cs1.cs_order_number) AS "order count",
    SUM(cs1.cs_ext_ship_cost) AS "total shipping cost",
    SUM(cs1.cs_net_profit) AS "total net profit"
FROM 
    catalog_sales cs1
JOIN 
    date_dim ON cs1.cs_ship_date_sk = date_dim.d_date_sk
JOIN 
    customer_address ON cs1.cs_ship_addr_sk = customer_address.ca_address_sk
JOIN 
    call_center ON cs1.cs_call_center_sk = call_center.cc_call_center_sk
WHERE 
    date_dim.d_date BETWEEN '2002-04-01' AND '2002-05-31' -- Simplified date operation
    AND customer_address.ca_state = 'PA'
    AND call_center.cc_county = 'Williamson County' -- Eliminated redundant expressions
    AND EXISTS (
        SELECT 1
        FROM catalog_sales cs2
        WHERE cs1.cs_order_number = cs2.cs_order_number
          AND cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk
    )
    AND NOT EXISTS (
        SELECT 1
        FROM catalog_returns cr1
        WHERE cs1.cs_order_number = cr1.cr_order_number
    )
ORDER BY 
    "order count"
LIMIT 100;