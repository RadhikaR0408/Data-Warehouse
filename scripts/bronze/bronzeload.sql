/*
===============================================================================
Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This script loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `LOAD DATA` command to load data from csv Files to bronze tables.

===============================================================================
*/


SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
SHOW SESSION VARIABLES LIKE 'local_infile';


-- ================================
-- Loading Bronze Layer (MySQL)
-- ================================

SELECT 'Loading Bronze Layer - START' AS log_message, NOW() AS log_time;

-- CRM TABLES

USE datawarehouse;
TRUNCATE TABLE bronze.crm_amazon_sale_report;

LOAD DATA LOCAL INFILE
'C:/sql/dataset/sales.crm/Amazon_Sale_Report.csv'
INTO TABLE bronze.crm_amazon_sale_report
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE bronze.crm_international_sale_report;

LOAD DATA LOCAL INFILE
'C:/sql/dataset/sales.crm/International_sale_Report.csv'
INTO TABLE bronze.crm_international_sale_report
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE bronze.crm_sale_report;

LOAD DATA LOCAL INFILE
'C:/sql/dataset/sales.crm/Sale_Report.csv'
INTO TABLE bronze.crm_sale_report
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ERP TABLES
TRUNCATE TABLE bronze.erp_Pl_Pricing_May2022;

LOAD DATA LOCAL INFILE
'C:/sql/dataset/pricing.erp/Pl_Pricing_May2022.csv'
INTO TABLE bronze.erp_Pl_Pricing_May2022
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE bronze.erp_expenses_iigf;

LOAD DATA LOCAL INFILE
'C:/sql/dataset/pricing.erp/expenses_iigf.csv'
INTO TABLE bronze.erp_expenses_iigf
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE bronze.erp_Pl_Pricing_March2021;

LOAD DATA LOCAL INFILE
'C:/sql/dataset//pricing.erp/Pl_Pricing_March2021.csv'
INTO TABLE bronze.erp_Pl_Pricing_March2021
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT 'Loading Bronze Layer - COMPLETED' AS log_message, NOW() AS log_time;


