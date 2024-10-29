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

CREATE VIEW Book_Average_Rating_And_Sales AS
SELECT 
    b.ID AS book_id,
    b.title AS book_title,
    COALESCE(AVG(r.rating), 0) AS average_rating,
    COALESCE(COUNT(r.ID), 0) AS rating_count,
    COALESCE(SUM(oi.quantity), 0) AS total_books_sold
FROM 
    books b
LEFT JOIN 
    reviews r ON b.ID = r.book_id
LEFT JOIN 
    order_items oi ON b.ID = oi.book_id
GROUP BY 
    b.ID, b.title
ORDER BY 
    b.title;
select * from Book_Average_Rating_And_Sales;


DELIMITER //
CREATE PROCEDURE GetBookReviews(IN bookID INT)
BEGIN
    SELECT 
        r.ID AS review_id,
        r.customer_id,
        r.rating,
        r.review_text,
        r.review_date,
        r.created_at,
        r.updated_at
    FROM 
        reviews r
    WHERE 
        r.book_id = bookID;
END //
DELIMITER ;
CALL GetBookReviews(1);  

