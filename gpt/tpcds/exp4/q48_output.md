To ensure that the optimized query matches the output of the original query while striving for better performance, I will carefully maintain the logical structure of the original query. The focus will be on optimizing the execution without altering the result set.

### Optimized Query

```sql
SELECT SUM(ss_quantity)
FROM store_sales
JOIN store ON s_store_sk = ss_store_sk
JOIN date_dim ON ss_sold_date_sk = d_date_sk
JOIN customer_demographics ON cd_demo_sk = ss_cdemo_sk
JOIN customer_address ON ss_addr_sk = ca_address_sk
WHERE d_year = 2001
  AND ca_country = 'United States'
  AND (
    (cd_marital_status = 'S' AND cd_education_status = 'Secondary' AND ss_sales_price BETWEEN 100.00 AND 150.00 AND ca_state IN ('ND', 'NY', 'SD') AND ss_net_profit BETWEEN 0 AND 2000) OR
    (cd_marital_status = 'M' AND cd_education_status = '2 yr Degree' AND ss_sales_price BETWEEN 50.00 AND 100.00 AND ca_state IN ('MD', 'GA', 'KS') AND ss_net_profit BETWEEN 150 AND 3000) OR
    (cd_marital_status = 'D' AND cd_education_status = 'Advanced Degree' AND ss_sales_price BETWEEN 150.00 AND 200.00 AND ca_state IN ('CO', 'MN', 'NC') AND ss_net_profit BETWEEN 50 AND 25000)
  );
```

### Explanation of Changes:
1. **Logical Structure**: The query has been carefully structured to match the original query's logic exactly. This ensures that the output remains consistent with the original query.

2. **Performance Optimizations**:
   - **Index Utilization**: Ensure that there are indexes on the columns used in the `JOIN` and `WHERE` clauses. Particularly, consider the following indexes:
     - A composite index on `date_dim(ss_sold_date_sk, d_year)`.
     - A composite index on `customer_address(ss_addr_sk, ca_country)`.
     - Indexes on `store(s_store_sk)` and `customer_demographics(cd_demo_sk)` if not already present.
   - **Partitioning**: If the tables are large and queries frequently filter by columns like `d_year` or `ca_state`, consider partitioning these tables on these columns. This can significantly reduce the amount of data scanned during query execution.
   - **Query Plan Analysis**: Use `EXPLAIN` or `EXPLAIN ANALYZE` to check if the database is using the indexes effectively. Look for sequential scans that could be converted into index scans.
   - **Cost Threshold for Parallelism**: If the database supports parallel query execution, adjusting the cost threshold for parallelism might encourage the planner to use parallel plans for this query, which could reduce execution time on multi-core systems.
   - **Statistics Update**: Ensure that statistics are up to date for all involved tables using the `ANALYZE` command. This helps the planner make better decisions about join orders and methods.

By maintaining the exact logical structure of the original query and ensuring proper indexing and query planning, this optimized query should perform efficiently while producing the correct results.