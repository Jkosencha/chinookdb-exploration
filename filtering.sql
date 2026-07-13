-- 1. Equality: customers from Brazil
SELECT FirstName, LastName, Country
FROM customers
WHERE Country = 'Brazil';

-- 2. Comparison: tracks longer than 5 minutes (300000 ms)
SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > 300000;

-- 3. AND: USA invoices over $10 (both conditions must hold)
SELECT InvoiceId, BillingCountry, Total
FROM invoices
WHERE BillingCountry = 'USA' AND Total > 10;

-- 4. OR: customers from Brazil or Argentina
SELECT FirstName, LastName, Country
FROM customers
WHERE Country = 'Brazil' OR Country = 'Argentina';

-- 5. IN: customers from a list of countries
SELECT FirstName, LastName, Country
FROM customers
WHERE Country IN ('Brazil', 'Argentina', 'Chile');

-- 6. BETWEEN: invoices with a total from 5 to 10 (inclusive)
SELECT InvoiceId, Total
FROM invoices
WHERE Total BETWEEN 5 AND 10;

-- 7. LIKE: track names containing "Love"
SELECT TrackId, Name
FROM tracks
WHERE Name LIKE '%Love%';

-- 8. IS NULL: tracks with no composer listed
SELECT TrackId, Name, Composer
FROM tracks
WHERE Composer IS NULL;

-- 9. Not equal: customers outside the USA
SELECT FirstName, LastName, Country
FROM customers
WHERE Country <> 'USA';
