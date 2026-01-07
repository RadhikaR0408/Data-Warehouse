/*
===============================================================================
bronzetable Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
===============================================================================
*/


CREATE SCHEMA IF NOT EXISTS bronze; 

DROP TABLE IF EXISTS bronze.crm_amazon_sale_report; 
CREATE TABLE bronze.crm_amazon_sale_report ( 
    row_index INT, order_id VARCHAR(50), 
    Date DATE, status VARCHAR(50), 
    fulfilment VARCHAR(50), 
    sales_channel VARCHAR(50), 
    ship_service_level VARCHAR(50), 
    style VARCHAR(50), 
    sku VARCHAR(50), 
    category VARCHAR(50), 
    size VARCHAR(50), 
    sin VARCHAR(20), 
    courier_status VARCHAR(50), 
    qty INT, 
    currency VARCHAR(10), 
    amount DECIMAL(10,2), 
    ship_city VARCHAR(100), 
    ship_state VARCHAR(100), 
    ship_postal_code VARCHAR(20), 
    ship_country VARCHAR(50), 
    promotion_ids VARCHAR(255), 
    b2b VARCHAR(10), 
    fulfilled_by VARCHAR(50) 
  ); 

DROP TABLE IF EXISTS bronze.crm_international_sale_report; 
  
  CREATE TABLE bronze.crm_international_sale_report( 
        date DATE, month_name VARCHAR(20), 
        customer_name VARCHAR(100), 
        style VARCHAR(50), 
        sku VARCHAR(50), 
        size VARCHAR(20), 
        pcs INT, 
        rate DECIMAL(10,2), 
        gross_amt DECIMAL(12,2) 
    ); 

DROP TABLE IF EXISTS bronze.crm_sale_report;

  CREATE TABLE bronze.crm_sale_report ( 
            row_index INT, 
            sku_code VARCHAR(50), 
            design_no VARCHAR(50), 
            stock INT, 
            category VARCHAR(50), 
            size VARCHAR(20), 
            color VARCHAR(50) 
    ); 

DROP TABLE IF EXISTS bronze.erp_Pl_Pricing_May2022; 
  
  CREATE TABLE bronze.erp_Pl_Pricing_May2022 ( 
                row_index INT, 
                sku VARCHAR(50), 
                style_id VARCHAR(50), 
                catalog VARCHAR(100), 
                category VARCHAR(100), 
                weight VARCHAR(20), 
                tp VARCHAR(20), 
                mrp_old VARCHAR(20), 
                finalmrp_old VARCHAR(20), 
                ajio_mrp VARCHAR(20), 
                amazon_mrp VARCHAR(20), 
                amazonfba_mrp VARCHAR(20), 
                flipkart_mrp VARCHAR(20), 
                limeroad_mrp VARCHAR(20), 
                myntra_mrp VARCHAR(20), 
                paytm_mrp VARCHAR(20), 
                snapdeal_mrp VARCHAR(20), 
                source_file VARCHAR(100), 
                load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 


DROP TABLE IF EXISTS bronze.erp_expenses_iigf; 

  CREATE TABLE bronze.erp_expenses_iigf ( 
    row_index INT, 
    received_amount DECIMAL(12,2), 
    amount1 DECIMAL(12,2), 
    expense_particular VARCHAR(255), 
    amount2 DECIMAL(12,2), 
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 ); 


DROP TABLE IF EXISTS bronze.erp_Pl_Pricing_March2021;

    CREATE TABLE bronze.erp_Pl_Pricing_March2021 ( 
        row_index INT, 
        sku VARCHAR(50), 
        style_id VARCHAR(50), 
        catalog VARCHAR(100), 
        category VARCHAR(100), 
        weight VARCHAR(20), 
        tp_1 VARCHAR(20), 
        tp_2 VARCHAR(20), 
        mrp_old VARCHAR(20), 
        finalmrp_old VARCHAR(20), 
        ajio_mrp VARCHAR(20), 
        amazon_mrp VARCHAR(20), 
        amazonfba_mrp VARCHAR(20), 
        flipkart_mrp VARCHAR(20), 
        limeroad_mrp VARCHAR(20), 
        myntra_mrp VARCHAR(20), 
        paytm_mrp VARCHAR(20), 
        snapdeal_mrp VARCHAR(20), 
        source_file VARCHAR(100), 
        load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
      );
