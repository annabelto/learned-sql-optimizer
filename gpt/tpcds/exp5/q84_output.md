To optimize the provided TPC-DS query, I will apply the following rules:

1. Use explicit join syntax instead of comma-separated tables in the FROM clause.
2. Replace implicit joins with explicit joins.
3. Use JOIN instead of WHERE for linking tables.
4. Use JOIN instead of WHERE for combining tables.
5. Use explicit join conditions.
6. Move conditions from WHERE clause to ON clause in JOINs.

### Optimized Query

```sql
SELECT 
    c_customer_id AS customer_id, 
    COALESCE(c_last_name, '') || ', ' || COALESCE(c_first_name, '') AS customername 
FROM 
    customer
JOIN 
    customer_address ON c_current_addr_sk = ca_address_sk
JOIN 
    customer_demographics ON cd_demo_sk = c_current_cdemo_sk
JOIN 
    household_demographics ON hd_demo_sk = c_current_hdemo_sk
JOIN 
    income_band ON ib_income_band_sk = hd_income_band_sk
JOIN 
    store_returns ON sr_cdemo_sk = cd_demo_sk
WHERE 
    ca_city = 'Woodland' 
    AND ib_lower_bound >= 60306 
    AND ib_upper_bound <= 60306 + 50000
ORDER BY 
    c_customer_id 
LIMIT 100;
```

### Explanation of Changes

1. **Explicit Join Syntax**: I replaced the comma-separated table list in the FROM clause with explicit JOIN clauses.
2. **Explicit Join Conditions**: I moved the join conditions from the WHERE clause to the respective ON clauses of the JOINs. This clarifies the relationships between the tables and can help the query optimizer.
3. **Filter Conditions**: Conditions that are not directly related to joining tables, such as `ca_city = 'Woodland'` and the conditions on `ib_lower_bound` and `ib_upper_bound`, remain in the WHERE clause. This separation helps maintain clarity and potentially allows for better use of indexes.
4. **Order and Limit**: These clauses remain unchanged as they are specific to the query's output requirements.

This rewritten query is more readable and potentially allows the database's query planner to optimize the execution plan better due to the explicit declaration of join conditions and separation of filtering conditions.