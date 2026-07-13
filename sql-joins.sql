-- 1. INNER JOIN: each track with its album title (only matching rows)
SELECT t.Name AS Track, al.Title AS Album
FROM tracks t
INNER JOIN albums al ON al.AlbumId = t.AlbumId;

-- 2. LEFT JOIN: every artist with album count, including artists with 0 albums
SELECT ar.Name AS Artist, COUNT(al.AlbumId) AS Albums
FROM artists ar
LEFT JOIN albums al ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId
ORDER BY Albums ASC;

-- 3. RIGHT JOIN: same result as #2, written with the tables swapped
SELECT ar.Name AS Artist, COUNT(al.AlbumId) AS Albums
FROM albums al
RIGHT JOIN artists ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId
ORDER BY Albums ASC;

-- 4. FULL OUTER JOIN: all artists and all albums, matched where possible
SELECT ar.Name AS Artist, al.Title AS Album
FROM artists ar
FULL OUTER JOIN albums al ON al.ArtistId = ar.ArtistId;

-- 5. CROSS JOIN: every media type combined with every genre (5 x 25 = 125 rows)
SELECT m.Name AS Media, g.Name AS Genre
FROM media_types m
CROSS JOIN genres g;

-- 6. SELF JOIN: each employee alongside their manager
SELECT e.FirstName || ' ' || e.LastName AS Employee,
       m.FirstName || ' ' || m.LastName AS Manager
FROM employees e
LEFT JOIN employees m ON m.EmployeeId = e.ReportsTo;

-- 7. Multi-table join: connect each sold line item back to its artist
SELECT ii.InvoiceLineId, t.Name AS Track, al.Title AS Album, ar.Name AS Artist
FROM invoice_items ii
JOIN tracks  t  ON t.TrackId   = ii.TrackId
JOIN albums  al ON al.AlbumId  = t.AlbumId
JOIN artists ar ON ar.ArtistId = al.ArtistId;
