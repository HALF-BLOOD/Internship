CREATE TABLE suppliers (
    ID INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dummy Data
INSERT INTO suppliers (ID, supplier_name, contact_email, contact_phone) VALUES
(1, 'Supplier A', 'supplierA@example.com', '1234567890'),
(2, 'Supplier B', 'supplierB@example.com', '0987654321');
