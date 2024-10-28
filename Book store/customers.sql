CREATE TABLE customers (
    ID INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    primary_address TEXT,
    billing_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dummy Data
INSERT INTO customers (ID, customer_name, email, phone, primary_address, billing_address) VALUES
(1, 'Customer A', 'customerA@example.com', '1231231234', '123 Primary St', '123 Billing St'),
(2, 'Customer B', 'customerB@example.com', '9879879876', '456 Primary Ave', '456 Billing Ave');
