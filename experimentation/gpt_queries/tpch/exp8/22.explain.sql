-- Calculate the average account balance for customers with positive balances in specified countries
WITH AvgBalance AS (
    SELECT AVG(c_acctbal) AS avg_acctbal
    FROM customer
    WHERE c_acctbal > 0.00
      AND SUBSTRING(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
)

-- Main query to select country code, count of customers, and total account balance
explain select 
    SUBSTRING(c_phone FROM 1 FOR 2) AS cntrycode, 
    COUNT(*) AS numcust, 
    SUM(c_acctbal) AS totacctbal
FROM 
    customer
WHERE 
    SUBSTRING(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
    AND c_acctbal > (SELECT avg_acctbal FROM AvgBalance)
    AND NOT EXISTS (
        SELECT 1
        FROM orders
        WHERE o_custkey = customer.c_custkey
    )
GROUP BY 
    SUBSTRING(c_phone FROM 1 FOR 2)
ORDER BY 
    SUBSTRING(c_phone FROM 1 FOR 2)
LIMIT ALL;-- Calculate the average account balance for customers with positive balances in specified countries
WITH AvgBalance AS (
    SELECT AVG(c_acctbal) AS avg_acctbal
    FROM customer
    WHERE c_acctbal > 0.00
      AND SUBSTRING(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
)

-- Main query to select country code, count of customers, and total account balance
SELECT 
    SUBSTRING(c_phone FROM 1 FOR 2) AS cntrycode, 
    COUNT(*) AS numcust, 
    SUM(c_acctbal) AS totacctbal
FROM 
    customer
WHERE 
    SUBSTRING(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
    AND c_acctbal > (SELECT avg_acctbal FROM AvgBalance)
    AND NOT EXISTS (
        SELECT 1
        FROM orders
        WHERE o_custkey = customer.c_custkey
    )
GROUP BY 
    SUBSTRING(c_phone FROM 1 FOR 2)
ORDER BY 
    SUBSTRING(c_phone FROM 1 FOR 2)
LIMIT ALL;