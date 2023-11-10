# FY 2021 Net Sales Performance 📈🔍

## Overview
-#- This Query elucidates the step-by-step methodology implemented to EXTRACT, ANALYZE, and REPORT the net sales performance for FISCAL YEAR 2021
-#- The focus is on evaluating three pivotal segments:

-- 1.Top Markets 🌐
-- 2.Top Products 🏭
-- 3.Top Customers 🧑‍💼

## Methodology
-- The process is segmented into various steps, which involves creating SQL VIEWS and STORED PROCEDURES to streamline the extraction of relevant data.

### Step 1: Gathering Gross Sales Data 📈

--  We begin with a comprehensive SQL query that collects key sales data elements. 
--  This foundational query is designed to compile the gross sales details before any deductions are made .
   
   SELECT 
    c.market,
    s.product_code, 
    s.date,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(g.gross_price * s.sold_quantity, 2) AS gross_price_total, 
    pre.pre_invoice_discount_pct      
   FROM fact_sales_monthly s
   JOIN dim_product p ON s.product_code = p.product_code
   JOIN fact_gross_price g ON g.fiscal_year = s.fiscal_year AND s.product_code = g.product_code 
   JOIN fact_pre_invoice_deductions pre ON pre.customer_code= s.customer_code AND pre.fiscal_year = s.fiscal_year
   JOIN dim_customer c ON c.customer_code = s.customer_code
   WHERE s.fiscal_year = 2021
   ORDER BY date ASC
   LIMIT 1000000;
   
-- From this query, we extract critical data such as the GROSS PRICE PER ITEM, the TOTAL GROSS PRICE, 
-- and the PRE-INVOICE DISCOUNT % — all vital for the subsequent steps. 

### Step 2: Net Invoice Sales View 🧾

--  With the gross sales at hand, we construct a database view that applies pre-invoice discounts to determine the net invoice sales figures.

   SELECT *,
           (gross_price_total - (gross_price_total * pre_invoice_discount_pct)) AS net_invoice_sales
   FROM sales_preinv_discount;

-- This view simplifies the process of understanding our sales after initial discounts are considered, setting the stage for further deductions.

### Step 3: Including Post-Invoice Deductions 🧮

-- The third step fine-tunes our sales data by incorporating post-invoice deductions. 
-- These are captured in the following SQL statement that joins the deductions table with our net invoice sales view

   SELECT *,
            (1 - pre_invoice_discount_pct) * gross_price_total AS net_invoice_sales, 
            (po.discounts_pct + po.other_deductions_pct) AS post_invoice_discount_pct
   FROM sales_preinv_discount s
   JOIN fact_post_invoice_deductions po 
   ON s.customer_code = po.customer_code AND
	  s.product_code = po.product_code AND
	  s.date = po.date;

-- The output from this view gives us a clearer picture of the net sales after all possible deductions are applied.

### Step 4: Final Net Sales View 📊

-- Finally, we compile a view that reveals the actual net sales figures.
-- This view is the ultimate result of our SQL querying and forms the basis for our TOP MARKET, PRODUCT and CUSTOMER analysis

   SELECT *, (1 - post_invoice_discount_pct) * net_invoice_sales AS net_sales
   FROM sales_postinv_discount;
   
# Results
-- Using the views created above, we can now identify the highest performers in each category.

## Top Markets 🌎
-- These are the regions where we made the most sales.

   SELECT  
         market,
         ROUND(SUM(net_sales)/1000000,2) AS net_sales_mln
   FROM net_sales
   WHERE fiscal_year = 2021 
   GROUP BY market
   ORDER BY net_sales_mln DESC
   LIMIT 5;


## Top Customers 👤
-- Here we see which customers contributed the most to our sales.

  SELECT  
       c.customer,
       ROUND(SUM(net_sales)/1000000,2) AS net_sales_mln
  FROM net_sales n
  JOIN dim_customer c ON n.customer_code = c.customer_code
  WHERE fiscal_year = 2021 
  GROUP BY c.customer
  ORDER BY net_sales_mln DESC
  LIMIT 5;


## Top Products 📦
-- These are the products that sold the most.

   SELECT  
    p.product,
    ROUND(SUM(net_sales)/1000000,2) AS net_sales_mln
   FROM net_sales n
   JOIN dim_product p ON n.product_code = p.product_code
   WHERE fiscal_year = 2021 
   GROUP BY p.product
   ORDER BY net_sales_mln DESC
   LIMIT 5;





  


