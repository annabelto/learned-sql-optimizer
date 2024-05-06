SELECT i_product_name, i_brand, i_class, i_category, AVG(inv_quantity_on_hand) AS qoh
FROM inventory
JOIN date_dim ON inventory.inv_date_sk = date_dim.d_date_sk
JOIN item ON inventory.inv_item_sk = item.i_item_sk
WHERE date_dim.d_month_seq BETWEEN 1200 AND 1211
GROUP BY ROLLUP(i_product_name, i_brand, i_class, i_category)
ORDER BY qoh, i_product_name, i_brand, i_class, i_category
LIMIT 100;