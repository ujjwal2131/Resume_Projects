/* REQUEST 5
Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, 
	product_code 
    product 
    manufacturing_cost
*/

SELECT 
	DISTINCT p.product_code,
    p.product,
    ROUND(m.manufacturing_cost,2) AS manufacturing_cost
FROM dim_product p
JOIN fact_manufacturing_cost m USING(product_code)
WHERE m.manufacturing_cost IN(
								(SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost),
                                (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost)
							)
ORDER BY manufacturing_cost DESC;