CREATE TABLE supplier_batches (
    ID INT PRIMARY KEY,
    supplier_id INT,
    book_id INT,
    quantity INT,
    total_cost DECIMAL(10, 2),
    supply_date DATE,
    amount_paid DECIMAL(10, 2),
    amount_due DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(ID),
    FOREIGN KEY (book_id) REFERENCES books(ID)
);

-- Dummy Data
INSERT INTO supplier_batches (ID, supplier_id, book_id, quantity, total_cost, supply_date, amount_paid, amount_due) VALUES
(1, 1, 1, 100, 2000.00, '2023-05-20', 1500.00, 500.00),
(2, 2, 2, 150, 3000.00, '2023-06-15', 3000.00, 0.00);
