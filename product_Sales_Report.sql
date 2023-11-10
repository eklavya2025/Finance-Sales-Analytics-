# Chroma India Sales Report Generation for FY 2021

/* This file contains the SQL queries required to generate a sales report for Chroma India. 
   The sales report aggregates product sales on a monthly basis at the product code level for the fiscal year 2021. /*

## 📊 Report Fields

-- The final report will include the following fields:
-- Month and Quarter
-- Product Name
-- Variant
-- Sold Quantity
-- Gross Price Per Item
-- Gross Price Total

## 📑 Steps to Generate the Report

### Step 1: 🕵️ Identify Chroma Customer Code for the Indian Market

-- The first step is to find the CUSTOMER CODE for Chroma stores in the Indian market by querying the `dim_customer` table.

   SELECT * FROM dim_customer
   WHERE customer LIKE "%Croma%" AND market = "India";

### Step 2: 📊 Retrieve Sales Data for Chroma

-- Use the Chroma customer code to pull sales data from the 'fact_sales_monthly' table, with a focus on the sold quantity.

   SELECT * FROM fact_sales_monthly
   WHERE customer_code = 90002002
   ORDER BY sold_quantity DESC;

### Step 3: 📅 Filter Data for Fiscal Year 2021 and FISCAL QUARTER

-- Part A: 📆 Calendar Year 2021
-- Filter the sales data for the calendar year 2021 using the "YEAR date function".

   SELECT * FROM fact_sales_monthly
   WHERE customer_code = 90002002 
   AND YEAR(date) = 2021;

-- Part B: 🗓️ Fiscal Year 2021
-- Adjust the date to align with the fiscal calendar.
-- For fiscal year we need to add 4 months to calender Year and the formula we will use is [Date_Add()]
-- Since we need to fetch YEAR so before the formula we will add 'YEAR'
-- Formula = [YEAR[Date_Add()]]
   
   SELECT * FROM fact_sales_monthly
   WHERE customer_code=90002002 AND
   YEAR(DATE_ADD(DATE, INTERVAL 4 MONTH)) = 2021
   ORDER BY date DESC;
   
-- Alternatively, use a custom function get_fiscal_year for direct fiscal year retrieval.

   SELECT * FROM fact_sales_monthly
   WHERE customer_code = 90002002
   AND get_fiscal_year(date) = 2021
   ORDER BY date ASC ;
   
-- For FISCAL QUARTER
-- Like fiscal_year, use a custom function 'get_fiscal_quarter' for direct fiscal Quarter year retrieval.

   SELECT * FROM fact_sales_monthly
   WHERE customer_code=90002002 AND
     get_fiscal_year(date) = 2021 and
     get_fiscal_quarter(date) = "Q4"
   ORDER BY date 
   LIMIT 1000000;
   
   

### Step 4: 📝 Retrieve PRODUCT NAME,VARIANT and SOLD QUANTITY

-- Join the 'fact_sales_monthly' table with 'dim_product' to fetch product names,variants and sold quantity.

   SELECT s.product_code, s.date,
          p.product, p.variant,s.sold_quantity
   FROM fact_sales_monthly s
   JOIN dim_product p USING(product_code)
   WHERE customer_code = 90002002 AND
         get_fiscal_year(date) = 2021;
         
### Step 5: 💲 Retrieve GROSS PRICE PER ITEM and GROSS PRICE TOTAL

-- Join 'fact_sales_monthly' with 'fact_gross_price' to obtain the 'gross price per item' and the 'total gross price'.
-- For 'gross_price_total' we will multiply 'gross_price' with 'sold_quantity'

   SELECT s.product_code, s.date,
          p.product, p.variant, s.sold_quantity,
          g.gross_price, ROUND(g.gross_price * s.sold_quantity, 2) AS gross_price_total
   FROM fact_sales_monthly s
   JOIN dim_product p USING(product_code)
   JOIN fact_gross_price g 
        ON p.product_code = g.product_code AND 
           g.fiscal_year = get_fiscal_year(s.date)
   WHERE customer_code = 90002002 AND
         get_fiscal_year(date) = 2021
   ORDER BY date ASC
   LIMIT 1000000;



