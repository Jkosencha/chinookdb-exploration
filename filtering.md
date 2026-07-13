# Filtering Data (`WHERE`)

Filtering returns only the rows that match a condition. In SQL this is the
`WHERE` clause, which runs **before** grouping and ordering.

## Common filter tools

| Tool | Meaning |
|------|---------|
| `=`, `<>` / `!=`, `<`, `>`, `<=`, `>=` | Compare a column to a value |
| `AND`, `OR`, `NOT` | Combine multiple conditions |
| `IN (...)` | Match any value in a list |
| `BETWEEN a AND b` | Match an inclusive range |
| `LIKE 'pattern'` | Match text patterns (`%` = any chars, `_` = one char) |
| `IS NULL` / `IS NOT NULL` | Match missing values (you cannot use `= NULL`) |

## Examples

**1. Equality - customers from Brazil**
```sql
SELECT FirstName, LastName, Country
FROM customers
WHERE Country = 'Brazil';
```
Returns 5 rows (Luís Gonçalves, Eduardo Martins, …).

**2. Comparison - tracks longer than 5 minutes**
```sql
SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > 300000;
```
1,069 tracks match.

**3. `AND` - big USA invoices**
```sql
SELECT InvoiceId, BillingCountry, Total
FROM invoices
WHERE BillingCountry = 'USA' AND Total > 10;
```
15 rows — both conditions must be true.

**4. `OR` - two countries**
```sql
SELECT FirstName, LastName, Country
FROM customers
WHERE Country = 'Brazil' OR Country = 'Argentina';
```
6 rows.

**5. `IN` - a list of countries** (cleaner than chaining `OR`)
```sql
SELECT FirstName, LastName, Country
FROM customers
WHERE Country IN ('Brazil', 'Argentina', 'Chile');
```
7 rows.

**6. `BETWEEN` - invoices in a total range (inclusive)**
```sql
SELECT InvoiceId, Total
FROM invoices
WHERE Total BETWEEN 5 AND 10;
```
115 rows.

**7. `LIKE` - track names containing "Love"**
```sql
SELECT TrackId, Name
FROM tracks
WHERE Name LIKE '%Love%';
```
114 rows (e.g. "Love In An Elevator", "Whole Lotta Love"). SQLite `LIKE` is
case-insensitive for ASCII by default.

**8. `IS NULL` - tracks with no listed composer**
```sql
SELECT TrackId, Name, Composer
FROM tracks
WHERE Composer IS NULL;
```
977 rows. Note: `Composer = NULL` would return **nothing** - always use `IS NULL`.

**9. Not equal - customers outside the USA**
```sql
SELECT FirstName, LastName, Country
FROM customers
WHERE Country <> 'USA';
```
46 rows.

## Notes 

- `WHERE` filters **individual rows**; to filter **grouped** results use `HAVING`
  (see [`grouping.md`](grouping.md)).
- `NULL` is "unknown", so any comparison with `=`, `<`, `>` against `NULL` yields
  `NULL` (not true) - that is why `IS NULL` exists.
- Combine `AND`/`OR` carefully; use parentheses to make precedence explicit, e.g.
  `WHERE (Country = 'Brazil' OR Country = 'Chile') AND Total > 5`.

## References

- SQLite `WHERE`: <https://www.sqlitetutorial.net/sqlite-where/>
- `BETWEEN`: <https://www.sqlitetutorial.net/sqlite-between/>
- `IN`: <https://www.sqlitetutorial.net/sqlite-in/>
- `LIKE`: <https://www.sqlitetutorial.net/sqlite-like/>
- `IS NULL`: <https://www.sqlitetutorial.net/sqlite-is-null/>
