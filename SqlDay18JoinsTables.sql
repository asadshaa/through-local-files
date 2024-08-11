/* -The Answers To Easy Questions- */

SELECT Books.Title AS BookTitle, CONCAT(Authors.FirstName, ' ', Authors.LastName) AS AuthorName
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID;

SELECT Books.Title AS BookTitle, Sales.SaleDate, Sales.Quantity
FROM Books
LEFT JOIN Sales ON Books.BookID = Sales.BookID;

SELECT Books.Title AS BookTitle, Sales.SaleDate
FROM Sales
LEFT JOIN Books ON Sales.BookID = Books.BookID;

/* -The Answers To Medium Questions- */

SELECT DISTINCT Authors.FirstName, Authors.LastName
FROM Authors
JOIN Books ON Authors.AuthorID = Books.AuthorID
WHERE Books.Price > 15;

SELECT Books.Title AS BookTitle, Sales.Quantity, Sales.SaleDate
FROM Books
JOIN Sales ON Books.BookID = Sales.BookID;

SELECT Books.Title AS BookTitle, SUM(Sales.Quantity) AS TotalQuantity
FROM Books
JOIN Sales ON Books.BookID = Sales.BookID
GROUP BY Books.Title;

/* -The Answers To Hard Questions- */

SELECT Authors.FirstName, Authors.LastName, AVG(Books.Price) AS AveragePrice
FROM Authors
JOIN Books ON Authors.AuthorID = Books.AuthorID
GROUP BY Authors.FirstName, Authors.LastName;

SELECT Authors.FirstName, Authors.LastName
FROM Authors
LEFT JOIN Books ON Authors.AuthorID = Books.AuthorID
LEFT JOIN Sales ON Books.BookID = Sales.BookID
WHERE Sales.BookID IS NULL;

SELECT Books.Title AS BookTitle, Sales.SaleDate
FROM Books
JOIN Sales ON Books.BookID = Sales.BookID
GROUP BY Books.Title, Sales.SaleDate
HAVING COUNT(Sales.SaleID) > 1;

SELECT Books.Title AS BookTitle, 
       SUM(Sales.Quantity) AS TotalQuantity,
       SUM(Books.Price * Sales.Quantity) AS TotalRevenue
FROM Books
JOIN Sales ON Books.BookID = Sales.BookID
GROUP BY Books.Title;
