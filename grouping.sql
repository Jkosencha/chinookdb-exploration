-- 1. COUNT per group: tracks per genre
SELECT g.Name AS Genre, COUNT(t.TrackId) AS Tracks
FROM tracks t
JOIN genres g ON g.GenreId = t.GenreId
GROUP BY g.GenreId
ORDER BY Tracks DESC;

-- 2. SUM per group: total sales per country
SELECT BillingCountry, SUM(Total) AS Sales
FROM invoices
GROUP BY BillingCountry
ORDER BY Sales DESC;

-- 3. AVG per group: average track length (minutes) per genre
SELECT g.Name AS Genre, ROUND(AVG(t.Milliseconds) / 60000.0, 2) AS AvgMinutes
FROM tracks t
JOIN genres g ON g.GenreId = t.GenreId
GROUP BY g.GenreId
ORDER BY AvgMinutes DESC;

-- 4. COUNT customers per country
SELECT Country, COUNT(*) AS Customers
FROM customers
GROUP BY Country
ORDER BY Customers DESC;

-- 5. HAVING: only countries with more than 4 customers
SELECT Country, COUNT(*) AS Customers
FROM customers
GROUP BY Country
HAVING COUNT(*) > 4
ORDER BY Customers DESC;

-- 6. Several aggregates at once: sales summary per country
SELECT BillingCountry,
       COUNT(*)             AS Invoices,
       SUM(Total)           AS Sales,
       ROUND(AVG(Total), 2) AS AvgInvoice,
       MAX(Total)           AS MaxInvoice
FROM invoices
GROUP BY BillingCountry
ORDER BY Sales DESC;
