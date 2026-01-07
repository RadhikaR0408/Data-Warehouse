/*
===============================================================================
Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This script performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.

===============================================================================
*/


INSERT INTO silver.crm_amazon_sale_report
SELECT
    row_index,
    order_id,
    Date,
    TRIM(status) AS status,
    TRIM(fulfilment) AS fulfilment,
    TRIM(sales_channel) AS sales_channel,
    TRIM(ship_service_level) AS ship_service_level,
    TRIM(style) AS style,
    UPPER(TRIM(sku)) AS sku,
    TRIM(category) AS category,
    TRIM(size) AS size,
    asin,
    TRIM(courier_status) AS courier_status,
    IFNULL(qty, 0) AS qty,
    currency,
    IFNULL(amount, 0) AS amount,
    TRIM(ship_city) AS ship_city,
    TRIM(ship_state) AS ship_state,
    ship_postal_code,
    TRIM(ship_country) AS ship_country,
    promotion_ids,
    b2b,
    fulfilled_by
FROM bronze.crm_amazon_sale_report
WHERE sku IS NOT NULL;

INSERT INTO silver.crm_international_sale_report
SELECT
    STR_TO_DATE(date_str, '%d/%m/%Y') AS date,
    month_name,
    TRIM(customer_name) AS customer_name,
    TRIM(style) AS style,
    UPPER(TRIM(sku)) AS sku,
    size,
    IFNULL(pcs, 0) AS pcs,
    IFNULL(rate, 0) AS rate,
    IFNULL(gross_amt, 0) AS gross_amt
FROM (
    SELECT
        CAST(date AS CHAR(20)) AS date_str,
        month_name,
        customer_name,
        style,
        sku,
        size,
        pcs,
        rate,
        gross_amt
    FROM bronze.crm_international_sale_report
    WHERE sku IS NOT NULL
) t
WHERE date_str REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';

INSERT INTO silver.crm_sale_report
SELECT
    row_index,
    UPPER(TRIM(sku_code)) AS sku_code,
    design_no,
    CAST(NULLIF(stock, '') AS UNSIGNED) AS stock,
    category,
    size,
    color
FROM bronze.crm_sale_report
WHERE
    sku_code IS NOT NULL
    AND TRIM(sku_code) <> '';

INSERT INTO silver.erp_Pl_Pricing_May2022
SELECT
    row_index,
    UPPER(TRIM(sku)) AS sku,
    style_id,
    catalog,
    category,
    weight,
    tp,
    mrp_old,
    finalmrp_old,
    ajio_mrp,
    amazon_mrp,
    amazonfba_mrp,
    flipkart_mrp,
    limeroad_mrp,
    myntra_mrp,
    paytm_mrp,
    snapdeal_mrp,
    source_file,
    load_timestamp
FROM bronze.erp_Pl_Pricing_May2022
WHERE sku IS NOT NULL;


INSERT INTO silver.erp_Pl_Pricing_March2021
SELECT
    row_index,
    UPPER(TRIM(sku)) AS sku,
    style_id,
    catalog,
    category,
    weight,
    tp_1,
    tp_2,
    mrp_old,
    finalmrp_old,
    ajio_mrp,
    amazon_mrp,
    amazonfba_mrp,
    flipkart_mrp,
    limeroad_mrp,
    myntra_mrp,
    paytm_mrp,
    snapdeal_mrp,
    source_file,
    load_timestamp
FROM bronze.erp_Pl_Pricing_March2021
WHERE sku IS NOT NULL;


INSERT INTO silver.erp_expenses_iigf
SELECT
    row_index,
    IFNULL(received_amount, 0) AS received_amount,
    IFNULL(amount1, 0) AS amount1,
    TRIM(expense_particular) AS expense_particular,
    IFNULL(amount2, 0) AS amount2,
    load_timestamp
FROM bronze.erp_expenses_iigf;
