
-- OBJECTIVE 1: EXPLORE THE ORDERS TABLE 
-- View the menu_items table. 
-- View the menu_items table.
SELECT * FROM menu_items;
-- Find the number of items on the menu. 
SELECT COUNT(*) FROM menu_items; 
-- we got to know that we have 32 rows
-- What are the least and most expensive items on the menu
SELECT * FROM menu_items
ORDER BY price
LIMIT 1;

SELECT * FROM menu_items
ORDER BY price DESC
limit 1;
-- How many Italian dishes are on the menu? 
SELECT COUNT(*) FROM menu_items
WHERE category="Italian";
-- How many dishes are in each category? 
SELECT category , Count(menu_item) as num_dishes
FROM menu_items
GROUP BY category;
-- What is the average dish price within each category?
SELECT category , AVG(price) as AVG_PRICE
FROM menu_items
GROUP BY category;

-- -- OBJECTIVE 2: EXPLORE THE ORDERS TABLE 

-- -- View the order_details table. 
SELECT * FROM order_details;
-- RANGE OF DATE
SELECT MIN(order_date) FROM order_details;
SELECT MAX(order_date) FROM order_details;

-- How many ORDERS were ordered within this date range? 
SELECT COUNT(DISTINCT order_id) FROM order_details;
-- How many items were ordered within this date range? 
SELECT COUNT(*) from order_details;
-- Which orders had the most number of items? 
SELECT order_id, COUNT(item_id) as num_item
FROM order_details
GROUP BY order_id
ORDER BY num_item DESC;
-- How many orders had more than 12 items? 
SELECT COUNT(*) FROM
(SELECT order_id, COUNT(item_id) as num_item
FROM order_details
GROUP BY order_id
HAVING num_item > 12)as num_orders;  

-- OBJECTIVE 3: UNDERSTANDING OUR CUSTOMERS
-- Combine the menu_items and order_details tables into a single table. 
SELECT* FROM order_details as od
LEFT JOIN menu_items as mi
ON od.item_id=mi.menu_item;
-- What were the least and most ordered items? What categories were they in?
SELECT item_name,category, COUNT(order_details_id) AS num_purchase
FROM order_details as od
LEFT JOIN menu_items as mi
ON od.item_id=mi.menu_item
GROUP BY item_name , category
order by num_purchase DESC ;
-- What were the top 5 orders that spent the most money? 
SELECT order_id, sum(price) as total_amount
FROM order_details as od
LEFT JOIN menu_items as mi
ON od.item_id=mi.menu_item
GROUP BY order_id
ORDER BY total_amount DESC
LIMIT 5;
-- View the details of the highest spend order. What insights can you gather from the results? 
SELECT category , COUNT(item_id) as num_item
FROM order_details as od
LEFT JOIN menu_items as mi
ON od.item_id=mi.menu_item
WHERE order_id = 440
GROUP BY category;
-- BONUS: View the details of the top 5 highest spend orders. What insights can you gather from the results? 
SELECT category , COUNT(item_id) as num_item
FROM order_details as od
LEFT JOIN menu_items as mi
ON od.item_id=mi.menu_item
WHERE order_id IN( 440, 2075 , 1957 , 330 ,2675)
GROUP BY category;

