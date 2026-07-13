# Grouping Data (`GROUP BY` + aggregates)

`GROUP BY` collapses rows that share a value into one row per group, so you can
summarize with **aggregate functions**. `HAVING` then filters the groups.

## Aggregate functions

| Function | Returns |
|----------|---------|
| `COUNT(*)` / `COUNT(col)` | Number of rows / non-NULL values |
| `SUM(col)` | Total |
| `AVG(col)` | Average |
| `MIN(col)` / `MAX(col)` | Smallest / largest |

## Order of execution

`FROM` → `WHERE` → **`GROUP BY`** → **`HAVING`** → `SELECT` → `ORDER BY` → `LIMIT`.
That is why `WHERE` filters rows *before* grouping and `HAVING` filters *after*.

## Examples

**1. `COUNT` per group - tracks per genre**
```sql
SELECT g.Name AS Genre, COUNT(t.TrackId) AS Tracks
FROM tracks t
JOIN genres g ON g.GenreId = t.GenreId
GROUP BY g.GenreId
ORDER BY Tracks DESC;
```
Rock leads with 1,297 tracks, then Latin (579), Metal (374).

**2. `SUM` per group - total sales per country**
```sql
SELECT BillingCountry, SUM(Total) AS Sales
FROM invoices
GROUP BY BillingCountry
ORDER BY Sales DESC;
```
USA tops the list ($523.06), then Canada ($303.96).

**3. `AVG` per group - average track length (minutes) per genre**
```sql
SELECT g.Name AS Genre, ROUND(AVG(t.Milliseconds) / 60000.0, 2) AS AvgMinutes
FROM tracks t
JOIN genres g ON g.GenreId = t.GenreId
GROUP BY g.GenreId
ORDER BY AvgMinutes DESC;
```
"Sci Fi & Fantasy" averages ~48.5 min (these are TV episodes, not songs).

**4. `COUNT` customers per country**
```sql
SELECT Country, COUNT(*) AS Customers
FROM customers
GROUP BY Country
ORDER BY Customers DESC;
```
USA has 13 customers, Canada 8.

**5. `HAVING` - only countries with more than 4 customers**
```sql
SELECT Country, COUNT(*) AS Customers
FROM customers
GROUP BY Country
HAVING COUNT(*) > 4
ORDER BY Customers DESC;
```
Returns 4 countries: USA, Canada, France, Brazil.

**6. Several aggregates at once - sales summary per country**
```sql
SELECT BillingCountry,
       COUNT(*)            AS Invoices,
       SUM(Total)          AS Sales,
       ROUND(AVG(Total),2) AS AvgInvoice,
       MAX(Total)          AS MaxInvoice
FROM invoices
GROUP BY BillingCountry
ORDER BY Sales DESC;
```

## Notes

- Every non-aggregated column in the `SELECT` should appear in `GROUP BY`.
  (SQLite is lenient and will pick an arbitrary row's value otherwise — which is
  a common source of confusing results.)
- Use `WHERE` to filter **rows** before grouping; use `HAVING` to filter **groups**
  after aggregating. `HAVING COUNT(*) > 4` cannot be written with `WHERE`.
- `COUNT(*)` counts rows; `COUNT(column)` ignores `NULL`s in that column.

## References

- SQLite `GROUP BY`: <https://www.sqlitetutorial.net/sqlite-group-by/>
- SQLite `HAVING`: <https://www.sqlitetutorial.net/sqlite-having/>
- Aggregate functions: <https://www.sqlitetutorial.net/sqlite-aggregate-functions/>
