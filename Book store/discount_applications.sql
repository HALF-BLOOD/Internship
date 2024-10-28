CREATE TABLE discount_applications (
    ID INT PRIMARY KEY,
    discount_id INT,
    order_item_id INT,
    discount_applied DECIMAL(5, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (discount_id) REFERENCES discounts(ID),
    FOREIGN KEY (order_item_id) REFERENCES order_items(ID)
);

-- Dummy Data
INSERT INTO discount_applications (ID, discount_id, order_item_id, discount_applied) VALUES
(1, 1, 1, 5.00);
