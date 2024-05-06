WITH my_customers AS (
    SELECT DISTINCT c_customer_sk, c_current_addr_sk
    FROM (
        SELECT cs_sold_date_sk AS sold_date_sk, cs_bill_customer_sk AS customer_sk, cs_item_sk AS item_sk
        FROM catalog_sales
        WHERE EXISTS (
            SELECT 1
            FROM date_dim
            WHERE cs_sold_date_sk = date_dim.d_date_sk
              AND date_dim.d_moy = 1
              AND date_dim.d_year = 1999
        )
        UNION ALL
        SELECT ws_sold_date_sk AS sold_date_sk, ws_bill_customer_sk AS customer_sk, ws_item_sk AS item_sk
        FROM web_sales
        WHERE EXISTS (
            SELECT 1
            FROM date_dim
            WHERE ws_sold_date_sk = date_dim.d_date_sk
              AND date_dim.d_moy = 1
              AND date_dim.d_year = 1999
        )
    ) cs_or_ws_sales
    JOIN item ON cs_or_ws_sales.item_sk = item.i_item_sk
    JOIN customer ON customer.c_customer_sk = cs_or_ws_sales.customer_sk
    WHERE item.i_category = 'Music'
      AND item.i_class = 'country'
),
my_revenue AS (
    SELECT c_customer_sk, SUM(ss_ext_sales_price) AS revenue
    FROM my_customers
    JOIN store_sales ON my_customers.c_customer_sk = store_sales.ss_customer_sk
    JOIN customer_address ON my_customers.c_current_addr_sk = customer_address.ca_address_sk
    JOIN store ON customer_address.ca_county = store.s_county
      AND customer_address.ca_state = store.s_state
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE date_dim.d_month_seq BETWEEN (
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
explain select segment, COUNT(*) AS num_customers, segment * 50 AS segment_base
FROM segments
GROUP BY segment
ORDER BY segment, num_customers
LIMIT 100;WITH my_customers AS (
    SELECT DISTINCT c_customer_sk, c_current_addr_sk
    FROM (
        SELECT cs_sold_date_sk AS sold_date_sk, cs_bill_customer_sk AS customer_sk, cs_item_sk AS item_sk
        FROM catalog_sales
        WHERE EXISTS (
            SELECT 1
            FROM date_dim
            WHERE cs_sold_date_sk = date_dim.d_date_sk
              AND date_dim.d_moy = 1
              AND date_dim.d_year = 1999
        )
        UNION ALL
        SELECT ws_sold_date_sk AS sold_date_sk, ws_bill_customer_sk AS customer_sk, ws_item_sk AS item_sk
        FROM web_sales
        WHERE EXISTS (
            SELECT 1
            FROM date_dim
            WHERE ws_sold_date_sk = date_dim.d_date_sk
              AND date_dim.d_moy = 1
              AND date_dim.d_year = 1999
        )
    ) cs_or_ws_sales
    JOIN item ON cs_or_ws_sales.item_sk = item.i_item_sk
    JOIN customer ON customer.c_customer_sk = cs_or_ws_sales.customer_sk
    WHERE item.i_category = 'Music'
      AND item.i_class = 'country'
),
my_revenue AS (
    SELECT c_customer_sk, SUM(ss_ext_sales_price) AS revenue
    FROM my_customers
    JOIN store_sales ON my_customers.c_customer_sk = store_sales.ss_customer_sk
    JOIN customer_address ON my_customers.c_current_addr_sk = customer_address.ca_address_sk
    JOIN store ON customer_address.ca_county = store.s_county
      AND customer_address.ca_state = store.s_state
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE date_dim.d_month_seq BETWEEN (
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