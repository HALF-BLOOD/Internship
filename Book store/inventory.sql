CREATE TABLE inventory (
    ID INT PRIMARY KEY,
    book_id INT,
    available_copies INT,
    supplier_batch_id INT,
    last_restock_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(ID),
    FOREIGN KEY (supplier_batch_id) REFERENCES supplier_batches(ID)
);

-- Dummy Data
INSERT INTO inventory (ID, book_id, available_copies, supplier_batch_id, last_restock_date) VALUES
(1, 1, 100, 1, '2023-05-20'),
(2, 2, 150, 2, '2023-06-15');
