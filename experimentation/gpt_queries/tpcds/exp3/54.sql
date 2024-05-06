WITH my_customers AS (
    SELECT DISTINCT c_customer_sk, c_current_addr_sk
    FROM (
        SELECT cs_sold_date_sk AS sold_date_sk, cs_bill_customer_sk AS customer_sk, cs_item_sk AS item_sk
        FROM catalog_sales
        WHERE cs_sold_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_moy = 1 AND d_year = 1999)
        UNION ALL
        SELECT ws_sold_date_sk AS sold_date_sk, ws_bill_customer_sk AS customer_sk, ws_item_sk AS item_sk
        FROM web_sales
        WHERE ws_sold_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_moy = 1 AND d_year = 1999)
    ) AS cs_or_ws_sales
    JOIN item ON cs_or_ws_sales.item_sk = i_item_sk
    JOIN customer ON c_customer_sk = cs_or_ws_sales.customer_sk
    WHERE i_category = 'Music' AND i_class = 'country'
),
my_revenue AS (
    SELECT c_customer_sk, SUM(ss_ext_sales_price) AS revenue
    FROM my_customers
    JOIN store_sales ON c_customer_sk = ss_customer_sk
    JOIN customer_address ON c_current_addr_sk = ca_address_sk
    JOIN store ON ca_county = s_county AND ca_state = s_state
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_month_seq BETWEEN (
        SELECT MIN(d_month_seq) + 1
        FROM date_dim
        WHERE d_year = 1999 AND d_moy = 1
    ) AND (
        SELECT MAX(d_month_seq) + 3
        FROM date_dim
        WHERE d_year = 1999 AND d_moy = 1
    )
    GROUP BY c_customer_sk
),
segments AS (
    SELECT CAST((revenue / 50) AS int) AS segment
    FROM my_revenue
)
SELECT segment, COUNT(*) AS num_customers, segment * 50 AS segment_base
FROM segments
GROUP BY segment
ORDER BY segment, num_customers
LIMIT 100;