# Finance-Sales-Analytics README

## Overview
This README document serves as an overview and guide for understanding the various sales reports for various Fiscal Years. It encapsulates details from the Product Sales Report to the Top Performers Sales Report, offering insights into gross and net sales, product performance, and market standings. It also captures an in-depth look at product performance, sales trends, and customer insights, leveraging data from various internal tables and databases.

## Table of Contents
1. [Product Sales Report](#product-sales-report)
2. [Gross Sales Report](#gross-sales-report)
3. [Net Sales Report](#net-sales-report)
4. [Top Performers Sales Report](#top-performers-sales-report)
5. [Sales Performance Insights](#sales-performance-insights)

<a id="product-sales-report"></a>
# Product Sales Report 📈 

## Report Fields 📊
The Product Sales Report includes several key fields, each offering vital insights:
1. 📅 **Month and Quarter**: Reflecting the time frames of sales, facilitating a temporal analysis of sales trends.
2. 🛍️ **Product Name**: Detailing the names of products sold, crucial for identifying which products are performing well.
3. 🔄 **Variant**: Indicating different versions or models of each product, providing a granular view of sales.
4. 🔢 **Sold Quantity**: The number of units sold, a direct measure of demand and popularity.
5. 💲 **Gross Price Per Item**: The initial price per item, offering insights into pricing strategy and customer spending.
6. 🧮 **Gross Price Total**: The total revenue generated, calculated as sold quantity times the gross price per item.

## Data Sources 🗂️
The SQL script for the Product Sales Report utilizes data from several key tables:
1. **dim_customer**: Provides information about customers, specifically used to identify Chroma's unique customer code in the Indian market.
2. **fact_sales_monthly**: The central table for sales data, which includes detailed monthly sales figures.
3. **dim_product**: Offers comprehensive details about products, including names and variants.
4. **fact_gross_price**: Contains essential pricing information for each product.

## Methodology ⚙️
The methodology for generating the Product Sales Report combines structured SQL queries and analytical steps:
1. 🔍 **Identifying Chroma Customer Code**:
   - *Query*: A selection from `dim_customer` to find the specific customer code for Chroma in India.
   - *Purpose*: Isolating sales data relevant to Chroma.
2. 📈 **Retrieving Sales Data**:
   - *Query*: Extracting data from `fact_sales_monthly` using Chroma's identified customer code.
   - *Purpose*: Gathering comprehensive sales figures for analysis.
3. 📆 **Filtering Data for Fiscal Year 2021**:
   - *Query*: Applying filters and utilizing custom functions like `get_fiscal_year` and `get_fiscal_quarter`.
   - *Purpose*: Aligning sales data with the fiscal year and quarters for accurate temporal analysis.
4. 🏷️ **Joining with Product Information**:
   - *Query*: Merging sales data with `dim_product` for detailed product insights.
   - *Purpose*: Enriching sales data with product names and variants for a more detailed analysis.
5. 💵 **Calculating Gross Pricing**:
   - *Query*: Combining sales data with `fact_gross_price` to compute pricing details.
   - *Purpose*: Determining the gross revenue and understanding pricing strategy impacts.
     
[Back to Table of Contents](#table-of-contents)
     
<a id="gross-sales-report"></a>
# Gross Sales Report 📊

## Data Sources 🗂️
The Gross Sales Report analysis relies on data from several key tables in a SQL database:
1. **fact_sales_monthly**: Contains detailed sales data on a monthly basis, including product codes, quantities sold, and sales dates, essential for constructing the monthly gross sales report.
2. **fact_gross_price**: Provides gross price data for different products, used in conjunction with the fact_sales_monthly table to calculate total gross sales.
3. **dim_customer**: The customer dimension table, crucial for identifying Chroma's specific customer code, used to filter data relevant to Chroma India from the overall sales data.

## Methodology 📊

### Monthly Sales Report 📅
1. **Isolating Chroma India's Transactions**:
   - *Action*: Pinpointing Chroma India's specific transactions within the database.
   - *SQL Process*: SELECT query on dim_customer, filtering for records resembling 'Chroma' in the Indian market.
2. **Data Preparation - Joining Sales and Price Data**:
   - *Action*: Preparing datasets for monthly analysis by merging sales figures with pricing data.
   - *SQL Process*: JOIN operation between fact_sales_monthly and fact_gross_price, matching product_code and aligning fiscal_year from sales date.
3. **Computing Monthly Gross Sales**:
   - *Action*: Calculating total gross sales for each month.
   - *SQL Process*: SELECT query that aggregates data by multiplying gross_price with sold_quantity, then summing these values monthly.

### Yearly Sales Report 🗓️
1. **Dataset Consolidation for Yearly Analysis**:
   - *Action*: Consolidating data for an annual sales overview.
   - *SQL Process*: Joining technique similar to the monthly report, focusing on annual data aggregation.
2. **Annual Gross Sales Calculation**:
   - *Action*: Aggregating and calculating total gross sales per fiscal year.
   - *SQL Process*: SELECT query multiplying sold_quantity by gross_price for each product, summing annually and grouping by fiscal_year.

### Additional SQL Techniques and Processes:
- **Stored Procedures Utilization**: Creation and use of stored procedures like get_monthly_gross_sales_for_customer and get_yearly_gross_sales_for_customer for reusability and operational ease.
- **Effective Data Organization**: Strategic use of ORDER BY and GROUP BY clauses in SQL queries for correct aggregation and organized presentation of data.

[Back to Table of Contents](#table-of-contents)

<a id="net-sales-report"></a>
# 📈 Net Sales Report

## Data Source 🗂️
The data for the Net Sales Report is sourced from a comprehensive SQL database, including several tables with detailed sales information:
1. **Fact Sales Monthly (fact_sales_monthly)**: Contains monthly sales data such as product codes, sold quantities, and customer codes.
2. **Dimension Product (dim_product)**: Provides detailed product information, including product codes and variants.
3. **Fact Gross Price (fact_gross_price)**: Lists gross prices of products, linked to fiscal years and product codes.
4. **Fact Pre-Invoice Deductions (fact_pre_invoice_deductions)**: Contains data on discounts and deductions applied before finalizing the invoice.
5. **Dimension Customer (dim_customer)**: Holds customer-related data, including customer codes and market information.
6. **Fact Post-Invoice Deductions (fact_post_invoice_deductions)**: Details additional deductions applied after invoice issuance.

## Methodology and Steps 🛠️
### Step 1: Gathering Gross Sales Data 📈
- **Objective**: Compile initial sales data before any deductions.
- **Data Elements**: Market, Product Code, Date, Product details, Sold Quantity, Gross Price Per Item, Total Gross Price, Pre-Invoice Discount Percentage.
- **Tables Used**: fact_sales_monthly, dim_product, fact_gross_price, fact_pre_invoice_deductions, dim_customer.
- **Focus**: Extract foundational sales data for further analysis.

### Step 2: Net Invoice Sales View 📊
- **Objective**: Calculate net invoice sales figures after pre-invoice discounts.
- **Process**: Deduct pre-invoice discounts from gross sales to determine net invoice sales.
- **Use**: Refine data to represent sales after initial discounts.

### Step 3: Including Post-Invoice Deductions 🧮
- **Objective**: Incorporate post-invoice deductions into sales data.
- **Elements**: Post-Invoice Deductions Percentage.
- **Tables Used**: sales_preinv_discount, fact_post_invoice_deductions.
- **Purpose**: Refine sales figures by accounting for deductions post invoice issuance.

### Step 4: Final Net Sales View 📉
- **Objective**: Compile actual net sales figures after all deductions.
- **Application**: Essential for deep analysis of Top Markets 🌐, Top Products 🏭, and Top Customers 🧑‍💼.
- **Insight Generation**: Generate actionable insights on highest-performing markets, most profitable products, and most valuable customers.

## Top Reporting Analysis 📊
- **Top Markets Analysis 🌍**: Identify key markets contributing significantly to sales, understanding regional performance.
- **Top Products Analysis 🏭**: Determine most popular and profitable products, gaining insights into product demand and market trends.
- **Top Customers Analysis 🧑‍💼**: Analyze customer base to understand buying patterns and contributions to sales, crucial for CRM and marketing strategies.

[Back to Table of Contents](#table-of-contents)
  
<a id="top-performers-sales-report"></a>
# 📈 Top Performers Sales Report

## Data Source 🌐
The Top Performers Sales Report utilizes data from a collection of tables within a sales database:
- **net_sales**: Contains detailed net sales transactions, foundational for customer and regional sales analysis.
- **dim_customer**: A customer dimension table with essential customer identifiers and regional information, critical for customer-centric and regional analyses.
- **fact_sales_monthly**: Includes monthly sales data, pivotal for product performance analysis.
- **dim_product**: Contains product information, essential for product-related analysis.
- **gross_sales**: Records gross sales transactions, essential for market gross sales analysis.

## Sections and Methodology 📊

### Section 1: Top 10 Customers by Net Sales Percentage 💼
- **Data Table**: net_sales, dim_customer
- **Objective**: Calculate the total net sales for each customer in millions.
- **Methodology**: Summation of net sales figures from net_sales, linked to customer data in dim_customer.
- **Objective**: Determine the percentage share of each customer in total net sales.
- **Methodology**: Use window functions on aggregated data to calculate percentage shares.

### Section 2: Net Sales Percentage Share by Region 🌐
- **Data Table**: net_sales, dim_customer
- **Objective**: Aggregate net sales by customer within each region.
- **Methodology**: Group net sales by customer and region from net_sales and dim_customer.
- **Objective**: Calculate the percentage share of net sales for each customer by region.
- **Methodology**: Apply window functions, partitioned by region, on the aggregated regional sales data.

### Section 3: Top Products by Division Based on Quantity Sold 🏆
- **Data Table**: fact_sales_monthly, dim_product
- **Objective**: Sum the total quantity sold for each product within each division.
- **Methodology**: Group and sum sold quantities from fact_sales_monthly, linked with product information in dim_product.
- **Objective**: Identify the top-selling products within each division.
- **Methodology**: Use ranking functions on quantity sold data to highlight top products in each division.

### Section 4: Top Markets by Gross Sales in Each Region 🛍️
- **Data Table**: gross_sales, dim_customer
- **Objective**: Determine gross sales by market and region, converted to millions.
- **Methodology**: Sum gross sales from gross_sales, linked with market and regional data in dim_customer.
- **Objective**: Rank markets based on their gross sales within each region.
- **Methodology**: Apply ranking functions to aggregated gross sales data, highlighting key markets in each region.

 [Back to Table of Contents](#table-of-contents)

<a id="sales-performance-insights"></a>
# Sales Performance Insights

This section provides an overview of the Sales Performance Insights, offering a detailed analysis of key sales metrics and trends. The report is structured into several sections, each highlighting crucial aspects of sales performance.

## Key Sections and Highlights:

### 1. Product Performance
- **Overview**: Analysis of the highest grossing products.
- **Key Metrics**: Includes details on the highest gross price per item and the highest grossing product sale.

### 2. Sales Volume Analysis
- **Insights**: Examining the best-selling products and variants.
- **Volume Metrics**: Focuses on total units sold, indicating demand and popularity.

### 3. Temporal Sales Trends
- **Trends Overview**: Information on the highest sales month and year.
- **Importance**: Presents a clear picture of sales distribution over time, highlighting peak sales periods.

### 4. Market and Customer Insights
- **Market Analysis**: An in-depth look at market net sales, focusing on the top and lowest performing markets.
- **Customer Analysis**: Identifying top and lower-tier customers based on net sales, providing insights into customer buying behavior.

### 5. Regional Sales Overview
- **Regional Focus**: Specialized section on the best-performing region based on net sales percentages.
- **Customer Dominance**: Examines the influence and dominance of key customers in specific regions.


