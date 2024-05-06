WITH DateRange AS (
    SELECT 
        d_date_sk
    FROM 
        date_dim
    WHERE 
        d_date BETWEEN '1999-02-05'::date AND '1999-03-07'::date  -- Precomputed end date
)
explain select 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    SUM(ss_ext_sales_price) AS itemrevenue,
    SUM(ss_ext_sales_price) * 100 / SUM(SUM(ss_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
FROM 
    store_sales
JOIN 
    item ON ss_item_sk = i_item_sk
JOIN 
    DateRange ON ss_sold_date_sk = d_date_sk
WHERE 
    i_category IN ('Men', 'Sports', 'Jewelry')
GROUP BY 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price
ORDER BY 
    i_category,
    i_class,
    i_item_id,
    i_item_desc,
    revenueratio;WITH DateRange AS (
    SELECT 
        d_date_sk
    FROM 
        date_dim
    WHERE 
        d_date BETWEEN '1999-02-05'::date AND '1999-03-07'::date  -- Precomputed end date
)
SELECT 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    SUM(ss_ext_sales_price) AS itemrevenue,
    SUM(ss_ext_sales_price) * 100 / SUM(SUM(ss_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
FROM 
    store_sales
JOIN 
    item ON ss_item_sk = i_item_sk
JOIN 
    DateRange ON ss_sold_date_sk = d_date_sk
WHERE 
    i_category IN ('Men', 'Sports', 'Jewelry')
GROUP BY 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price
ORDER BY 
    i_category,
    i_class,
    i_item_id,
    i_item_desc,
    revenueratio;