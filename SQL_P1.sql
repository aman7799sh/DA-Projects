

CREATE TABLE retail_sale(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(25),
		age INT,
		category VARCHAR(25),
		quantiy INT,
		price_per_unit FLO
		cogs
		total_sale


)
SELECT * FROM retail_sale;


SELECT COUNT (*) FROM retail_sale;

-- data cleaning --
SELECT * FROM retail_sale
WHERE transactions_id IS NULL
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
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	Or
	total_sale IS NULL;

DELETE FROM retail_sale
WHERE transactions_id IS NULL
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
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	Or
	total_sale IS NULL;


-- data exploration --
-- how many sales we have 

SELECT COUNT(*) as total_sale FROM retail_sale;


SELECT COUNT(DISTINCT customer_id)as total_sale FROM retail_sale;

SELECT DISTINCT category FROM retail_sale;

--data analysis and bussines key problem

--Q.1 write a quary to retrive all columns for sales made on '2022-11-5'.


SELECT *
FROM retail_sale
WHERE sale_date ='2022-11-5';

--Q.2 write a sql quary to retrive transaction where category is 'Clothing' and the quantiy sold is more then or equal to'4'
--in the month of nov-'2022'.



SELECT * 
FROM retail_sale
	WHERE category ='Clothing'
	AND 
	to_char(sale_date ,'yyyy-mm') = '2022-11'
	AND
	quantiy >= 4;

--Q.3 write a sQl quary to calculate the total sale (total_sale) for each category.

SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sale
GROUP BY 1


--Q.4 write a sql quary to find the average age of customerwho purchased from 'Beauty' category .

SELECT 
	 ROUND(AVG (age),2) as avg_age
FROM retail_sale
WHERE category = 'Beauty'


--Q.5 write a sql quary to find all transactions where total_sale is grater then 1000 .

SELECT * FROM retail_sale
WHERE total_sale >1000


--Q.6 write a sql quary to find the total number of transaction (transactions_id) made by each gender .

SELECT
	category,
	gender,
COUNT(*) as total_transactions
FROM retail_sale
GROUP BY
	category,
	gender
ORDER BY 1


--Q.7 write a sql quary to calculate the average sale for each month. find out most selling mounth of each year.

SELECT * FROM
(	
	SELECT 
		EXTRACT (YEAR FROM sale_date)as year,
		EXTRACT (MONTH FROM sale_date)as month,
		AVG(total_sale)as avg_sale,
		RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sale
	GROUP BY 1, 2 

) as t1

WHERE rank =1

--Q.8 write a sql quary to find top 5 customers based on highest total sale.

SELECT 
	customer_id,
	SUM (total_sale) as total_sales
FROM retail_sale
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 5


--Q.9 write a sql quary to find the number of unique customers who purchased item from each category.

SELECT 
	category,
	COUNT(DISTINCT customer_id) as count_unique_customer
FROM retail_sale
GROUP BY category


--Q.10 write a sql quary to create each shift and number of orders (Explain Morning <=12 After between 12 & 17,evening>17).
	

SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sale
GROUP BY shift
ORDER BY number_of_orders DESC;



--- END ---

















