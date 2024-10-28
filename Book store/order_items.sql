CREATE TABLE order_items (
    ID INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price_at_sale DECIMAL(10, 2),
    discount_applied DECIMAL(10, 2),
    final_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(ID),
    FOREIGN KEY (book_id) REFERENCES books(ID)
);

-- Dummy Data
INSERT INTO order_items (ID, order_id, book_id, quantity, price_at_sale, discount_applied, final_price) VALUES
(1, 1, 1, 2, 20.00, 5.00, 35.00),
(2, 2, 2, 1, 25.00, 5.00, 20.00);
