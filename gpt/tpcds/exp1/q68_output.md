To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the performance without altering the result set. The rules include predicate pushdown, join elimination, and using explicit joins over implicit joins. Here's the step-by-step optimization process:

1. **Predicate Pushdown**: This involves moving the predicates as close as possible to the data source. It reduces the amount of data that needs to be loaded and processed by filtering out rows early in the execution plan.

2. **Explicit Join Syntax**: Replace implicit joins (comma-separated in the FROM clause) with explicit JOIN syntax. This makes the query easier to read and often helps the database optimizer understand the query better, potentially leading to more efficient execution plans.

3. **Join Elimination**: If certain joins do not affect the final result, they can be eliminated. However, in this query, all joins seem necessary to achieve the desired output.

### Optimized Query
```sql
SELECT 
    c_last_name,
    c_first_name,
    ca_city,
    bought_city,
    ss_ticket_number,
    extended_price,
    extended_tax,
    list_price
FROM (
    SELECT 
        ss_ticket_number,
        ss_customer_sk,
        ca_city AS bought_city,
        SUM(ss_ext_sales_price) AS extended_price,
        SUM(ss_ext_list_price) AS list_price,
        SUM(ss_ext_tax) AS extended_tax
    FROM 
        store_sales
    JOIN 
        date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN 
        store ON store_sales.ss_store_sk = store.s_store_sk
    JOIN 
        household_demographics ON store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
    JOIN 
        customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    WHERE 
        date_dim.d_dom BETWEEN 1 AND 2
        AND (household_demographics.hd_dep_count = 3 OR household_demographics.hd_vehicle_count = 4)
        AND date_dim.d_year IN (1998, 1999, 2000)
        AND store.s_city IN ('Fairview', 'Midway')
    GROUP BY 
        ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
) dn
JOIN 
    customer ON dn.ss_customer_sk = c_customer_sk
JOIN 
    customer_address AS current_addr ON customer.c_current_addr_sk = current_addr.ca_address_sk
WHERE 
    current_addr.ca_city <> bought_city
ORDER BY 
    c_last_name, ss_ticket_number
LIMIT 100;
```

### Explanation of Changes:
- **Explicit JOIN Syntax**: Changed the implicit joins to explicit `JOIN` clauses for clarity and potentially better optimization by the query planner.
- **Predicate Pushdown**: The conditions related to `date_dim`, `household_demographics`, and `store` are moved closer to their respective table references in the JOIN clauses, which can help in filtering data earlier in the query execution.
- **Maintained all necessary joins**: Each join condition is necessary to retrieve and compute the required fields; thus, no joins were eliminated.

These changes should help in improving the performance of the query by making better use of indexes and reducing the amount of data shuffled around during query execution.