CREATE DATABASE retail_sales_management_systems

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(10,2)
);

--------------------------------------------------------------------------------------------
SELECT * FROM retail_sales_management_systems.retail_sales;

USE retail_sales_management_systems
--------------------------------------------------------------------------------------------
#	CREATE A DUPLICATE OF THE TABLE IN CASE I DELETE ROWS OR ANYTHING BY MISTAKE
CREATE TABLE retail_sales_copy
LIKE retail_sales

INSERT retail_sales_copy
SELECT *
FROM retail_sales
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
#	Checking for missing values/NULLs and DELETING rows that are empty
--------------------------------------------------------------------------------------------
SELECT *
FROM retail_sales_copy
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
    OR
    total_sale IS NULL

SET SQL_SAFE_UPDATES = 0; # Removing the safe mode

DELETE FROM retail_sales_copy
WHERE transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL 
    OR customer_id IS NULL
    OR gender IS NULL 
    OR age IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL 
    OR cogs IS NULL
    OR total_sale IS NULL;
SET SQL_SAFE_UPDATES = 1; # Turning on safe mode

--------------------------------------------------------------------------------------------
#	 How many of each category item was bought | How much sales from each category
--------------------------------------------------------------------------------------------
SELECT category, SUM(quantity) AS Number_of_items_bought
FROM retail_sales_copy
GROUP BY category

SELECT category, SUM(total_sale) AS Total_sales
FROM retail_sales_copy
GROUP BY category
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	HIGHEST SALE VS LOWEST SALE
-------------------------------------------------------------------------------------------
SELECT category, total_sale
FROM retail_sales_copy
WHERE total_sale = (SELECT MAX(total_sale) FROM retail_sales_copy)
ORDER BY total_sale DESC

SELECT category, total_sale
FROM retail_sales_copy
WHERE total_sale = (SELECT MIN(total_sale) FROM retail_sales_copy)
ORDER BY total_sale 
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	Number of females and males | Number of females and males in each category
-------------------------------------------------------------------------------------------
SELECT gender, count(gender) AS number_of_people
FROM retail_sales_copy
GROUP BY gender

SELECT category, gender, count(gender) AS number_of_people
FROM retail_sales_copy
GROUP BY category, gender
ORDER BY category, gender

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	Transactions in each month
-------------------------------------------------------------------------------------------
/*
SELECT 'January 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-01-01' AND '2022-01-31';

SELECT 'February 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-02-01' AND '2022-02-28';

SELECT 'March 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-03-01' AND '2022-03-31';

SELECT 'April 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-04-01' AND '2022-04-30';

SELECT 'May 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-05-01' AND '2022-05-31';

SELECT 'June 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-06-01' AND '2022-06-30';

SELECT 'July 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-07-01' AND '2022-07-31';

SELECT 'August 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-08-01' AND '2022-08-31';

SELECT 'September 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-09-01' AND '2022-09-30';

SELECT 'October 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-10-01' AND '2022-10-31';

SELECT 'November 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-11-01' AND '2022-11-30';

SELECT 'December 2022' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-12-01' AND '2022-12-31';

SELECT 'January 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-01-01' AND '2023-01-31';

SELECT 'February 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-02-01' AND '2023-02-28';

SELECT 'March 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-03-01' AND '2023-03-31';

SELECT 'April 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-04-01' AND '2023-04-30';

SELECT 'May 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-05-01' AND '2023-05-31';

SELECT 'June 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-06-01' AND '2023-06-30';

SELECT 'July 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-07-01' AND '2023-07-31';

SELECT 'August 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-08-01' AND '2023-08-31';

SELECT 'September 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-09-01' AND '2023-09-30';

SELECT 'October 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-10-01' AND '2023-10-31';

SELECT 'November 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-11-01' AND '2023-11-30';

SELECT 'December 2023' AS month_name, COUNT(*) AS total_sales
FROM retail_sales_copy
WHERE sale_date BETWEEN '2023-12-01' AND '2023-12-31';
*/


SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month_id,
       DATE_FORMAT(sale_date, '%M %Y') AS month_name,
       COUNT(*) AS total_sales, SUM(total_sale) AS Revenue
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-01-01' AND '2023-12-31'
GROUP BY month_id, month_name
ORDER BY month_id;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	Transactions in each month per gender | Which month had the highest/lowest revenue
-------------------------------------------------------------------------------------------
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month_id,
       DATE_FORMAT(sale_date, '%M %Y') AS month_name,
       gender,
       COUNT(*) AS total_transactions, SUM(total_sale) AS Revenue
FROM retail_sales_copy
WHERE sale_date BETWEEN '2022-01-01' AND '2023-12-31'
GROUP BY month_id, month_name, gender
ORDER BY month_id, gender;

SELECT *
FROM (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month_id,
           DATE_FORMAT(sale_date, '%M %Y') AS month_name,
           gender,
           COUNT(*) AS total_transactions,
           SUM(total_sale) AS revenue
    FROM retail_sales_copy
    WHERE sale_date BETWEEN '2022-01-01' AND '2023-12-31'
    GROUP BY month_id, month_name, gender
) AS monthly_gender_sales
ORDER BY revenue DESC
LIMIT 1;

SELECT *
FROM (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month_id,
           DATE_FORMAT(sale_date, '%M %Y') AS month_name,
           gender,
           COUNT(*) AS total_sales,
           SUM(total_sale) AS revenue
    FROM retail_sales_copy
    WHERE sale_date BETWEEN '2022-01-01' AND '2023-12-31'
    GROUP BY month_id, month_name, gender
) AS monthly_gender_sales
ORDER BY revenue
LIMIT 1;
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	AVERAGE AGE | AGE BRACKET
-------------------------------------------------------------------------------------------
SELECT ROUND(AVG(age),2)
FROM retail_sales_copy

SELECT 
  CASE 
    WHEN age < 25 THEN 'Youth'
    WHEN age BETWEEN 25 AND 44 THEN 'Young Adult'
    WHEN age BETWEEN 45 AND 64 THEN 'Adult'
    ELSE 'Senior'
  END AS number_of_people,
  COUNT(*) AS group_count
FROM retail_sales_copy
GROUP BY number_of_people;

SELECT 
  IF(age < 25, 'Youth',
     IF(age <= 44, 'Young Adult',
        IF(age <= 64, 'Adult', 'Senior')
     )
  ) AS age_group,
  COUNT(*) AS number_of_people
FROM retail_sales_copy
GROUP BY age_group
ORDER BY number_of_people DESC;
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	AVERAGE SALES | BY GENDER | BY CATEGORY | BY YEAR |  BY AGE
-------------------------------------------------------------------------------------------
SELECT ROUND(AVG(total_sale),2)
FROM retail_sales_copy

SELECT gender, ROUND(AVG(total_sale),2) AS Average_sale
FROM retail_sales_copy
GROUP BY gender

SELECT category, ROUND(AVG(total_sale),2) AS Average_sale
FROM retail_sales_copy
GROUP BY category

SELECT DATE_FORMAT(sale_date, '%Y') AS year_id,
       ROUND(AVG(total_sale),2) AS avg_sales
FROM retail_sales_copy
GROUP BY year_id

SELECT 
  CASE 
    WHEN age < 25 THEN 'Youth'
    WHEN age BETWEEN 25 AND 44 THEN 'Young Adult'
    WHEN age BETWEEN 45 AND 64 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group,
  ROUND(AVG(total_sale),2) AS avg_sales
FROM retail_sales_copy
GROUP BY age_group
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
#	SALES MADE BY TIME OF THE DAY | SALES MADE BY MALE/FEMALE BY TIME OF THE DAY 
-------------------------------------------------------------------------------------------
SELECT
  CASE
    WHEN HOUR(sale_time) BETWEEN 0 AND 5 THEN 'Night'
    WHEN HOUR(sale_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_slot,
  COUNT(*) AS total_transactions,
  SUM(total_sale) AS total_revenue,
  AVG(total_sale) AS avg_sale
FROM retail_sales_copy
GROUP BY time_slot
ORDER BY total_revenue DESC;

SELECT gender, category,
  CASE
    WHEN HOUR(sale_time) BETWEEN 0 AND 5 THEN 'Night'
    WHEN HOUR(sale_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_slot,
  COUNT(*) AS total_transactions, SUM(total_sale) AS revenue
FROM retail_sales_copy
GROUP BY gender, category, time_slot
ORDER BY revenue DESC;





SELECT 
    *
FROM
    retail_sales_copy
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------













--------------------------------------------------------------------------------------------

#	Fixing typos in the header, fixing data types and making them suitable for data cleaning and exploration
ALTER TABLE retail_sales_copy
CHANGE quantiy quantity INT;

DESCRIBE retail_sales_copy

ALTER TABLE retail_sales_copy
MODIFY COLUMN sale_date DATE

ALTER TABLE retail_sales_copy
MODIFY COLUMN sale_time TIME

--------------------------------------------------------------------------------------------
#	Changing the data of price_per_unit from txt --> double
SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_copy	
SET price_per_unit = REPLACE(price_per_unit, 'R', ''); /*	Removing the R */

UPDATE retail_sales_copy
SET price_per_unit = REPLACE(REPLACE(price_per_unit, 'R', ''), ' ', '')
WHERE price_per_unit LIKE 'R%';							/*	Removing the R and replacing it with nothing */

UPDATE retail_sales_copy
SET price_per_unit = REPLACE(price_per_unit, ',', '.')		/*	Replacing the , with . */
WHERE price_per_unit LIKE '%,%';

SET SQL_SAFE_UPDATES = 1; 

ALTER TABLE retail_sales_copy
MODIFY COLUMN price_per_unit DOUBLE

SELECT price_per_unit
FROM retail_sales_copy
WHERE price_per_unit REGEXP '[^0-9.]' OR price_per_unit = '';
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_copy	
SET cogs = REPLACE(price_per_unit, 'R', '');

UPDATE retail_sales_copy
SET cogs = REPLACE(REPLACE(price_per_unit, 'R', ''), ' ', '')
WHERE cogs LIKE 'R%';

UPDATE retail_sales_copy
SET cogs = REPLACE(price_per_unit, ',', '.')
WHERE cogs LIKE '%,%';



SET SQL_SAFE_UPDATES = 1; 

ALTER TABLE retail_sales_copy
MODIFY COLUMN cogs DOUBLE
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_copy	
SET total_sale = REPLACE(price_per_unit, 'R', '');

UPDATE retail_sales_copy
SET total_sale = REPLACE(REPLACE(price_per_unit, 'R', ''), ' ', '')
WHERE total_sale LIKE 'R%';

UPDATE retail_sales_copy
SET total_sale = REPLACE(price_per_unit, ',', '.')
WHERE total_sale LIKE '%,%';

SET SQL_SAFE_UPDATES = 1; 

ALTER TABLE retail_sales_copy
MODIFY COLUMN total_sale DOUBLE


-------------------------------------------------------------------------------------------
#	Recalculating my total_sale, accidentally turned both cogs and total_sale into price_per_unit
-------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
UPDATE retail_sales_copy
SET total_sale = price_per_unit * quantity;
SET SQL_SAFE_UPDATES = 1;

UPDATE retail_sales_copy AS copy
JOIN retail_sales AS original ON copy.transactions_id = original.transactions_id
SET copy.cogs = original.cogs;

SELECT original.cogs
FROM retail_sales_copy AS copy
JOIN retail_sales AS original
ON copy.transactions_id = original.transactions_id
WHERE original.cogs NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

UPDATE retail_sales
SET cogs = TRIM(REPLACE(REPLACE(REPLACE(cogs, 'R', ''), ',', '.'), ' ', ''))
WHERE cogs LIKE 'R%' OR cogs LIKE '%,%';

SELECT cogs
FROM retail_sales
WHERE cogs NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

UPDATE retail_sales_copy AS copy 
JOIN retail_sales AS original
ON copy.transactions_id = original.transactions_id
SET copy.cogs = original.cogs;

SHOW COLUMNS FROM retail_sales_copy LIKE 'cogs';