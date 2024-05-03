SELECT 
    cc.cc_call_center_id AS Call_Center, 
    cc.cc_name AS Call_Center_Name, 
    cc.cc_manager AS Manager, 
    SUM(cr.cr_net_loss) AS Returns_Loss
FROM 
    call_center cc
JOIN 
    catalog_returns cr ON cr.cr_call_center_sk = cc.cc_call_center_sk
JOIN 
    date_dim d ON cr.cr_returned_date_sk = d.d_date_sk AND d.d_year = 2000 AND d.d_moy = 12
JOIN 
    customer c ON cr.cr_returning_customer_sk = c.c_customer_sk
JOIN 
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk AND 
    ((cd.cd_marital_status = 'M' AND cd.cd_education_status = 'Unknown') OR 
     (cd.cd_marital_status = 'W' AND cd.cd_education_status = 'Advanced Degree'))
JOIN 
    household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk AND hd.hd_buy_potential LIKE 'Unknown%'
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk AND ca.ca_gmt_offset = -7
GROUP BY 
    cc.cc_call_center_id, cc.cc_name, cc.cc_manager
ORDER BY 
    SUM(cr.cr_net_loss) DESC;