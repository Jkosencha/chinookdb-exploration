-- 1. Ascending (default): track names A -> Z
SELECT Name
FROM tracks
ORDER BY Name ASC;

-- 2. Descending: longest tracks first
SELECT Name, Milliseconds
FROM tracks
ORDER BY Milliseconds DESC;

-- 3. Multiple columns: sort by Country, then City
SELECT FirstName, LastName, Country, City
FROM customers
ORDER BY Country ASC, City ASC;

-- 4. Order by an expression / alias
SELECT Name, Milliseconds / 1000 AS Seconds
FROM tracks
ORDER BY Seconds DESC;

-- 5. Order by column position (2 = LastName)
SELECT FirstName, LastName
FROM customers
ORDER BY 2 ASC;

-- 6. Control NULL placement: composer-less tracks go last
SELECT Name, Composer
FROM tracks
ORDER BY Composer NULLS LAST;
