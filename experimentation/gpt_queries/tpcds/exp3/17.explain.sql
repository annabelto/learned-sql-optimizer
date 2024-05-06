explain select 
    i.i_item_id,
    i.i_item_desc,
    s.s_state,
    COUNT(ss.ss_quantity) AS store_sales_quantitycount,
    AVG(ss.ss_quantity) AS store_sales_quantityave,
    STDDEV_SAMP(ss.ss_quantity) AS store_sales_quantitystdev,
    STDDEV_SAMP(ss.ss_quantity) / AVG(ss.ss_quantity) AS store_sales_quantitycov,
    COUNT(sr.sr_return_quantity) AS store_returns_quantitycount,
    AVG(sr.sr_return_quantity) AS store_returns_quantityave,
    STDDEV_SAMP(sr.sr_return_quantity) AS store_returns_quantitystdev,
    STDDEV_SAMP(sr.sr_return_quantity) / AVG(sr.sr_return_quantity) AS store_returns_quantitycov,
    COUNT(cs.cs_quantity) AS catalog_sales_quantitycount,
    AVG(cs.cs_quantity) AS catalog_sales_quantityave,
    STDDEV_SAMP(cs.cs_quantity) AS catalog_sales_quantitystdev,
    STDDEV_SAMP(cs.cs_quantity) / AVG(cs.cs_quantity) AS catalog_sales_quantitycov
FROM 
    item i
JOIN 
    store_sales ss ON i.i_item_sk = ss.ss_item_sk
JOIN 
    store s ON s.s_store_sk = ss.ss_store_sk
JOIN 
    date_dim d1 ON d1.d_date_sk = ss.ss_sold_date_sk
JOIN 
    store_returns sr ON ss.ss_customer_sk = sr.sr_customer_sk 
                     AND ss.ss_item_sk = sr.sr_item_sk 
                     AND ss.ss_ticket_number = sr.sr_ticket_number
JOIN 
    date_dim d2 ON sr.sr_returned_date_sk = d2.d_date_sk
JOIN 
    catalog_sales cs ON sr.sr_customer_sk = cs.cs_bill_customer_sk 
                      AND sr.sr_item_sk = cs.cs_item_sk
JOIN 
    date_dim d3 ON cs.cs_sold_date_sk = d3.d_date_sk
WHERE 
    d1.d_quarter_name = '2001Q1'
    AND d2.d_quarter_name IN ('2001Q1', '2001Q2', '2001Q3')
    AND d3.d_quarter_name IN ('2001Q1', '2001Q2', '2001Q3')
GROUP BY 
    i.i_item_id, i.i_item_desc, s.s_state
ORDER BY 
    i.i_item_id, i.i_item_desc, s.s_state
LIMIT 100;SELECT 
    i.i_item_id,
    i.i_item_desc,
    s.s_state,
    COUNT(ss.ss_quantity) AS store_sales_quantitycount,
    AVG(ss.ss_quantity) AS store_sales_quantityave,
    STDDEV_SAMP(ss.ss_quantity) AS store_sales_quantitystdev,
    STDDEV_SAMP(ss.ss_quantity) / AVG(ss.ss_quantity) AS store_sales_quantitycov,
    COUNT(sr.sr_return_quantity) AS store_returns_quantitycount,
    AVG(sr.sr_return_quantity) AS store_returns_quantityave,
    STDDEV_SAMP(sr.sr_return_quantity) AS store_returns_quantitystdev,
    STDDEV_SAMP(sr.sr_return_quantity) / AVG(sr.sr_return_quantity) AS store_returns_quantitycov,
    COUNT(cs.cs_quantity) AS catalog_sales_quantitycount,
    AVG(cs.cs_quantity) AS catalog_sales_quantityave,
    STDDEV_SAMP(cs.cs_quantity) AS catalog_sales_quantitystdev,
    STDDEV_SAMP(cs.cs_quantity) / AVG(cs.cs_quantity) AS catalog_sales_quantitycov
FROM 
    item i
JOIN 
    store_sales ss ON i.i_item_sk = ss.ss_item_sk
JOIN 
    store s ON s.s_store_sk = ss.ss_store_sk
JOIN 
    date_dim d1 ON d1.d_date_sk = ss.ss_sold_date_sk
JOIN 
    store_returns sr ON ss.ss_customer_sk = sr.sr_customer_sk 
                     AND ss.ss_item_sk = sr.sr_item_sk 
                     AND ss.ss_ticket_number = sr.sr_ticket_number
JOIN 
    date_dim d2 ON sr.sr_returned_date_sk = d2.d_date_sk
JOIN 
    catalog_sales cs ON sr.sr_customer_sk = cs.cs_bill_customer_sk 
                      AND sr.sr_item_sk = cs.cs_item_sk
JOIN 
    date_dim d3 ON cs.cs_sold_date_sk = d3.d_date_sk
WHERE 
    d1.d_quarter_name = '2001Q1'
    AND d2.d_quarter_name IN ('2001Q1', '2001Q2', '2001Q3')
    AND d3.d_quarter_name IN ('2001Q1', '2001Q2', '2001Q3')
GROUP BY 
    i.i_item_id, i.i_item_desc, s.s_state
ORDER BY 
    i.i_item_id, i.i_item_desc, s.s_state
LIMIT 100;