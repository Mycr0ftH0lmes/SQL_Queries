-- Query 1: Retrieve all columns from the Pizza_Sales table
SELECT *
FROM Pizza_Sales;

-- Query 2: Calculate the total revenue from Pizza_Sales
SELECT 
	ROUND(SUM(total_price), 2) AS Total_Revenue
FROM Pizza_Sales;

-- Query 3: Calculate the average order value from Pizza_Sales
SELECT 
	ROUND((SUM(total_price) / COUNT(DISTINCT order_id)), 2) 
		AS Avg_Order_Value 
FROM Pizza_Sales;

-- Query 4: Calculate the total quantity of pizzas sold
SELECT 
	SUM(quantity) AS Total_Pizza_Sold 
FROM Pizza_Sales;

-- Query 5: Count the total number of orders
SELECT 
	COUNT(DISTINCT order_id) AS Total_Orders 
FROM Pizza_Sales;

-- Query 6: Calculate the average number of pizzas per order
SELECT 
	ROUND(
		ROUND(SUM(quantity), 2) / 
		ROUND(COUNT(DISTINCT order_id), 2)
			, 2)
	AS Avg_Pizzas_Per_Order
FROM Pizza_Sales;

-- Query 7: Group orders by day and count the total orders for each day
SELECT 
	DATENAME(DW, order_date) AS Order_Day, 
	COUNT(DISTINCT order_id) AS Total_Orders 
FROM Pizza_Sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC;

-- Query 8: Group orders by month and count the total orders for each month
SELECT 
	DATENAME(MONTH, order_date) AS Months, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM Pizza_Sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;

-- Query 9: Group pizzas by category and calculate total revenue and percentage of total revenue
SELECT 
	pizza_category, 
	ROUND(SUM(total_price), 2) AS Total_Revenue,
	ROUND
		(SUM(total_price) * 100 / 
			(SELECT SUM(total_price) 
				FROM pizza_sales), 2)
	AS PCT
FROM Pizza_Sales
GROUP BY pizza_category
ORDER BY Total_Revenue DESC;

-- Query 10: Group pizzas by category and sum the quantity sold for the first month
SELECT 
	pizza_category, 
	SUM(quantity) AS Total_Quantity_Sold
FROM Pizza_Sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Query 11: Group pizzas by size and calculate total revenue and percentage of total revenue
SELECT 
	pizza_size, 
	ROUND(SUM(total_price), 2) AS Total_Revenue,
	ROUND
		(SUM(total_price) * 100 / 
			(SELECT SUM(total_price) 
				FROM pizza_sales), 2)
		AS PCT
FROM Pizza_Sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Query 12: Retrieve the top 5 pizzas by total revenue
SELECT 
	TOP 5
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- Query 13: Retrieve the bottom 5 pizzas by total revenue
SELECT 
	Top 5 
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- Query 14: Retrieve the top 5 pizzas by total quantity sold
SELECT 
	Top 5 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- Query 15: Retrieve the top 5 pizzas by total number of orders
SELECT 
	Top 5 
	pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- Query 16: Retrieve the bottom 5 pizzas by total quantity sold
SELECT 
	TOP 5 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;

-- Query 17: Retrieve the bottom 5 pizzas by total number of orders
SELECT 
	Top 5 
	pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;

-- Query 18: Retrieve the bottom 5 pizzas in the 'Supreme' category by total number of orders
SELECT 
	Top 5 
	pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM Pizza_Sales
WHERE pizza_category = 'Supreme'
GROUP BY pizza_name
ORDER BY Total_Orders ASC;