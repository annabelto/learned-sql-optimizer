SELECT 
    i.i_item_id, 
    AVG(ss.ss_quantity) AS agg1, 
    AVG(ss.ss_list_price) AS agg2, 
    AVG(ss.ss_coupon_amt) AS agg3, 
    AVG(ss.ss_sales_price) AS agg4 
FROM 
    item i
JOIN 
    store_sales ss ON ss.ss_item_sk = i.i_item_sk
JOIN 
    customer_demographics cd ON ss.ss_cdemo_sk = cd.cd_demo_sk
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN 
    promotion p ON ss.ss_promo_sk = p.p_promo_sk
WHERE 
    cd.cd_gender = 'F' 
    AND cd.cd_marital_status = 'W' 
    AND cd.cd_education_status = 'College' 
    AND (p.p_channel_email = 'N' OR p.p_channel_event = 'N')
    AND d.d_year = 2001
GROUP BY 
    i.i_item_id 
ORDER BY 
    i.i_item_id 
LIMIT 100;