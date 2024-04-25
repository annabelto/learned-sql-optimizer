WITH avg_acctbal AS (
    SELECT AVG(c_acctbal) AS avg 
    FROM customer 
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
), 
cust AS (
    SELECT substring(c_phone FROM 1 FOR 2) AS cntrycode, c_acctbal, c_custkey 
    FROM customer 
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
), 
custsale AS (
    SELECT cntrycode, c_acctbal 
    FROM cust 
    LEFT JOIN orders ON cust.c_custkey = orders.o_custkey 
    WHERE orders.o_custkey IS NULL 
    AND c_acctbal > (SELECT avg FROM avg_acctbal)
)
explain select cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal 
FROM custsale 
GROUP BY cntrycode 
ORDER BY cntrycode;WITH avg_acctbal AS (
    SELECT AVG(c_acctbal) AS avg 
    FROM customer 
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
), 
cust AS (
    SELECT substring(c_phone FROM 1 FOR 2) AS cntrycode, c_acctbal, c_custkey 
    FROM customer 
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
), 
custsale AS (
    SELECT cntrycode, c_acctbal 
    FROM cust 
    LEFT JOIN orders ON cust.c_custkey = orders.o_custkey 
    WHERE orders.o_custkey IS NULL 
    AND c_acctbal > (SELECT avg FROM avg_acctbal)
)
SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal 
FROM custsale 
GROUP BY cntrycode 
ORDER BY cntrycode;