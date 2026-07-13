-- 1. Just cap the rows: first 10 tracks
SELECT TrackId, Name
FROM tracks
LIMIT 10;

-- 2. Top-N: 5 longest tracks (order first, then limit)
SELECT Name, Milliseconds
FROM tracks
ORDER BY Milliseconds DESC
LIMIT 5;

-- 3. Pagination: skip 20 rows, take the next 10
SELECT TrackId, Name
FROM tracks
ORDER BY TrackId
LIMIT 10 OFFSET 20;

-- 4. Second page of 5: skip 5, take 5
SELECT TrackId, Name
FROM tracks
ORDER BY TrackId
LIMIT 5 OFFSET 5;

-- 5. Real-world top-N: 5 biggest-spending customers
SELECT c.CustomerId, c.FirstName, c.LastName, SUM(i.Total) AS Spent
FROM customers c
JOIN invoices i ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY Spent DESC
LIMIT 5;
