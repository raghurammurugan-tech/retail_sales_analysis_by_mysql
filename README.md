# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales_analsis`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales_analsis`.
- **Table Creation**: A table named `sales_t1` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_sales_analsis;

DROP TABLE IF EXISTS sales_t1;
CREATE TABLE sales_t1
(
    transactions_id	int PRIMARY KEY,
    sale_date date,	
    sale_time time,
    customer_id	int,
    gender varchar(15),	
    age	int,
    category varchar(20),	
    quantity int,
    price_per_unit float,	
    cogs float,	
    total_sale float
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM sales_t1;
SELECT COUNT(DISTINCT customer_id) FROM sales_t1;
SELECT DISTINCT category FROM sales_t1;

SELECT *
FROM sales_t1
WHERE
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR 
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL 
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR 
     price_per_unit IS NULL
     OR
     cogs IS NULL 
     OR
     total_sale IS NULL;
     
DELETE FROM sales_t1
WHERE
    transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR 
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL 
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR 
     price_per_unit IS NULL
     OR
     cogs IS NULL 
     OR
     total_sale IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM sales_t1
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022**:
```sql
SELECT 
	  sale_date,
      category,
      quantity
FROM  sales_t1
WHERE
      sale_date LIKE '2022-11%' 
      AND category = 'Clothing'
      AND quantity >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	  category,
      sum(total_sale) net_sale
From sales_t1
GROUP BY 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
      category,
      avg(age)
FROM sales_t1
WHERE category = 'Beauty'
GROUP BY 1;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM sales_t1
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
      gender,
      Category,
      COUNT(transactions_id)
FROM sales_t1
GROUP BY 1,2
ORDER BY gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT *
FROM 
(SELECT 
      year(sale_date) 'YEAR',
      month(sale_date) 'MONTH',
      ROUND(AVG(total_sale),2) AVG_SALE,
      RANK() OVER(PARTITION BY year(sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC) 'RANK'
FROM sales_t1
GROUP BY 1,2) as t1
WHERE t1.RANK = 1; 
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT
      customer_id,
      sum(total_sale) total_sales
FROM sales_t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
	  category,
      COUNT(DISTINCT customer_id)
FROM sales_t1
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH Hourly_sales AS
(
	SELECT *,
	CASE 
		WHEN HOUR(sale_time) <12 THEN 'Morning'
		WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END AS shift
	FROM sales_t1
)
SELECT 
      shift,
      COUNT(*) total_orders
FROM Hourly_sales
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Raghu Ram Murugan

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **LinkedIn**: https://www.linkedin.com/in/mrr9/ 
