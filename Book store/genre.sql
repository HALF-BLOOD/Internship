CREATE TABLE genres (
    ID INT PRIMARY KEY,
    genre_name VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dummy Data
INSERT INTO genres (ID, genre_name, description) VALUES
(1, 'Fiction', 'Fictional works that tell stories created from the imagination.'),
(2, 'Non-Fiction', 'Informative texts that provide factual information.');

CREATE VIEW BookGenreView AS
SELECT 
    books.ID AS book_id,
    books.title AS book_title,
    genres.genre_name AS genre_name,
    books.publish_date,
    books.description,
    books.created_at,
    books.updated_at
FROM 
    books
JOIN 
    genres ON books.genre_id = genres.ID;

SELECT * FROM BookGenreView;

