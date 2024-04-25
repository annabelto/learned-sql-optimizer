SELECT 
    i_product_name,
    i_brand,
    i_class,
    i_category,
    AVG(inv_quantity_on_hand) AS qoh
FROM 
    item
JOIN 
    inventory ON inv_item_sk = i_item_sk
JOIN 
    date_dim ON inv_date_sk = d_date_sk
WHERE 
    d_month_seq BETWEEN 1200 AND 1211
GROUP BY 
    ROLLUP(i_product_name, i_brand, i_class, i_category)
ORDER BY 
    qoh, i_product_name, i_brand, i_class, i_category
LIMIT 100;