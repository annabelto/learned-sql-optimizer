To optimize the given query, we will apply several data-independent rewrite rules that improve the readability and potentially the performance of the query by using explicit join syntax and moving conditions appropriately. Here are the steps and rules applied:

1. **Use explicit join syntax instead of comma-separated tables in the FROM clause** - This helps in clearly defining how tables are related.
2. **Replace implicit joins with explicit joins** - This involves converting the old SQL-89 join syntax (using commas in the FROM clause) to the SQL-92 syntax (using JOIN keyword).
3. **Use JOIN instead of WHERE for linking tables** - This makes the join conditions explicit in the JOIN clause rather than in the WHERE clause.
4. **Use explicit join conditions** - Ensures that all join conditions are clearly stated in the ON clause of the JOIN.
5. **Move conditions from WHERE clause to ON clause in JOINs** - This helps in potentially reducing the dataset early during the join process rather than filtering after joins.

### Original Query:
```sql
select ss_customer_sk, sum(act_sales) sumsales
from (
    select ss_item_sk, ss_ticket_number, ss_customer_sk,
           case
               when sr_return_quantity is not null then (ss_quantity-sr_return_quantity)*ss_sales_price
               else ss_quantity*ss_sales_price
           end as act_sales
    from store_sales
    left outer join store_returns on (sr_item_sk = ss_item_sk and sr_ticket_number = ss_ticket_number),
    reason
    where sr_reason_sk = r_reason_sk and r_reason_desc = 'reason 58'
) t
group by ss_customer_sk
order by sumsales, ss_customer_sk
limit 100;
```

### Optimized Query:
```sql
SELECT ss_customer_sk, SUM(act_sales) AS sumsales
FROM (
    SELECT ss_item_sk, ss_ticket_number, ss_customer_sk,
           CASE
               WHEN sr_return_quantity IS NOT NULL THEN (ss_quantity - sr_return_quantity) * ss_sales_price
               ELSE ss_quantity * ss_sales_price
           END AS act_sales
    FROM store_sales
    LEFT OUTER JOIN store_returns ON sr_item_sk = ss_item_sk AND sr_ticket_number = ss_ticket_number
    LEFT OUTER JOIN reason ON sr_reason_sk = r_reason_sk
    WHERE r_reason_desc = 'reason 58'
) AS t
GROUP BY ss_customer_sk
ORDER BY sumsales, ss_customer_sk
LIMIT 100;
```

### Explanation:
- **Step 1-4**: The original query used a comma to join `store_returns` and `reason` which was replaced with an explicit LEFT OUTER JOIN. The join condition between `store_returns` and `reason` was moved to the ON clause.
- **Step 5**: The filter condition `r_reason_desc = 'reason 58'` remains in the WHERE clause as it is not a join condition but a filter on the `reason` table.

This rewritten query is clearer in terms of join logic and conditions applied, which can help in better understanding and potentially better performance by allowing the database engine to optimize the join operations more effectively.