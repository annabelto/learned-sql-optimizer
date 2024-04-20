WITH filtered_customers AS (
    SELECT 
        c_custkey,
        c_acctbal,
        substring(c_phone from 1 for 2) as cntrycode
    FROM 
        customer
    WHERE 
        substring(c_phone from 1 for 2) in (':1', ':2', ':3', ':4', ':5', ':6', ':7')
),
avg_acctbal AS (
    SELECT 
        avg(c_acctbal) as avg_balance
    FROM 
        filtered_customers
    WHERE 
        c_acctbal > 0.00
),
custsale AS (
    SELECT 
        cntrycode,
        c_acctbal
    FROM 
        filtered_customers
    WHERE 
        c_acctbal > (SELECT avg_balance FROM avg_acctbal)
        AND NOT EXISTS (
            SELECT 1
            FROM orders
            WHERE o_custkey = filtered_customers.c_custkey
        )
)
SELECT 
    cntrycode, 
    count(*) as numcust, 
    sum(c_acctbal) as totacctbal
FROM 
    custsale
GROUP BY 
    cntrycode
ORDER BY 
    cntrycode;