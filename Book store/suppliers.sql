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


CREATE VIEW Supplier_Batch_Details AS
SELECT 
    sb.ID AS supplier_batch_id,
    sb.supply_date,
    sb.total_cost,
    sb.amount_paid,
    sb.amount_due,
    s.supplier_name,
    s.contact_email,
    s.contact_phone,
    s.created_at AS supplier_created_at,
    s.updated_at AS supplier_updated_at
FROM 
    supplier_batches sb
JOIN 
    suppliers s ON sb.supplier_id = s.ID
ORDER BY 
    sb.supply_date;

Select * from Supplier_Batch_Details;
