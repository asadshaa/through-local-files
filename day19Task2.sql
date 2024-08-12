-- Easy Questions--
CREATE TABLE IF NOT EXISTS products_backup (
    Pid INT,
    Pname VARCHAR(10),
    Puser VARCHAR(50)
);

DELIMITER //

CREATE TRIGGER BeforeDeleteOnProducts
BEFORE DELETE ON products
FOR EACH ROW
BEGIN

    INSERT INTO products_backup (Pid, Pname, Puser)
    VALUES (OLD.ID, OLD.PRODUCT_NAME, OLD.USER);
END //

DELIMITER ;

CREATE TABLE IF NOT EXISTS logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_message VARCHAR(255),
    created_at DATETIME
);

CREATE TABLE IF NOT EXISTS deletion_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    deleted_at DATETIME,
    records_deleted INT
);
DELIMITER //

CREATE PROCEDURE DeleteOldLogs()
BEGIN
    DECLARE deleted_count INT;

    DELETE FROM logs 
    WHERE created_at < NOW() - INTERVAL 30 DAY;

    SET deleted_count = ROW_COUNT();

    INSERT INTO deletion_logs (deleted_at, records_deleted)
    VALUES (NOW(), deleted_count);
END //

DELIMITER ;
CALL DeleteOldLogs();

SET SQL_SAFE_UPDATES = 0;
CALL DeleteOldLogs();



