explain select 
    cc_call_center_id AS Call_Center, 
    cc_name AS Call_Center_Name, 
    cc_manager AS Manager, 
    SUM(cr_net_loss) AS Returns_Loss
FROM 
    call_center
JOIN 
    catalog_returns ON cr_call_center_sk = cc_call_center_sk
JOIN 
    date_dim ON cr_returned_date_sk = d_date_sk
JOIN 
    customer ON cr_returning_customer_sk = c_customer_sk
JOIN 
    customer_demographics ON cd_demo_sk = c_current_cdemo_sk
JOIN 
    household_demographics ON hd_demo_sk = c_current_hdemo_sk
JOIN 
    customer_address ON ca_address_sk = c_current_addr_sk
WHERE 
    d_year = 2000 AND 
    d_moy = 12 AND 
    (
        (cd_marital_status = 'M' AND cd_education_status = 'Unknown') OR
        (cd_marital_status = 'W' AND cd_education_status = 'Advanced Degree')
    ) AND 
    hd_buy_potential LIKE 'Unknown%' AND 
    ca_gmt_offset = -7
GROUP BY 
    cc_call_center_id, cc_name, cc_manager
ORDER BY 
    SUM(cr_net_loss) DESC;SELECT 
    cc_call_center_id AS Call_Center, 
    cc_name AS Call_Center_Name, 
    cc_manager AS Manager, 
    SUM(cr_net_loss) AS Returns_Loss
FROM 
    call_center
JOIN 
    catalog_returns ON cr_call_center_sk = cc_call_center_sk
JOIN 
    date_dim ON cr_returned_date_sk = d_date_sk
JOIN 
    customer ON cr_returning_customer_sk = c_customer_sk
JOIN 
    customer_demographics ON cd_demo_sk = c_current_cdemo_sk
JOIN 
    household_demographics ON hd_demo_sk = c_current_hdemo_sk
JOIN 
    customer_address ON ca_address_sk = c_current_addr_sk
WHERE 
    d_year = 2000 AND 
    d_moy = 12 AND 
    (
        (cd_marital_status = 'M' AND cd_education_status = 'Unknown') OR
        (cd_marital_status = 'W' AND cd_education_status = 'Advanced Degree')
    ) AND 
    hd_buy_potential LIKE 'Unknown%' AND 
    ca_gmt_offset = -7
GROUP BY 
    cc_call_center_id, cc_name, cc_manager
ORDER BY 
    SUM(cr_net_loss) DESC;