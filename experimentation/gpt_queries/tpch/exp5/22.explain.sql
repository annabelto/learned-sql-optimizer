-- Calculate the average account balance directly in the WHERE clause for comparison
explain select 
    substring(c_phone from 1 for 2) AS cntrycode, 
    COUNT(*) AS numcust, 
    SUM(c_acctbal) AS totacctbal
FROM 
    customer
WHERE 
    substring(c_phone from 1 for 2) IN ('16', '28', '14', '34', '21', '20', '29')
    AND c_acctbal > (
        SELECT AVG(c_acctbal) 
        FROM customer 
        WHERE c_acctbal > 0.00 
        AND substring(c_phone from 1 for 2) IN ('16', '28', '14', '34', '21', '20', '29')
    )
    AND NOT EXISTS (
        SELECT 1
        FROM orders
        WHERE o_custkey = customer.c_custkey
    )
GROUP BY 
    substring(c_phone from 1 for 2)
ORDER BY 
    substring(c_phone from 1 for 2)
LIMIT ALL;-- Calculate the average account balance directly in the WHERE clause for comparison
SELECT 
    substring(c_phone from 1 for 2) AS cntrycode, 
    COUNT(*) AS numcust, 
    SUM(c_acctbal) AS totacctbal
FROM 
    customer
WHERE 
    substring(c_phone from 1 for 2) IN ('16', '28', '14', '34', '21', '20', '29')
    AND c_acctbal > (
        SELECT AVG(c_acctbal) 
        FROM customer 
        WHERE c_acctbal > 0.00 
        AND substring(c_phone from 1 for 2) IN ('16', '28', '14', '34', '21', '20', '29')
    )
    AND NOT EXISTS (
        SELECT 1
        FROM orders
        WHERE o_custkey = customer.c_custkey
    )
GROUP BY 
    substring(c_phone from 1 for 2)
ORDER BY 
    substring(c_phone from 1 for 2)
LIMIT ALL;