CREATE TABLE orders (
    ID INT PRIMARY KEY,
    customer_id INT,
    order_status ENUM('Pending', 'Completed', 'Canceled'),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(ID)
);

-- Dummy Data
INSERT INTO orders (ID, customer_id, order_status, total_amount) VALUES
(1, 1, 'Pending', 35.00),
(2, 2, 'Completed', 50.00);

INSERT INTO orders (ID, customer_id, order_status, order_date, total_amount, created_at, updated_at)
VALUES (6, 1, 'Pending', CURRENT_DATE, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM order_items WHERE ID = 4;

