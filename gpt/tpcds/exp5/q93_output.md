To optimize the given query, we will apply the provided data-independent rewrite rules. The original query uses a combination of explicit and implicit joins, and conditions are mixed between the WHERE clause and the ON clause of the JOIN. We will systematically apply the rules to make the query more readable and potentially more efficient by clearly defining join conditions and moving relevant filters to appropriate places.

### Rules Applied:
1. **Use explicit join syntax instead of comma-separated tables in the FROM clause.**
2. **Replace implicit joins with explicit joins.**
3. **Use JOIN instead of WHERE for linking tables.**
4. **Use JOIN instead of WHERE for combining tables.**
5. **Use explicit join conditions.**
6. **Move conditions from WHERE clause to ON clause in JOINs.**

### Original Query:
```sql
select ss_customer_sk, sum(act_sales) sumsales
from (
    select ss_item_sk, ss_ticket_number, ss_customer_sk,
           case when sr_return_quantity is not null then (ss_quantity-sr_return_quantity)*ss_sales_price
                else (ss_quantity*ss_sales_price) end act_sales
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
- **Rule 1, 2, 3, 4, 5:** The original query mixed implicit and explicit joins. We converted all joins to explicit LEFT OUTER JOINs and clearly defined the join conditions in the ON clauses.
- **Rule 6:** Moved the condition `r_reason_desc = 'reason 58'` from the WHERE clause of the subquery to the WHERE clause after the JOINs. This makes it clear that this condition is a filter applied after all joins have been processed.

This rewritten query is clearer in terms of join logic and filtering, which should help both in understanding the query and in performance by allowing the database engine to optimize the join operations more effectively.