# 📊 Gross Sales Reports for Chroma India

## 📅 Gross Monthly Sales Report

#-Description
-- The monthly gross sales report is designed to provide a snapshot of TOTAL GROSS SALES made to Chroma India during each MONTH.

### Step 1: Identify Chroma's Customer Code 🔍

-- Find the customer code for Chroma to join with the 'fact_sales_monthly' table and 'fact_gross_price'.

   SELECT *
   FROM fact_sales_monthly s
   JOIN fact_gross_price g
       ON g.product_code = s.product_code
       AND g.fiscal_year = get_fiscal_year(s.date)
   WHERE customer_code = 90002002
   ORDER BY s.date;
   
### Step 2: Aggregate Monthly Sales 📈
--  Group sales by month and calculate the total gross sales amount for that month.

   SELECT s.date, 
          ROUND(SUM(g.gross_price * s.sold_quantity), 2) AS monthly_sales
   FROM fact_sales_monthly s
   JOIN fact_gross_price g
       ON g.product_code = s.product_code
       AND g.fiscal_year = get_fiscal_year(s.date)
   WHERE customer_code = 90002002
   GROUP BY s.date
   ORDER BY s.date;
   
-- [Created Stored Procedures for Monthly Gross Sales with name 'get_monthly_gross_sales_for_customer']

##GROSS YEARLY SALES REPORT 🗓️

#-Description:
-- The yearly sales report aims to provide the total gross sales amount from Chroma India for each fiscal year.

### Step 1: Retrieve Chroma's Customer Code 🔍
--  Identify the customer code for Chroma in the Indian market.

    SELECT * FROM dim_customer
    WHERE customer LIKE "%croma%" AND market = "India";

### Step 2: Join Sales and Gross Price Data 🤝
--  Combine the 'fact_sales_monthly' and 'fact_gross_price' tables to prepare for the yearly aggregation.

    SELECT *
    FROM fact_sales_monthly s
    JOIN fact_gross_price g
        ON s.product_code = g.product_code
    AND g.fiscal_year = get_fiscal_year(s.date)
    WHERE customer_code = 90002002;

 ### Step 3: Aggregate Yearly Sales 📊
--   Calculate the total gross sales per year by multiplying the 'gross price' with the 'quantity sold', and then sum it up for each fiscal year.
    
    
     SELECT g.fiscal_year, ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS yearly_sales
     FROM fact_sales_monthly s
	 JOIN fact_gross_price g
          ON s.product_code = g.product_code
          AND g.fiscal_year = get_fiscal_year(s.date)
     WHERE customer_code = 90002002
     GROUP BY g.fiscal_year
     ORDER BY g.fiscal_year ASC;

-- [Created Stored Procedures for Yearly Gross Sales with name 'get_yearly_gross_sales_for_customer']