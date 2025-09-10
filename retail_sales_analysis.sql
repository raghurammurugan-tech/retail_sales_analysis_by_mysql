-- step 1 : creating table schema
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

-- STEP 2 : Importing cleaned data is done. 
-- STEP 3 : Data Cleaning

SELECT * 
FROM sales_t1
LIMIT 40;

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
     
-- STEP 4 : Data Exploration

-- Q1 :  How many unique customers are there?
SELECT 
    COUNT(DISTINCT customer_id)
FROM 
    sales_t1;
    
-- Q2 : What are the different categories involved in sales?
SELECT 
    DISTINCT category
FROM 
    sales_t1;
    
-- STEP 5 : Data Analysis and finding KPIs

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM sales_t1
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022
SELECT 
	  sale_date,
      category,
      quantity
FROM sales_t1
WHERE sale_date LIKE '2022-11%' 
AND category = 'Clothing'
AND quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	  category,
      sum(total_sale) net_sale
From sales_t1
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
      category,
      avg(age)
FROM sales_t1
WHERE category = 'Beauty'
GROUP BY 1;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM sales_t1
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
      gender,
      Category,
      COUNT(transactions_id)
FROM sales_t1
GROUP BY 1,2
ORDER BY gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
      customer_id,
      sum(total_sale) total_sales
FROM sales_t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	  category,
      COUNT(DISTINCT customer_id)
FROM sales_t1
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

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

-- THE END
