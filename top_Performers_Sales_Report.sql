# 📊 Fiscal Year 2021 Sales Analysis Report 📊

## 💹 Section 1: Top 10 Customers by Net Sales Percentage 💼

### 🛠️ Step 1: Aggregate Net Sales
-- **Objective**: Calculate the total net sales for each customer in millions.
-- **Method**: Sum net sales and convert to millions for each customer.

	SELECT  
      c.customer,
      ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
    FROM net_sales s
    JOIN dim_customer c on s.customer_code = c.customer_code
	WHERE fiscal_year = 2021
    GROUP BY c.customer ;
    
### 📊 Step 2: Calculate Percentage Share of Net Sales
-- **Objective**: Determine each customer's percentage share of the total net sales.
-- **Method**: Use the window function to calculate the percentage over the total sum
  
   WITH cte1 AS (  
     SELECT  
      c.customer,
      ROUND(SUM(net_sales)/1000000,2) as net_sales_mln
    FROM net_sales s
    JOIN dim_customer c on s.customer_code = c.customer_code
	WHERE fiscal_year = 2021
    GROUP BY c.customer 
    )
    
    SELECT *,
    ROUND(net_sales_mln*100/sum(net_sales_mln) OVER() , 2)AS pct
    FROM cte1
    ORDER BY net_sales_mln DESC;
    
### 🌐 Section 2: Net Sales Percentage Share by Region

-- 🛠️ Step 1: Regional Net Sales Calculation
-- **Objective**: Aggregate net sales by customer within each region.
-- **Method**: Group net sales by customer and region and convert to millions.

      SELECT  
            c.customer,
            c.region,
            round(sum(net_sales)/1000000,2) as net_sales_mln
      FROM net_sales s
      JOIN dim_customer c on s.customer_code = c.customer_code
      WHERE fiscal_year = 2021
      GROUP BY c.customer, c.region;
      
### 📊 Step 2: Determine regional sales Percentage Share

-- Objective: Calculate each customer's share of net sales by region.
-- Method: Compute the percentage of regional net sales attributed to each customer.

      WITH cte1 AS (
		SELECT  
                c.customer,
				c.region,
				round(sum(net_sales)/1000000,2) as net_sales_mln
		FROM net_sales s
		JOIN dim_customer c on s.customer_code = c.customer_code
		WHERE fiscal_year = 2021
		GROUP BY c.customer, c.region
)
		SELECT *,
             net_sales_mln*100/sum(net_sales_mln) over (partition by region) as pct_share_region
        FROM cte1
        ORDER BY region, net_sales_mln desc;

 ### 🏆 Section 3: Top Products by Division Based on Quantity Sold
 
### 🛠️ Step 1: Total Quantity Sold by Product and Division
-- *Objective*: Sum the total quantity sold for each product within its division.
-- *Method*: Group the quantity sold by product and division.

    SELECT 
        p.division,
        p.product,
        sum(sold_quantity) as total_qty
    FROM fact_sales_monthly s
    JOIN dim_product p on p.product_code = s.product_code
    WHERE fiscal_year = 2021 
    GROUP BY p.product, p.division;
    
### 📊 Step 2: Rank Products Within Divisions
-- **Objective**: Identify top-selling products within each division.
-- **Method**: Apply a ranking to products based on the total quantity sold.
    
    WITH cte1 as (
    SELECT 
          p.division,
          p.product,
          sum(sold_quantity) as total_qty
	FROM fact_sales_monthly s
    JOIN dim_product p
    ON p.product_code= s.product_code
    WHERE fiscal_year= 2021 
    GROUP BY p.product,p.division),
    
	cte2 as(
    SELECT*,
            DENSE_RANK() OVER(PARTITION BY division ORDER BY total_qty DESC) as drnk
	FROM cte1)
    SELECT * FROM cte2
    WHERE drnk<=3;
    
### 🛍️ Section 4: Top Markets by Gross Sales in Each Region

## 🛠️ Step 1: Calculate Gross Sales in Millions
-- **Objective**: Determine gross sales by market and region, expressed in millions.
-- **Method**: Sum the gross sales and convert this figure into millions.

    SELECT
         c.market,
         c.region,
    round(sum(gross_price_total)/1000000,2) as gross_sales_mln
    FROM gross_sales s
    JOIN dim_customer c on c.customer_code = s.customer_code
	WHERE fiscal_year = 2021
	GROUP BY  market, region;

### 📊 Step 2: Rank the Markets by Gross Sales
-- **Objective**: Ascertain the top markets by gross sales within each region.
-- **Method**: Rank the markets by their gross sales amount.

     WITH cte1 as 
     (
		SELECT
			c.market,
			c.region,
			round(sum(gross_price_total)/1000000,2) as gross_sales_mln
		FROM gross_sales s
		JOIN dim_customer c
		ON c.customer_code=s.customer_code
		WHERE fiscal_year=2021
		GROUP BY market,region
		ORDER BY gross_sales_mln desc
		),
		cte2 as 
        (
		SELECT *,
			DENSE_RANK() OVER(PARTITION BY region ORDER BY gross_sales_mln DESC) as drnk
		FROM cte1
		)
	    SELECT * FROM cte2 WHERE drnk<=2
		
 


    
