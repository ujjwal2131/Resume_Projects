/* ADD ON RESEARCH 1 
Product Performance by Region:
Analyze the total gross sales and gross profit for each product segment by region (APAC, EU, NA).
The final output contains these fields,
	segment,
	region,
	total_sold_qty,
	gross_sales_mln,
	total_manufacturing_cost_mln,
	gross_profit_mln
Identify the most and least profitable regions for each product segment.    
*/

SELECT 
    dp.segment,
    dc.region,
    SUM(fsm.sold_quantity) AS total_sold_qty,
    ROUND(SUM(fsm.sold_quantity * fgp.gross_price)/1000000,2) AS gross_sales_mln,
    ROUND(SUM(fsm.sold_quantity * fmc.manufacturing_cost)/1000000,2) AS total_manufacturing_cost_mln,
    ROUND(SUM(fsm.sold_quantity * (fgp.gross_price - fmc.manufacturing_cost))/1000000,2) AS gross_profit_mln
FROM fact_sales_monthly fsm
JOIN dim_product dp ON fsm.product_code = dp.product_code
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code AND fsm.fiscal_year = fgp.fiscal_year
JOIN fact_manufacturing_cost fmc ON fsm.product_code = fmc.product_code AND fsm.fiscal_year = fmc.cost_year
GROUP BY dp.segment, dc.region
ORDER BY dp.segment, gross_profit_mln DESC;

/* NOTE:
Here we didn't considered pre inv discount as it was related to customer basis but here we had to calculate profit segment wise
*/