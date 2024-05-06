explain select cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal
FROM (
    SELECT substring(c_phone FROM 1 FOR 2) AS cntrycode, c_acctbal
    FROM customer
    LEFT JOIN orders ON customer.c_custkey = orders.o_custkey
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
      AND c_acctbal > (
          SELECT AVG(c_acctbal)
          FROM customer
          WHERE c_acctbal > 0.00
            AND substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
      )
      AND orders.o_custkey IS NULL
) AS custsale
GROUP BY cntrycode
ORDER BY cntrycode
LIMIT ALL;SELECT cntrycode, COUNT(*) AS numcust, SUM(c_acctbal) AS totacctbal
FROM (
    SELECT substring(c_phone FROM 1 FOR 2) AS cntrycode, c_acctbal
    FROM customer
    LEFT JOIN orders ON customer.c_custkey = orders.o_custkey
    WHERE substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
      AND c_acctbal > (
          SELECT AVG(c_acctbal)
          FROM customer
          WHERE c_acctbal > 0.00
            AND substring(c_phone FROM 1 FOR 2) IN ('16', '28', '14', '34', '21', '20', '29')
      )
      AND orders.o_custkey IS NULL
) AS custsale
GROUP BY cntrycode
ORDER BY cntrycode
LIMIT ALL;