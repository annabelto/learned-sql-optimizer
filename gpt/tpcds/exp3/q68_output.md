To optimize the given TPC-DS query, we can apply several data-independent rewrite rules that improve the query's performance without altering the result set. The rules include:

1. **Predicate Pushdown**: Move predicates as close as possible to the data source to reduce the number of rows processed early in the execution.
2. **Join Elimination**: Remove unnecessary joins if they do not contribute to the final result.
3. **Use of IN instead of OR**: Convert OR conditions into IN when checking for equality to a list of values, which can be more efficient.
4. **Explicit JOIN Syntax**: Replace implicit joins (comma-separated in FROM clause) with explicit JOIN syntax for better readability and control.
5. **Column Pruning**: Only select columns that are necessary for the final output or conditions.

### Original Query Analysis
The original query joins multiple tables and filters data based on several conditions. It also groups data and calculates sums over certain columns. The query involves filtering on date dimensions, household demographics, and store city, and it excludes customers who bought in the same city as their current address.

### Applying Optimization Rules

1. **Predicate Pushdown**: Push conditions on `date_dim`, `household_demographics`, and `store` closer to their respective table scans.
2. **Use of IN instead of OR**: Convert the year condition to use IN.
3. **Explicit JOIN Syntax**: Convert implicit joins to explicit JOINs for clarity.
4. **Column Pruning**: Ensure only necessary columns are selected in subqueries.

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

### Explanation
- **Explicit JOINs** are used instead of commas in the FROM clause.
- **Predicate Pushdown** is applied to filter rows as early as possible in the data retrieval process.
- **IN** is used for the year condition to simplify and potentially optimize the condition check.
- **Column Pruning**: The query only selects necessary columns in the subquery and main query.

This optimized query should perform better due to more efficient filtering and clearer join conditions.