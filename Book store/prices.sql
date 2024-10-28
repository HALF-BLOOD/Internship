CREATE TABLE prices (
    price_id INT PRIMARY KEY,
    book_id INT,
    price DECIMAL(10, 2),
    discount_price DECIMAL(10, 2),
    effective_date DATE,
    expiration_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(ID)
);

-- Dummy Data
INSERT INTO prices (price_id, book_id, price, discount_price, effective_date, expiration_date) VALUES
(1, 1, 20.00, 15.00, '2023-01-01', '2023-12-31'),
(2, 2, 25.00, 20.00, '2023-01-01', '2023-12-31');
