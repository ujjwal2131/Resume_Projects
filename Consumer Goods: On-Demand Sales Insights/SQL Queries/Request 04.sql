/* REQUEST 4
Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
The final output contains these fields, 
	segment 
    product_count_2020 
    product_count_2021 
    difference
*/

WITH unique_products_2020 AS (
	SELECT
		p.segment,
		COUNT(DISTINCT s.product_code) AS product_count_2020
	FROM  fact_sales_monthly s
    JOIN dim_product p USING(product_code)
    WHERE fiscal_year = 2020
    GROUP BY segment
),
unique_products_2021 AS (
	SELECT
		p.segment,
		COUNT(DISTINCT s.product_code) AS product_count_2021
	FROM  fact_sales_monthly s
    JOIN dim_product p USING(product_code)
    WHERE fiscal_year = 2021
    GROUP BY segment
)
SELECT 
	p20.segment,
    p20.product_count_2020,
    p21.product_count_2021,
    (product_count_2021 - product_count_2020) AS difference
FROM unique_products_2020 p20
JOIN unique_products_2021 p21 USING(segment)
ORDER BY difference DESC;
