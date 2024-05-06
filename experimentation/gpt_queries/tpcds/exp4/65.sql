WITH revenue_details AS (
    SELECT ss_store_sk, ss_item_sk, SUM(ss_sales_price) AS revenue
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_month_seq BETWEEN 1176 AND 1176+11
    GROUP BY ss_store_sk, ss_item_sk
),
average_revenue AS (
    SELECT ss_store_sk, AVG(revenue) AS ave
    FROM revenue_details
    GROUP BY ss_store_sk
)
SELECT s.s_store_name, i.i_item_desc, rd.revenue, i.i_current_price, i.i_wholesale_cost, i.i_brand
FROM store s
JOIN revenue_details rd ON s.s_store_sk = rd.ss_store_sk
JOIN item i ON i.i_item_sk = rd.ss_item_sk
JOIN average_revenue ar ON ar.ss_store_sk = rd.ss_store_sk
WHERE rd.revenue <= 0.1 * ar.ave
ORDER BY s.s_store_name, i.i_item_desc
LIMIT 100;