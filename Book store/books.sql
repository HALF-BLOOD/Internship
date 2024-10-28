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

ALTER TABLE books
ADD author_id INT,
ADD genre_id INT,
ADD FOREIGN KEY (author_id) REFERENCES authors(ID),
ADD FOREIGN KEY (genre_id) REFERENCES genres(ID);
