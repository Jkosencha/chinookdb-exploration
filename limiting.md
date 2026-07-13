# Limiting Data (`LIMIT` / `OFFSET`)

`LIMIT` caps how many rows a query returns. Combined with `ORDER BY` it answers
"top-N" questions; combined with `OFFSET` it powers **pagination**.

## Syntax

```sql
SELECT columns FROM table
ORDER BY column
LIMIT row_count [OFFSET skip_count];
```

## Examples

**1. Just cap the rows - first 10 tracks**
```sql
SELECT TrackId, Name
FROM tracks
LIMIT 10;
```

**2. Top-N - 5 longest tracks** (order first, then limit)
```sql
SELECT Name, Milliseconds
FROM tracks
ORDER BY Milliseconds DESC
LIMIT 5;
```

**3. Pagination with `OFFSET`** - skip 20, take the next 10 (page 3 at 10/page)
```sql
SELECT TrackId, Name
FROM tracks
ORDER BY TrackId
LIMIT 10 OFFSET 20;
```

**4. Second page of 5** - skip 5, take 5
```sql
SELECT TrackId, Name
FROM tracks
ORDER BY TrackId
LIMIT 5 OFFSET 5;
```

**5. Real-world top-N - 5 biggest-spending customers**
(combines join + group + order + limit)
```sql
SELECT c.CustomerId, c.FirstName, c.LastName, SUM(i.Total) AS Spent
FROM customers c
JOIN invoices i ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY Spent DESC
LIMIT 5;
```
Top spender: Helena Holý ($49.62).

## Notes

- **Always pair `LIMIT` with `ORDER BY`** for top-N. Without ordering, "the first
  5 rows" is arbitrary and can change between runs.
- SQLite also accepts the comma form `LIMIT offset, count` (e.g. `LIMIT 20, 10`),
  but `LIMIT ... OFFSET ...` is clearer and more portable.
- Page number → offset formula: `OFFSET = (page - 1) * page_size`.

## References

- SQLite `LIMIT`: <https://www.sqlitetutorial.net/sqlite-limit/>
