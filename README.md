# Finance-Sales-Analytics README

## Overview
This README document serves as an overview and guide for understanding the various sales reports for various Fiscal Years. It encapsulates details from the Product Sales Report to the Top Performers Sales Report, offering insights into gross and net sales, product performance, and market standings. It also captures an in-depth look at product performance, sales trends, and customer insights, leveraging data from various internal tables and databases.

## Table of Contents
1. [Product Sales Report](#product-sales-report)
2. [Gross Sales Report](#gross-sales-report)
3. [Net Sales Report](#net-sales-report)
4. [Top Performers Sales Report](#top-performers-sales-report)
5. [Market Standings and Trends](#market-standings-and-trends)

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

# Finance-Sales-Analytics README

## Table of Contents
1. [Product Sales Report](#product-sales-report)
   ...

## Product Sales Report 📈

### Report Fields 📊
[...content of the Product Sales Report...]

### Data Sources 🗂️
[...content of the Product Sales Report's Data Sources...]

### Methodology ⚙️
[...content of the Product Sales Report's Methodology...]

...

