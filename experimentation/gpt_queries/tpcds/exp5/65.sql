SELECT 
    s.s_store_name, 
    i.i_item_desc, 
    sc.revenue, 
    i.i_current_price, 
    i.i_wholesale_cost, 
    i.i_brand 
FROM 
    store s
JOIN 
    (SELECT 
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
    ) sc ON s.s_store_sk = sc.ss_store_sk
JOIN 
    item i ON i.i_item_sk = sc.ss_item_sk
JOIN 
    (SELECT 
         ss_store_sk, 
         avg(revenue) AS ave 
     FROM 
         (SELECT 
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
         ) sa 
     GROUP BY 
         ss_store_sk
    ) sb ON sb.ss_store_sk = sc.ss_store_sk AND sc.revenue <= 0.1 * sb.ave
ORDER BY 
    s.s_store_name, 
    i.i_item_desc 
LIMIT 100;