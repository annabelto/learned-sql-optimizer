WITH revenue_subquery AS (
    SELECT 
        ss_store_sk, 
        ss_item_sk, 
        sum(ss_sales_price) AS revenue
    FROM 
        store_sales
    JOIN 
        date_dim ON ss_sold_date_sk = d_date_sk
    WHERE 
        d_month_seq BETWEEN 1176 AND 1176 + 11
    GROUP BY 
        ss_store_sk, ss_item_sk
),
average_revenue AS (
    SELECT 
        ss_store_sk, 
        avg(revenue) AS ave
    FROM 
        revenue_subquery
    GROUP BY 
        ss_store_sk
)
explain select 
    s_store_name, 
    i_item_desc, 
    sc.revenue, 
    i_current_price, 
    i_wholesale_cost, 
    i_brand
FROM 
    store
JOIN 
    item ON i_item_sk = sc.ss_item_sk
JOIN 
    revenue_subquery sc ON s_store_sk = sc.ss_store_sk
JOIN 
    average_revenue sb ON sb.ss_store_sk = sc.ss_store_sk
WHERE 
    sc.revenue <= 0.1 * sb.ave
ORDER BY 
    s_store_name, 
    i_item_desc
LIMIT 100;WITH revenue_subquery AS (
    SELECT 
        ss_store_sk, 
        ss_item_sk, 
        sum(ss_sales_price) AS revenue
    FROM 
        store_sales
    JOIN 
        date_dim ON ss_sold_date_sk = d_date_sk
    WHERE 
        d_month_seq BETWEEN 1176 AND 1176 + 11
    GROUP BY 
        ss_store_sk, ss_item_sk
),
average_revenue AS (
    SELECT 
        ss_store_sk, 
        avg(revenue) AS ave
    FROM 
        revenue_subquery
    GROUP BY 
        ss_store_sk
)
SELECT 
    s_store_name, 
    i_item_desc, 
    sc.revenue, 
    i_current_price, 
    i_wholesale_cost, 
    i_brand
FROM 
    store
JOIN 
    item ON i_item_sk = sc.ss_item_sk
JOIN 
    revenue_subquery sc ON s_store_sk = sc.ss_store_sk
JOIN 
    average_revenue sb ON sb.ss_store_sk = sc.ss_store_sk
WHERE 
    sc.revenue <= 0.1 * sb.ave
ORDER BY 
    s_store_name, 
    i_item_desc
LIMIT 100;