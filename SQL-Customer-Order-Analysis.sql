CREATE DATABASE BLINKET_db;
USE BLINKET_db;
#Creating Table 1
CREATE TABLE CUSTOMERS(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50),
gender VARCHAR (10)
);
#Creating Table 2
CREATE TABLE PRODUCTS(
product_id INT PRIMARY KEY,
product_name VARCHAR (50),
category VARCHAR (50),
price DECIMAL (10,2)
);
#Creating Table 3
CREATE TABLE ORDERS(
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE,
quantity INT 
);
#ALTERING THE TABLE 
#TABLE 1 
ALTER TABLE ORDERS
ADD CONSTRAINT fk_customers
FOREIGN KEY (customer_id)
REFERENCES CUSTOMERS(customer_id);
# TABLE 2 
ALTER TABLE ORDERS 
ADD CONSTRAINT fk_products
FOREIGN KEY (product_id)
REFERENCES PRODUCTS(product_id);
SHOW TABLES;
SELECT*FROM ORDERS;
# INSERTING VALUES IN THE TABLE
# TABLE 1
INSERT INTO CUSTOMERS VALUES
(1, 'Amit Sharma', 'Delhi', 'Male'),
(2, 'Priya Verma', 'Mumbai', 'Female'),
(3, 'Rahul Singh', 'Bangalore', 'Male'),
(4, 'Sneha Kapoor', 'Delhi', 'Female'),
(5, 'Arjun Mehta', 'Pune', 'Male'),
(6, 'Neha Gupta', 'Mumbai', 'Female'),
(7, 'Vikas Yadav', 'Lucknow', 'Male'),
(8, 'Anjali Desai', 'Ahmedabad', 'Female'),
(9, 'Karan Malhotra', 'Chandigarh', 'Male'),
(10, 'Pooja Shah', 'Surat', 'Female'),
(11, 'Unknown User', NULL, NULL);
# TABLE 2
INSERT INTO PRODUCTS VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Electronics', 2000),
(104, 'Shoes', 'Fashion', 3000),
(105, 'T-Shirt', 'Fashion', 800),
(106, 'Watch', 'Accessories', 5000),
(107, 'Backpack', 'Accessories', 1500),
(108, 'Keyboard', 'Electronics', 1200),
(109, 'Gaming Laptop', 'Electronics', 120000),
(110, 'Pen', 'Stationery', 20);
# TABLE 3 
INSERT INTO ORDERS VALUES
(1001, 1, 101, '2023-01-10', 1),
(1002, 2, 102, '2023-01-12', 2),
(1003, 3, 103, '2023-01-15', 1),
(1004, 1, 104, '2023-02-01', 2),
(1005, 1, 105, '2023-02-05', 3),
(1006, 2, 101, '2023-02-10', 1),
(1007, 3, 101, '2023-02-12', 2),
(1008, 4, 110, '2023-02-15', 50),
(1009, 5, 106, '2023-03-01', 1),
(1010, 6, 107, '2023-03-01', 2),
(1011, 7, 108, '2023-03-15', 3),
(1012, 8, 102, '2023-03-20', 1),
(1013, 2, 103, '2023-04-01', 2),
(1014, 2, 104, '2023-04-05', 1),
(1015, 3, 105, '2023-04-10', 4),
(1016, 6, 110, '2023-04-15', 100),
(1017, 7, 109, '2023-05-01', 1),
(1018, 8, 101, '2023-05-05', 2);
# QUERY PRACTICE
-- 1 Show all customers
SELECT*FROM CUSTOMERS;

-- 2 Show all products with price > 5000
SELECT*FROM PRODUCTS;
SELECT price
FROM PRODUCTS
WHERE price>5000;

-- 3 Find all orders placed in March
SELECT *
FROM ORDERS
WHERE MONTH(order_date)=3;

-- 4 Sort products by price (high to low)
SELECT* 
FROM PRODUCTS 
ORDER BY price DESC;

-- 5 Count total number of customers
SELECT*FROM CUSTOMERS;
SELECT  COUNT(customer_id) AS total_customers
FROM CUSTOMERS;

#QUERY PRACTICE LEVEL 2 
-- 6 Show all orders with customer name
SELECT O.order_id, c.name, o.order_date, o.quantity
FROM ORDERS o
JOIN CUSTOMERS c
ON o.customer_id = c.customer_id;

-- 7 Show product name with each order
SELECT o.order_id, p.product_name
FROM ORDERS o
JOIN PRODUCTS p ON o.product_id=p.product_id;

-- 8 Show customer + product + quantity (3-table JOIN)
SELECT o.order_id, c.name, p.product_name, o.order_date, o.quantity
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id=c.customer_id
JOIN PRODUCTS p ON o.product_id=p.product_id;

-- 9 Find all orders placed by 'Amit Sharma'
SELECT o.*, p.product_name
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id=c.customer_id
JOIN PRODUCTS p ON o.product_id=p.product_id
WHERE c.name= 'Amit Sharma';

-- 10 Find customers who bought ‘Laptop’
SELECT DISTINCT c.name, p.product_name         # USED DISTINCT BECAUSE Same customer may buy multiple times
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id=c.customer_id
JOIN PRODUCTS p ON o.product_id=p.product_id
WHERE p.product_name= 'Laptop';

#QUERY PRACTICE LEVEL 3

-- 11 Total quantity sold per product
SELECT p.product_name, SUM(o.quantity) AS total_quantity
FROM ORDERS o
JOIN PRODUCTS p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- 12 Total orders per customer
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
GROUP BY c.name;

-- 13 Find total sales per category
SELECT p.category, SUM(o.quantity * p.price) AS total_sales
FROM ORDERS o
JOIN PRODUCTS p ON o.product_id = p.product_id
GROUP BY p.category;

-- 14 Which city has most customers
SELECT city, COUNT(*) AS total_customers    # BEST SUITED PRODUCTS IN THE SHOP
FROM CUSTOMERS
GROUP BY city
ORDER BY total_customers DESC;

-- 15 Average quantity per order
SELECT p.product_name, AVG(o.quantity) AS Average_Quantity   #TO FIND THE BEST PLACE TO OPEN A SHOP
FROM ORDERS o
JOIN PRODUCTS p ON o.product_id= p.product_id
GROUP BY p.product_name;

-- 16 Top 3 most sold products
SELECT p.product_name, SUM(o.quantity) AS product_sold
FROM ORDERS o
JOIN PRODUCTS p  ON p.product_id= o.product_id
GROUP BY p.product_name
ORDER BY product_sold  DESC
LIMIT  3;

-- 17 Customer who ordered highest quantity
SELECT c.name, SUM(o.quantity) AS total_quantity
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_quantity DESC
LIMIT 1;

-- 18 Most active customer (max orders)
SELECT c .name, COUNT(o.order_id) total_orders
FROM ORDERS o 
JOIN CUSTOMERS c ON o.customer_id=c.customer_id
GROUP BY c.name 
ORDER BY  total_orders DESC
LIMIT 1;

-- 19 Total sales per city
SELECT p.product_name, SUM(o.quantity * p.price) AS Total_sales
FROM ORDERS o
JOIN PRODUCTS p ON o.product_id= p.product_id
GROUP BY  p.product_name
ORDER BY Total_sales DESC
LIMIT 1;

-- 20 Which product generated highest sales
SELECT p.product_name, SUM(o.quantity * p.price) AS total_sales
FROM ORDERS o
JOIN PRODUCTS p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 1;

-- 21 Customers who placed more orders than average
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM ORDERS o
JOIN CUSTOMERS c  ON o.customer_id=c.customer_id
GROUP BY c.name 
HAVING COUNT(o.order_id) > (
      SELECT AVG(order_count) 
      FROM (
           SELECT COUNT(order_id) AS order_count
           FROM ORDERS 
           GROUP BY customer_id
	  ) AS temp
);

-- 22 Products with price higher than average  
SELECT product_name, price
FROM PRODUCTS
WHERE price > (
    SELECT AVG(price)
    FROM PRODUCTS
);

-- 23 Find second highest priced product
SELECT product_name, price
FROM PRODUCTS
WHERE price= (
      SELECT MAX(price)
      FROM PRODUCTS
      WHERE price<(
            SELECT MAX(price)
            FROM PRODUCTS
            )
);

-- 24 Customers who never placed an order
SELECT c.name
FROM CUSTOMERS c
LEFT JOIN ORDERS o  ON o.customer_id=c.customer_id
WHERE o.order_id is null;

-- 25 Orders with quantity greater than average
SELECT *   
FROM ORDERS
WHERE quantity > (
    SELECT AVG(quantity)
    FROM ORDERS
);

-- 26 Rank customers based on total orders
SELECT c.name, COUNT( o.order_id) AS total_orders , RANK() OVER(ORDER BY COUNT( o.order_id) desc) AS customer_rank
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id=c.customer_id
GROUP BY c.name;

-- 27 Rank products based on quantity sold
SELECT p.product_name, SUM(o.quantity) AS quantity_sold , RANK() OVER(ORDER BY SUM(o.quantity) DESC) AS rank_products
FROM ORDERS o
JOIN PRODUCTS p  ON o.product_id=p.product_id
GROUP BY p.product_name;

-- 28 Show running total of orders
SELECT order_id, quantity,order_date, SUM(quantity) OVER (ORDER BY order_date) AS cumulative_orders
FROM ORDERS;

-- 29 Find first order of each customer
SELECT *
FROM (
     SELECT o.*, p.product_name,c.name, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
     FROM ORDERS o
     JOIN PRODUCTS p ON p.product_id=o.product_id
     JOIN CUSTOMERS c ON c.customer_id =o.customer_id
     )t
WHERE rn=1;

-- 30 Find latest order of each customer
SELECT *
FROM (
     SELECT o.*, p.product_name,c.name, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC ) AS rn
     FROM ORDERS o
     JOIN PRODUCTS p ON p.product_id=o.product_id
     JOIN CUSTOMERS c ON c.customer_id =o.customer_id
     )t
WHERE rn=1;

-- 31 Find repeat customers (ordered more than once)
SELECT c.name, COUNT(o.order_id)
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id=c.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id)>1;

-- 32 Find customers who bought more than 1 product
SELECT c.name, COUNT(DISTINCT o.product_id) AS total_quantity
FROM ORDERS o 
JOIN CUSTOMERS c ON c.customer_id=o.customer_id
GROUP BY c.name
HAVING COUNT(DISTINCT o.product_id)>1;

-- 33 Find most popular product in each month
SELECT month, product_name, total_quantity
FROM (
    SELECT 
        MONTH(o.order_date) AS month,
        p.product_name,
        SUM(o.quantity) AS total_quantity,
        RANK() OVER (
            PARTITION BY MONTH(o.order_date)
            ORDER BY SUM(o.quantity) DESC
        ) AS rnk
    FROM ORDERS o
    JOIN PRODUCTS p ON o.product_id = p.product_id
    GROUP BY MONTH(o.order_date), p.product_name
) t
WHERE rnk = 1;

-- 34 Find top customer in each city
SELECT Top_Customer, city,  Revenue
FROM (
      SELECT SUM(o.quantity*p.price)AS Revenue, c.name AS Top_Customer  , c.city, 
             RANK() OVER( PARTITION BY c.city ORDER BY SUM(o.quantity*p.price) DESC)
             AS rnk
		FROM ORDERS o 
        JOIN CUSTOMERS c ON o.customer_id=c.customer_id
        JOIN PRODUCTS p ON o.product_id= p.product_id
        GROUP BY c.name, c.city
)temp
WHERE rnk=1
ORDER BY Revenue desc;

-- 35 Find product contributing highest revenue
SELECT p.product_name, SUM(o.quantity*p.price) AS Revenue
FROM ORDERS o 
JOIN PRODUCTS p ON o.product_id=p.product_id
GROUP BY p.product_name
ORDER BY Revenue DESC
LIMIT 1;

-- 36 Cohort analysis (customers by first purchase month)
SELECT 
    cohort_month,
    order_month,
    COUNT(DISTINCT customer_id) AS customers
FROM (
    SELECT 
        customer_id,
        DATE_FORMAT(MIN(order_date) OVER (PARTITION BY customer_id), '%Y-%m') AS cohort_month,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month
    FROM ORDERS
) t
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;

-- 37 Monthly growth rate of orders
SELECT 
    month,
    total_orders,
    prev_month_orders,
    ROUND(
        (total_orders - prev_month_orders) * 100.0 / prev_month_orders, 
        2
    ) AS growth_rate_percent
FROM (
    SELECT 
        month,
        total_orders,
        LAG(total_orders) OVER (ORDER BY month) AS prev_month_orders
    FROM (
        SELECT 
            DATE_FORMAT(order_date, '%Y-%m') AS month,
            COUNT(*) AS total_orders
        FROM ORDERS
        GROUP BY month
    ) t1
) t2; 

-- 38 Identify customer purchase pattern
SELECT customer_id, count(order_id) AS total_orders
FROM ORDERS
GROUP BY customer_id
ORDER BY COUNT(order_id) DESC;

-- 39 Find gap between consecutive orders (per customer)
SELECT customer_id, order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
    DATEDIFF(order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) )AS order_gap
FROM ORDERS;

-- 40 Segment customers (High / Medium / Low buyers)
SELECT customer_id, name, money_spent, 
       CASE 
          WHEN money_spent>=10000 THEN 'HIGH_VALUE'
          WHEN money_spent BETWEEN 5000 AND 9999 THEN 'MEDIUM_VALUE'
          ELSE  'LOW_VALUE'
          END AS customer_segmentation
FROM (
     SELECT c.customer_id,c.name, SUM(o.quantity*p.price) AS money_spent
     FROM ORDERS o 
     JOIN PRODUCTS p ON o.product_id=p.product_id
     JOIN CUSTOMERS c ON o.customer_id=c.customer_id
     GROUP BY c.customer_id, c.name
)t
ORDER BY money_spent DESC;

