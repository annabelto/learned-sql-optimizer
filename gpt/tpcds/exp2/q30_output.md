To optimize the given PostgreSQL query, we can apply several data-independent rewrite rules that improve the performance without altering the results. The rules include:

1. **Predicate Pushdown**: Move predicates into the subquery or CTE (Common Table Expression) to reduce the size of the intermediate result sets.
2. **Join Elimination**: Remove unnecessary joins if the join attributes are not used in the SELECT, WHERE, or having a direct impact on the query result.
3. **Common Subexpression Elimination**: Identify and eliminate redundant subexpressions to avoid repeated calculations.
4. **Using Explicit JOINs**: Convert implicit joins (comma-separated in FROM clause) to explicit JOIN syntax for better readability and control.

### Original Query Analysis
The original query uses a CTE to calculate the total returns by customer and state for the year 2000. It then filters customers based on whether their total return is greater than 1.2 times the average return of customers in the same state. It also joins with the customer table to fetch customer details, filtering for customers in the state 'AR'.

### Applying Optimization Rules

1. **Predicate Pushdown**: We can push the condition `ca_state = 'AR'` into the CTE to reduce the number of rows processed in the outer query.
2. **Using Explicit JOINs**: Convert the implicit joins to explicit JOIN syntax to clarify the join conditions and potentially allow the optimizer to better understand the query structure.

### Optimized Query
```sql
WITH customer_total_return AS (
    SELECT 
        wr_returning_customer_sk AS ctr_customer_sk,
        ca_state AS ctr_state,
        SUM(wr_return_amt) AS ctr_total_return
    FROM 
        web_returns
    JOIN 
        date_dim ON wr_returned_date_sk = d_date_sk
    JOIN 
        customer_address ON wr_returning_addr_sk = ca_address_sk
    WHERE 
        d_year = 2000 AND ca_state = 'AR'
    GROUP BY 
        wr_returning_customer_sk, ca_state
)
SELECT 
    c_customer_id,
    c_salutation,
    c_first_name,
    c_last_name,
    c_preferred_cust_flag,
    c_birth_day,
    c_birth_month,
    c_birth_year,
    c_birth_country,
    c_login,
    c_email_address,
    c_last_review_date,
    ctr_total_return
FROM 
    customer_total_return ctr1
JOIN 
    customer ON ctr1.ctr_customer_sk = c_customer_sk
WHERE 
    ctr_total_return > (
        SELECT AVG(ctr_total_return) * 1.2
        FROM customer_total_return ctr2
        WHERE ctr1.ctr_state = ctr2.ctr_state
    )
ORDER BY 
    c_customer_id, c_salutation, c_first_name, c_last_name, c_preferred_cust_flag,
    c_birth_day, c_birth_month, c_birth_year, c_birth_country, c_login, c_email_address,
    c_last_review_date, ctr_total_return
LIMIT 100;
```

### Explanation
- **Predicate Pushdown**: The condition `ca_state = 'AR'` is moved into the CTE to filter rows early.
- **Using Explicit JOINs**: The query now uses explicit JOIN syntax, which helps in understanding the join conditions and ensures that the optimizer can process the query more efficiently.

These changes should help in reducing the execution time of the query by limiting the amount of data processed and clearly defining join conditions.