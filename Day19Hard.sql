	CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL
);

CREATE TABLE events_archive (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL
);
DELIMITER //

CREATE PROCEDURE ArchiveEvents(IN days_old INT)
BEGIN
    DECLARE archive_date DATE;
    SET archive_date = CURDATE() - INTERVAL days_old DAY;

    -- Archive records older than specified days
    INSERT INTO events_archive (event_id, event_name, event_date)
    SELECT e.event_id, e.event_name, e.event_date
    FROM events e
    LEFT JOIN events_archive ea ON e.event_id = ea.event_id
    WHERE e.event_date < archive_date AND ea.event_id IS NULL;

    -- Delete archived records from the original table
    DELETE FROM events WHERE event_date < archive_date;
END //

DELIMITER ;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    updated_by VARCHAR(255)
);

CREATE TABLE salary_changes (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME,
    updated_by VARCHAR(255)
);
DELIMITER //

CREATE TRIGGER LogSalaryChange
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Check if the salary has changed
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_changes (employee_id, old_salary, new_salary, change_date, updated_by)
        VALUES (OLD.employee_id, OLD.salary, NEW.salary, NOW(), NEW.updated_by);
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE DynamicSelect(
    IN table_name VARCHAR(255),
    IN column_names VARCHAR(255)
)
BEGIN
    DECLARE stmt VARCHAR(1024);

    -- Validate the input parameters to prevent SQL injection
    IF table_name NOT REGEXP '^[a-zA-Z0-9_]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid table name';
    END IF;

    IF column_names NOT REGEXP '^[a-zA-Z0-9_, ]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid column names';
    END IF;

    -- Build the dynamic SELECT statement
    SET stmt = CONCAT('SELECT ', column_names, ' FROM ', table_name);
    
    -- Prepare and execute the dynamic statement
    PREPARE dyn_stmt FROM stmt;
    EXECUTE dyn_stmt;
    DEALLOCATE PREPARE dyn_stmt;
END //

DELIMITER ;
CREATE TABLE stock (
    stock_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE stock_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    stock_id INT,
    operation_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    old_quantity INT,
    new_quantity INT,
    change_date DATETIME
);
DELIMITER //

-- Trigger for INSERT operation
CREATE TRIGGER StockInsertHistory
AFTER INSERT ON stock
FOR EACH ROW
BEGIN
    INSERT INTO stock_history (stock_id, operation_type, new_quantity, change_date)
    VALUES (NEW.stock_id, 'INSERT', NEW.quantity, NOW());
END //

-- Trigger for UPDATE operation
CREATE TRIGGER StockUpdateHistory
BEFORE UPDATE ON stock
FOR EACH ROW
BEGIN
    INSERT INTO stock_history (stock_id, operation_type, old_quantity, new_quantity, change_date)
    VALUES (OLD.stock_id, 'UPDATE', OLD.quantity, NEW.quantity, NOW());
END //

-- Trigger for DELETE operation
CREATE TRIGGER StockDeleteHistory
BEFORE DELETE ON stock
FOR EACH ROW
BEGIN
    INSERT INTO stock_history (stock_id, operation_type, old_quantity, change_date)
    VALUES (OLD.stock_id, 'DELETE', OLD.quantity, NOW());
END //

DELIMITER ;
