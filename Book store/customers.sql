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

DROP view Customer_Order_Discount_HIstory;
CREATE VIEW Customer_Order_Discount_History AS
SELECT 
    c.ID AS customer_id,
    c.customer_name,
    c.phone,
    o.ID AS order_id,
    o.total_amount AS order_total_amount,
    p.payment_status,
    oi.ID AS order_item_id,
    oi.price_at_sale,
    oi.quantity,
    oi.discount_applied AS order_item_discount,
    d.discount_type
FROM 
    customers c
JOIN 
    orders o ON c.ID = o.customer_id
LEFT JOIN 
    payments p ON o.ID = p.order_id
JOIN 
    order_items oi ON o.ID = oi.order_id
LEFT JOIN 
    discount_applications da ON oi.ID = da.order_item_id
LEFT JOIN 
    discounts d ON da.discount_id = d.ID
ORDER BY 
    c.ID, o.order_date;


select * from Customer_Order_Discount_History;
