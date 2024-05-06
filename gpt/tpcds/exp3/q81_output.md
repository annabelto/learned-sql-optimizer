Apologies for the oversight in the previous query. Let's correct the join condition by using the appropriate column names and ensure the query is syntactically correct.

### Optimized Query
```sql
WITH customer_total_return AS (
    SELECT 
        cr_returning_customer_sk AS ctr_customer_sk,
        ca_state AS ctr_state,
        SUM(cr_return_amt_inc_tax) AS ctr_total_return
    FROM 
        catalog_returns
        JOIN date_dim ON cr_returned_date_sk = d_date_sk
        JOIN customer_address ON cr_returning_addr_sk = ca_address_sk
    WHERE 
        d_year = 2001
    GROUP BY 
        cr_returning_customer_sk, ca_state
), state_avg_return AS (
    SELECT 
        ctr_state, 
        AVG(ctr_total_return) * 1.2 AS avg_state_return
    FROM 
        customer_total_return
    GROUP BY 
        ctr_state
)
SELECT 
    c_customer_id, c_salutation, c_first_name, c_last_name,
    ca_street_number, ca_street_name, ca_street_type, ca_suite_number,
    ca_city, ca_county, ca_state, ca_zip, ca_country, ca_gmt_offset,
    ca_location_type, ctr1.ctr_total_return
FROM 
    customer_total_return ctr1
    JOIN customer ON ctr1.ctr_customer_sk = customer.c_customer_sk
    JOIN customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
    JOIN state_avg_return sar ON ctr1.ctr_state = sar.ctr_state
WHERE 
    ctr1.ctr_total_return > sar.avg_state_return
    AND customer_address.ca_state = 'TN'
ORDER BY 
    c_customer_id, c_salutation, c_first_name, c_last_name,
    ca_street_number, ca_street_name, ca_street_type, ca_suite_number,
    ca_city, ca_county, ca_state, ca_zip, ca_country, ca_gmt_offset,
    ca_location_type, ctr_total_return
LIMIT 100;
```

In this corrected version:
- The join condition between `customer` and `customer_address` has been corrected to use `customer.c_current_addr_sk` which matches with `customer_address.ca_address_sk`.
- The filter on `ca_state = 'TN'` is correctly applied on the `customer_address` table.
- The subquery for calculating the average state return (`state_avg_return`) is used to filter customers whose total return is greater than 1.2 times the average return of their state, ensuring the calculation is done once per state and reused, which optimizes performance.