WITH filtered_customers AS (
    SELECT 
        c_custkey, 
        c_acctbal, 
        substring(c_phone from 1 for 2) as cntrycode
    FROM 
        customer
    WHERE 
        substring(c_phone from 1 for 2) IN ('16', '28', '14', '34', '21', '20', '29')
),
avg_acctbal AS (
    SELECT 
        avg(c_acctbal) as avg_balance
    FROM 
        filtered_customers
    WHERE 
        c_acctbal > 0.00
),
cust_without_orders AS (
    SELECT 
        cntrycode, 
        c_acctbal
    FROM 
        filtered_customers
    WHERE 
        NOT EXISTS (
            SELECT 1
            FROM orders
            WHERE o_custkey = filtered_customers.c_custkey
        )
        AND c_acctbal > (SELECT avg_balance FROM avg_acctbal)
)
SELECT 
    cntrycode, 
    count(*) as numcust, 
    sum(c_acctbal) as totacctbal
FROM 
    cust_without_orders
GROUP BY 
    cntrycode
ORDER BY 
    cntrycode
LIMIT ALL;