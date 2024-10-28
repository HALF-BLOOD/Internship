CREATE TABLE authors (
    ID INT PRIMARY KEY,
    author_name VARCHAR(255),
    biography TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dummy Data
INSERT INTO authors (ID, author_name, biography) VALUES
(1, 'Author A', 'Biography of Author A'),
(2, 'Author B', 'Biography of Author B');
