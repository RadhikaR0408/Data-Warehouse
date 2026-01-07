CREATE SCHEMA IF NOT EXISTS gold;
DROP TABLE IF EXISTS gold.dim_product;

CREATE TABLE gold.dim_product AS
SELECT DISTINCT
    UPPER(TRIM(sku)) AS sku,
    TRIM(style_id) AS style_id,
    TRIM(category) AS category,
    TRIM(catalog) AS catalog,
    TRIM(weight) AS weight
FROM silver.erp_Pl_Pricing_May2022
WHERE sku IS NOT NULL;


DROP TABLE IF EXISTS gold.dim_date;

CREATE TABLE gold.dim_date AS
SELECT DISTINCT
    Date AS date_key,
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    MONTHNAME(Date) AS month_name,
    DAY(Date) AS day
FROM silver.crm_amazon_sale_report
WHERE Date IS NOT NULL;


DROP TABLE IF EXISTS gold.dim_channel;

CREATE TABLE gold.dim_channel AS
SELECT DISTINCT 'Amazon' AS channel
UNION
SELECT DISTINCT 'International';


/*-------------------------facts table--------------------------*/

DROP TABLE IF EXISTS gold.fact_sales;

CREATE TABLE gold.fact_sales AS
SELECT
    a.order_id,
    a.Date AS date_key,
    UPPER(a.sku) AS sku,
    'Amazon' AS channel,
    a.qty AS quantity,
    a.amount AS revenue,
    a.currency,
    a.ship_country,
    a.fulfilled_by
FROM silver.crm_amazon_sale_report a
WHERE a.amount > 0;

DROP TABLE IF EXISTS gold.fact_international_sales;

CREATE TABLE gold.fact_international_sales AS
SELECT
    date AS date_key,
    UPPER(sku) AS sku,
    customer_name,
    pcs AS quantity,
    gross_amt AS revenue,
    'International' AS channel
FROM silver.crm_international_sale_report
WHERE gross_amt > 0;

DROP TABLE IF EXISTS gold.fact_expenses;

CREATE TABLE gold.fact_expenses AS
SELECT
    expense_particular,
    COALESCE(amount1, amount2, received_amount) AS expense_amount,
    load_timestamp
FROM silver.erp_expenses_iigf
WHERE expense_particular IS NOT NULL;

DROP TABLE IF EXISTS gold.sales_monthly_summary;

CREATE TABLE gold.sales_monthly_summary AS
SELECT
    d.year,
    d.month,
    f.sku,
    SUM(f.quantity) AS total_qty,
    SUM(f.revenue) AS total_revenue
FROM gold.fact_sales f
JOIN gold.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year, d.month, f.sku;


