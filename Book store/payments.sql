CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    order_id INT,
    payment_status ENUM('Paid', 'Pending', 'Delayed'),
    due_date DATE,
    amount_paid DECIMAL(10, 2),
    amount_due DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(ID),
    FOREIGN KEY (order_id) REFERENCES orders(ID)
);

-- Dummy Data
INSERT INTO payments (payment_id, customer_id, order_id, payment_status, due_date, amount_paid, amount_due) VALUES
(1, 1, 1, 'Pending', '2023-07-01', 0.00, 35.00),
(2, 2, 2, 'Paid', '2023-07-01', 50.00, 0.00);
