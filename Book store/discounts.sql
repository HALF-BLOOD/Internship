CREATE TABLE discounts (
    ID INT PRIMARY KEY,
    discount_type ENUM('Author', 'Book', 'Code'),
    author_id INT,
    book_id INT,
    discount_code VARCHAR(50),
    discount_percentage DECIMAL(5, 2),
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(ID)
);

-- Dummy Data
INSERT INTO discounts (ID, discount_type, book_id, discount_code, discount_percentage, start_date, end_date) VALUES
(1, 'Book', 1, NULL, 10.00, '2023-01-01', '2023-12-31');
