explain select 
    i_item_id, 
    AVG(ss_quantity) AS agg1, 
    AVG(ss_list_price) AS agg2, 
    AVG(ss_coupon_amt) AS agg3, 
    AVG(ss_sales_price) AS agg4 
FROM 
    store_sales
JOIN 
    item ON ss_item_sk = i_item_sk
JOIN 
    date_dim ON ss_sold_date_sk = d_date_sk AND d_year = 2001
JOIN 
    customer_demographics ON ss_cdemo_sk = cd_demo_sk AND cd_gender = 'F' AND cd_marital_status = 'W' AND cd_education_status = 'College'
JOIN 
    promotion ON ss_promo_sk = p_promo_sk AND (p_channel_email = 'N' OR p_channel_event = 'N')
GROUP BY 
    i_item_id 
ORDER BY 
    i_item_id 
LIMIT 100;SELECT 
    i_item_id, 
    AVG(ss_quantity) AS agg1, 
    AVG(ss_list_price) AS agg2, 
    AVG(ss_coupon_amt) AS agg3, 
    AVG(ss_sales_price) AS agg4 
FROM 
    store_sales
JOIN 
    item ON ss_item_sk = i_item_sk
JOIN 
    date_dim ON ss_sold_date_sk = d_date_sk AND d_year = 2001
JOIN 
    customer_demographics ON ss_cdemo_sk = cd_demo_sk AND cd_gender = 'F' AND cd_marital_status = 'W' AND cd_education_status = 'College'
JOIN 
    promotion ON ss_promo_sk = p_promo_sk AND (p_channel_email = 'N' OR p_channel_event = 'N')
GROUP BY 
    i_item_id 
ORDER BY 
    i_item_id 
LIMIT 100;