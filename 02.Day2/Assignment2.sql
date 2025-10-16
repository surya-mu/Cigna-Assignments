
-- 1) Creating tables

CREATE TABLE products (
  product_id   NUMBER  PRIMARY KEY,
  product_name VARCHAR2(100) NOT NULL,
  category     VARCHAR2(50)  NOT NULL,
  price        NUMBER(10,2)  NOT NULL CHECK (price > 0),
  stock        NUMBER        DEFAULT 0 NOT NULL CHECK (stock >= 0)
);

CREATE TABLE customers (
  customer_id  NUMBER  PRIMARY KEY,
  first_name   VARCHAR2(50) NOT NULL,
  last_name    VARCHAR2(50) NOT NULL,
  email        VARCHAR2(100) NOT NULL UNIQUE,
  phone        VARCHAR2(20)
);

CREATE TABLE orders (
  order_id     NUMBER PRIMARY KEY,
  customer_id  NUMBER NOT NULL,
  order_date   DATE DEFAULT SYSDATE NOT NULL,
  total_amount NUMBER(12,2) DEFAULT 0 NOT NULL CHECK (total_amount >= 0),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orderdetails (
  orderdetail_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_id       NUMBER NOT NULL,
  product_id     NUMBER NOT NULL,
  quantity       NUMBER NOT NULL CHECK (quantity > 0),
  CONSTRAINT fk_od_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_od_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2) Insert sample data 2 records each

-- Products
INSERT INTO products (product_name, category, price, stock) VALUES ('Thinkpad T14', 'Laptop', 899.99, 25);
INSERT INTO products (product_name, category, price, stock) VALUES ('Boat X1', 'Headphones', 79.50, 15);

-- Customers
INSERT INTO customers (first_name, last_name, email, phone) VALUES ('Surya', 'Rao', 'Surya.rao@example.com', '9876543210');
INSERT INTO customers (first_name, last_name, email, phone) VALUES ('Pranav', 'Shah', 'Pranav.shah@example.com', NULL);


-- Order 1 for Surya (customer_id = 1)
INSERT INTO orders (customer_id, order_date, total_amount) VALUES (1, DATE '2025-10-10', 79.50);
-- Order 2 for Pranav (customer_id = 2)
INSERT INTO orders (customer_id, order_date, total_amount) VALUES (2, DATE '2025-10-11', 899.99);



INSERT INTO orderdetails (order_id, product_id, quantity) VALUES (1, 2, 1); 
INSERT INTO orderdetails (order_id, product_id, quantity) VALUES (2, 1, 1);



-- 2) Queries

-- A) Retrieve products with low stock (e.g., less than 20 units)
SELECT product_id, product_name, category, price, stock
FROM products
WHERE stock < 20
ORDER BY stock;

-- B) Calculate total amount spent by each customer
SELECT
  c.customer_id,
  c.first_name AS customer_name,
  NVL(SUM(od.quantity * p.price), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN orderdetails od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- C) List orders with details and computed line totals
SELECT o.order_id, o.order_date, c.first_name AS customer_name,
       p.product_name, od.quantity, p.price, (od.quantity * p.price) AS total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN orderdetails od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;

-- 5. Update product stock after an order is placed

UPDATE products p
SET stock = stock - (
  SELECT NVL(SUM(od.quantity),0)
  FROM orderdetails od
  WHERE od.product_id = p.product_id
    AND od.order_id = 1
)
