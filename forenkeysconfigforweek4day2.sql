SELECT * FROM Books
ORDER BY Price ASC
LIMIT 1;


SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

SELECT COUNT(*) AS TotalBooks FROM Books;

SELECT AVG(Price) AS AveragePrice FROM Books;
SELECT SUM(Quantity) AS TotalSalesQuantity FROM Sales;

SELECT * FROM Books
WHERE Title LIKE '%Guide%';SELECT * FROM Books
WHERE Title LIKE 'A%';

SELECT * FROM Books
WHERE Genre IN ('Fiction', 'Science Fiction');


SELECT * FROM Books
WHERE PublicationYear BETWEEN 1930 AND 1990;
sales
