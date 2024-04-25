WITH avg_acctbal AS (
    SELECT AVG(c_acctbal) AS avg_balance
    FROM customer
    WHERE c_acctbal > 0.00
      AND substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
)
SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal
FROM (
    SELECT substring(c_phone FROM 1 FOR 2) AS cntrycode, c_acctbal
    FROM customer
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
      AND c_acctbal > (SELECT avg_balance FROM avg_acctbal)
      AND NOT EXISTS (
          SELECT 1
          FROM orders
          WHERE o_custkey = c_custkey
      )
) AS custsale
GROUP BY cntrycode
ORDER BY cntrycode
LIMIT ALL;