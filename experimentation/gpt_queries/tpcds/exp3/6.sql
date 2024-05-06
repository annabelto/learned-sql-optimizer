WITH avg_price AS (
    SELECT i_category, AVG(i_current_price) AS avg_price
    FROM item
    GROUP BY i_category
),
month_seq AS (
    SELECT d_month_seq
    FROM date_dim
    WHERE d_year = 2002 AND d_moy = 3
    LIMIT 1
)
SELECT a.ca_state AS state, COUNT(*) AS cnt
FROM customer_address a
JOIN customer c ON a.ca_address_sk = c.c_current_addr_sk
JOIN store_sales s ON c.c_customer_sk = s.ss_customer_sk
JOIN date_dim d ON s.ss_sold_date_sk = d.d_date_sk
JOIN item i ON s.ss_item_sk = i.i_item_sk
JOIN avg_price ap ON i.i_category = ap.i_category
JOIN month_seq ms ON d.d_month_seq = ms.d_month_seq
WHERE i.i_current_price > 1.2 * ap.avg_price
GROUP BY a.ca_state
HAVING COUNT(*) >= 10
ORDER BY cnt, a.ca_state
LIMIT 100;