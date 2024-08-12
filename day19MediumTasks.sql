use bankrecords;
CREATE TABLE bank_accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_holder_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    order_date DATE NOT NULL
);
CREATE TABLE sales_summary (
    product_id INT PRIMARY KEY,
    total_sales DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    last_calculated DATE
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    sale_date DATE NOT NULL
);

DELIMITER //

CREATE PROCEDURE TransferAmount(
    IN sender_account_id INT,
    IN receiver_account_id INT,
    IN transfer_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE insufficient_balance_error CONDITION FOR SQLSTATE '45000';
    DECLARE current_balance DECIMAL(10, 2);

    START TRANSACTION;

    -- Lock the sender's account row for update
    SELECT balance INTO current_balance 
    FROM bank_accounts 
    WHERE account_id = sender_account_id 
    FOR UPDATE;

    -- Check if the sender has enough balance
    IF current_balance < transfer_amount THEN
        SIGNAL insufficient_balance_error
        SET MESSAGE_TEXT = 'Insufficient balance to complete the transfer';
    ELSE
        -- Deduct the amount from sender's account
        UPDATE bank_accounts 
        SET balance = balance - transfer_amount 
        WHERE account_id = sender_account_id;

        -- Add the amount to receiver's account
        UPDATE bank_accounts 
        SET balance = balance + transfer_amount 
        WHERE account_id = receiver_account_id;
    END IF;

    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER PreventOrderDeletion 
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    DECLARE order_deletion_error CONDITION FOR SQLSTATE '45000';

    -- Check the status of the order
    IF OLD.status IN ('Shipped', 'Delivered') THEN
        SIGNAL order_deletion_error
        SET MESSAGE_TEXT = 'Deletion not allowed: Order is already Shipped or Delivered';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateTotalSales()
BEGIN
    DECLARE calculation_date DATE;
    SET calculation_date = CURDATE();

    -- Calculate total sales by product ID
    UPDATE sales_summary AS ss
    JOIN (
        SELECT product_id, SUM(quantity * price) AS total_sales
        FROM sales
        GROUP BY product_id
    ) AS totals
    ON ss.product_id = totals.product_id
    SET ss.total_sales = totals.total_sales,
        ss.last_calculated = calculation_date;

    -- Insert new products if not already in sales_summary
    INSERT INTO sales_summary (product_id, total_sales, last_calculated)
    SELECT s.product_id, SUM(s.quantity * s.price) AS total_sales, calculation_date
    FROM sales s
    LEFT JOIN sales_summary ss ON s.product_id = ss.product_id
    WHERE ss.product_id IS NULL
    GROUP BY s.product_id;
END //

DELIMITER ;

