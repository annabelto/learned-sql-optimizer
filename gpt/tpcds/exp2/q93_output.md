To optimize the given query, we can apply several data-independent rewrite rules that can potentially improve the performance of the query execution. Here are the steps and rules I will use:

1. **Predicate Pushdown**: This involves moving the predicates as close as possible to the data source. It reduces the amount of data that needs to be processed in the upper layers of the query.

2. **Join Simplification**: Simplify the join conditions and ensure that unnecessary columns are not being joined or processed.

3. **Elimination of Redundant Subquery**: If possible, simplify the structure of the query by eliminating subqueries and integrating them into the main query body.

4. **Use of Explicit JOIN Syntax**: Convert implicit joins (comma-separated) into explicit JOIN syntax for better readability and potentially better optimization by the query planner.

### Original Query:
```sql
select ss_customer_sk, sum(act_sales) as sumsales
from (
    select ss_item_sk, ss_ticket_number, ss_customer_sk,
           case 
               when sr_return_quantity is not null then (ss_quantity - sr_return_quantity) * ss_sales_price
               else ss_quantity * ss_sales_price
           end as act_sales
    from store_sales
    left outer join store_returns on (sr_item_sk = ss_item_sk and sr_ticket_number = ss_ticket_number)
    , reason
    where sr_reason_sk = r_reason_sk and r_reason_desc = 'reason 58'
) t
group by ss_customer_sk
order by sumsales, ss_customer_sk
limit 100;
```

### Applying Optimization Rules:

1. **Predicate Pushdown**: Move the condition `r_reason_desc = 'reason 58'` closer to the `reason` table scan.

2. **Use of Explicit JOIN Syntax**: Convert the implicit join between `store_returns` and `reason` into an explicit JOIN.

### Optimized Query:
```sql
select ss_customer_sk, sum(act_sales) as sumsales
from (
    select ss_item_sk, ss_ticket_number, ss_customer_sk,
           case 
               when sr_return_quantity is not null then (ss_quantity - sr_return_quantity) * ss_sales_price
               else ss_quantity * ss_sales_price
           end as act_sales
    from store_sales
    left outer join store_returns on (sr_item_sk = ss_item_sk and sr_ticket_number = ss_ticket_number)
    left join reason on sr_reason_sk = r_reason_sk
    where r_reason_desc = 'reason 58'
) t
group by ss_customer_sk
order by sumsales, ss_customer_sk
limit 100;
```

In this optimized query:
- The `reason` table is now explicitly joined using a LEFT JOIN, which clarifies the relationship and ensures that the optimizer understands the join conditions.
- The filter `r_reason_desc = 'reason 58'` is applied directly in the subquery where `reason` is joined, which reduces the amount of data flowing into the outer query, potentially reducing the workload on the aggregation and sorting operations.