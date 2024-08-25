/* REQUEST 2
What is the percentage of unique product increase in 2021 vs. 2020? 
The final output contains these fields, 
	unique_products_2020 
    unique_products_2021 
    percentage_chg
*/

WITH product_count AS (
	SELECT 
		(SELECT COUNT(DISTINCT product_code) FROM fact_sales_monthly WHERE fiscal_year = 2020) AS unique_products_2020,
		(SELECT COUNT(DISTINCT product_code) FROM fact_sales_monthly WHERE fiscal_year = 2021) AS unique_products_2021
	FROM  fact_sales_monthly
	LIMIT 1
)
SELECT 
	unique_products_2020,
    unique_products_2021,
    ROUND((unique_products_2021 - unique_products_2020)*100/unique_products_2020,2) AS percentage_chg
FROM product_count;