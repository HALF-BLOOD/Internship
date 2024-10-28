CREATE TABLE reviews (
    ID INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    rating ENUM('1', '2', '3', '4', '5'),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(ID),
    FOREIGN KEY (book_id) REFERENCES books(ID)
);

-- Dummy Data
INSERT INTO reviews (ID, customer_id, book_id, rating, review_text) VALUES
(1, 1, 1, '5','good book');
