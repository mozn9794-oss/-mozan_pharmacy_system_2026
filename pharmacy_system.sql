
CREATE DATABASE mozan_202510003_pharmacy_system;
)
\c mozan_202510003_pharmacy_system;
CREATE TABLE medicines (
    medicine_id SERIAL PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity_sold INT NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id) ON DELETE CASCADE
);


INSERT INTO medicines (medicine_name, category, price, stock_quantity) VALUES
('Paracetamol', 'Painkiller', 5.00, 100),
('Amoxicillin', 'Antibiotic', 12.50, 50),
('Ibuprofen', 'Painkiller', 7.00, 80),
('Vitamin C', 'Supplements', 15.00, 200),
('Aspirin', 'Painkiller', 4.50, 120);


INSERT INTO customers (customer_name, phone_number, city) VALUES
('John Smith', '0781111111', 'Kigali'),
('Alice Uwase', '0782222222', 'Butare'),
('David Mugisha', '0783333333', 'Gisenyi'),
('Marie Claire', '0784444444', 'Kigali'),
('Eric Ndayisenga', '0785555555', 'Musanze'): 
INSERT INTO sales (customer_id, medicine_id, quantity_sold, sale_date) VALUES
(1, 1, 2, '2026-10-20'),
(2, 2, 1, '2026-10-21'),
(3, 4, 3, '2026-10-22'),
(4, 3, 2, '2026-10-23'),
(5, 5, 4, '2026-10-24');

SELECT medicine_name, price FROM medicines;
SELECT * FROM medicines WHERE price > 10.00;
SELECT * FROM medicines ORDER BY price DESC;
SELECT sales.sale_id, customers.customer_name, medicines.medicine_name, sales.quantity_sold
FROM sales
INNER JOIN customers ON sales.customer_id = customers.customer_id
INNER JOIN medicines ON sales.medicine_id = medicines.medicine_id;
SELECT customers.customer_name, sales.sale_id, sales.sale_date
FROM customers
LEFT JOIN sales ON customers.customer_id = sales.customer_id;
SELECT s.sale_id, c.customer_name, m.medicine_name, m.price, s.quantity_sold, (m.price * s.quantity_sold) AS total_price
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN medicines m ON s.medicine_id = m.medicine_id;
UPDATE medicines SET price = 6.00 WHERE medicine_id = 1;
UPDATE medicines SET stock_quantity = stock_quantity + 50 WHERE category = 'Painkiller';
UPDATE customers SET city = 'Kigali' WHERE customer_id = 2;
ALTER TABLE medicines RENAME COLUMN category TO medicine_category;
ALTER TABLE medicines ALTER COLUMN price TYPE DECIMAL(12, 2);
ALTER TABLE customers ADD COLUMN email VARCHAR(100);
INSERT INTO medicines (medicine_name, medicine_category, price, stock_quantity) 
VALUES ('Cough Syrup', 'Cold', 8.50, 60);

INSERT INTO customers (customer_name, phone_number, city, email) VALUES
('Claude Habimana', '0786666666', 'Huye', 'claude@email.com'),
('Diane Mutoni', '0787777777', 'Kigali', 'diane@email.com');
INSERT INTO sales (customer_id, medicine_id, quantity_sold, sale_date) 
VALUES (6, 6, 2, '2026-10-25');