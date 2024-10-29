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

INSERT INTO prices (price_id, book_id, price, discount_price, effective_date, expiration_date, created_at, updated_at)
VALUES (4, 1, 100.00, 80.00, '2023-01-01', '2025-01-01', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


CREATE VIEW Current_Day_Book_Pricing AS
SELECT 
    b.ID AS book_id,
    b.title AS book_title,
    p.price AS current_price,
    p.discount_price AS current_discount_price,
    p.effective_date,
    p.expiration_date
FROM 
    books b
JOIN 
    prices p ON b.ID = p.book_id
WHERE 
    CURRENT_DATE BETWEEN p.effective_date AND p.expiration_date
ORDER BY 
    b.title;

Select * from Current_Day_Book_Pricing;
