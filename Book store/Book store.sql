create database Book_store;
use Book_store;
show tables;

DELIMITER //

CREATE PROCEDURE GenerateSalesReport(IN start_date DATE, IN end_date DATE)
BEGIN
    -- Temporary table to hold the report data
    CREATE TEMPORARY TABLE IF NOT EXISTS SalesReport (
        book_id INT,
        book_title VARCHAR(255),
        total_quantity_sold INT,
        total_sales DECIMAL(10, 2),
        total_discount DECIMAL(10, 2)
    );

    -- Insert aggregated data for the sales report
    INSERT INTO SalesReport (book_id, book_title, total_quantity_sold, total_sales, total_discount)
    SELECT 
        b.ID AS book_id,
        b.title AS book_title,
        SUM(oi.quantity) AS total_quantity_sold,
        SUM(oi.final_price * oi.quantity) AS total_sales,
        SUM((oi.price_at_sale - oi.final_price) * oi.quantity) AS total_discount
    FROM 
        books b
    JOIN 
        order_items oi ON b.ID = oi.book_id
    JOIN 
        orders o ON oi.order_id = o.ID
    WHERE 
        o.order_date BETWEEN start_date AND end_date
    GROUP BY 
        b.ID, b.title;

    -- Select the data from the temporary table to show as the result
    SELECT 
        book_id,
        book_title,
        total_quantity_sold,
        total_sales,
        total_discount
    FROM 
        SalesReport;

    -- Drop the temporary table after the report is generated
    DROP TEMPORARY TABLE IF EXISTS SalesReport;
END //

DELIMITER ;
CALL GenerateSalesReport('2024-01-01', '2024-12-31');

DRop procedure ProcessMultipleItemsOrder;
DELIMITER //

CREATE PROCEDURE ProcessMultipleItemsOrder(
    IN orderID INT,
    IN customerID INT,
    IN bookData JSON         
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE book_id INT;
    DECLARE quantity INT;
    DECLARE current_price DECIMAL(10, 2);
    DECLARE discount DECIMAL(10, 2);
    DECLARE final_price DECIMAL(10, 2);
    DECLARE item_count INT;
    DECLARE item_id INT;

    -- Get the number of items in the JSON array
    SET item_count = JSON_LENGTH(bookData);

    WHILE i < item_count DO
        -- Extract book_id, quantity, and item_id from JSON
        SET item_id = JSON_UNQUOTE(JSON_EXTRACT(bookData, CONCAT('$[', i, '].id')));
        SET book_id = JSON_UNQUOTE(JSON_EXTRACT(bookData, CONCAT('$[', i, '].book_id')));
        SET quantity = JSON_UNQUOTE(JSON_EXTRACT(bookData, CONCAT('$[', i, '].quantity')));

        -- Fetch current price and discount for each book
        SELECT price INTO current_price FROM prices WHERE book_id = book_id LIMIT 1;
        SELECT discount_percentage INTO discount FROM discounts WHERE book_id = book_id LIMIT 1;

        IF discount IS NULL THEN
            SET discount = 0;
        END IF;

        -- Calculate final price after discount
        SET final_price = current_price * (1 - discount / 100);

        -- Insert each item into order_items table with the specified ID
        INSERT INTO order_items (ID, order_id, book_id, quantity, price_at_sale, discount_applied, final_price, created_at, updated_at)
        VALUES (item_id, orderID, book_id, quantity, current_price, discount, final_price, NOW(), NOW());

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL ProcessMultipleItemsOrder(6, 1, '[{"id": 101, "book_id": 1, "quantity": 2}, {"id": 102, "book_id": 2, "quantity": 1}]');

select * from order_items;



