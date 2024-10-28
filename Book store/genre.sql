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
