CREATE TABLE books (
    ID INT PRIMARY KEY,
    title VARCHAR(255),
    publish_date DATE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO books (ID, title, publish_date, description) VALUES
(1, 'Book A', '2023-05-20', 'Description for Book A'),
(2, 'Book B', '2022-03-15', 'Description for Book B');

INSERT INTO books (ID,title, genre_id, publish_date, description, created_at, updated_at)
VALUES (3, 'Sample Book', 1, '2023-01-01', 'A sample book description.', NOW(), NOW());

INSERT INTO books (ID, title, author_id, publish_date, description, created_at, updated_at)
VALUES (4, 'Sample Book', 1, '2023-01-01', 'A test book description.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

ALTER TABLE books
ADD author_id INT,
ADD genre_id INT,
ADD FOREIGN KEY (author_id) REFERENCES authors(ID),
ADD FOREIGN KEY (genre_id) REFERENCES genres(ID);

CREATE VIEW BookStockView AS
SELECT 
    books.ID,
    books.title AS book_title,
    inventory.available_copies AS stock_level,
    inventory.last_restock_date
FROM 
    books
JOIN 
    inventory ON books.ID = inventory.book_id;
SELECT * FROM BookStockView;


