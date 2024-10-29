CREATE TABLE discounts (
    ID INT PRIMARY KEY,
    discount_type ENUM('Author', 'Book', 'Code'),
    author_id INT,
    book_id INT,
    discount_code VARCHAR(50),
    discount_percentage DECIMAL(5, 2),
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(ID)
);

-- Dummy Data
INSERT INTO discounts (ID, discount_type, book_id, discount_code, discount_percentage, start_date, end_date) VALUES
(1, 'Book', 1, NULL, 10.00, '2023-01-01', '2023-12-31');

INSERT INTO discounts (ID, discount_type, author_id, book_id, discount_code, discount_percentage, start_date, end_date, created_at, updated_at)
VALUES (4, 'Book', NULL, 1, 'DISCOUNT20', 20.00, '2024-10-01', '2024-12-01', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


DELIMITER //

CREATE TRIGGER apply_discount_on_insert
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE discount_percent DECIMAL(5, 2);
    DECLARE discount_exists BOOLEAN;

    -- Check if a valid discount exists for the book
    SELECT d.discount_percentage INTO discount_percent
    FROM discounts d
    WHERE d.book_id = NEW.book_id
      AND d.start_date <= CURRENT_DATE
      AND d.end_date >= CURRENT_DATE
    LIMIT 1;

    SET discount_exists = (discount_percent IS NOT NULL);

    -- If a discount exists, calculate the discounted price
    IF discount_exists THEN
        SET NEW.discount_applied = discount_percent;
        SET NEW.final_price = NEW.price_at_sale * (1 - discount_percent / 100);
    ELSE
        -- If no discount, final price is the original price
        SET NEW.discount_applied = 0;
        SET NEW.final_price = NEW.price_at_sale;
    END IF;
END;
//
DELIMITER ;

