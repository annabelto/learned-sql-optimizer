SELECT
    100.00 * SUM(
        CASE
            WHEN p_type LIKE 'PROMO%' THEN l_extendedprice * (1 - l_discount)
            ELSE 0
        END
    ) / SUM(l_extendedprice * (1 - l_discount)) AS promo_revenue
FROM
    (
        SELECT
            l.l_extendedprice,
            l.l_discount,
            p.p_type
        FROM
            lineitem l
        JOIN
            part p ON l.l_partkey = p.p_partkey
        WHERE
            l.l_shipdate >= DATE ':1'
            AND l.l_shipdate < DATE ':1' + INTERVAL '1 month'
    ) AS filtered_data;