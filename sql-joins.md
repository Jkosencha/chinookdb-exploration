# SQL Joins

A **join** combines rows from two (or more) tables based on a related column -
almost always a **foreign key** matching a **primary key**. Joins are how you
reassemble the normalized Chinook tables into meaningful results.

## Visual summary

```
INNER JOIN        only matching rows in BOTH tables
LEFT JOIN         all LEFT rows + matches (unmatched right = NULL)
RIGHT JOIN        all RIGHT rows + matches (unmatched left = NULL)
FULL OUTER JOIN   all rows from BOTH sides (unmatched = NULL)
CROSS JOIN        every combination (Cartesian product)
SELF JOIN         a table joined to itself
```

## The join types

### 1. INNER JOIN - matches in both tables

Keeps only rows where the join condition is satisfied on both sides.

```sql
SELECT t.Name AS Track, al.Title AS Album
FROM tracks t
INNER JOIN albums al ON al.AlbumId = t.AlbumId;
```

### 2. LEFT JOIN - keep all left rows

Returns every row from the left table; where there's no match on the right, the
right columns are `NULL`. Great for "find records with nothing related".

```sql
SELECT ar.Name AS Artist, COUNT(al.AlbumId) AS Albums
FROM artists ar
LEFT JOIN albums al ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId
ORDER BY Albums ASC;
```

### 3. RIGHT JOIN - keep all right rows

The mirror image of `LEFT JOIN`. Every row from the right table is kept.

```sql
SELECT ar.Name AS Artist, COUNT(al.AlbumId) AS Albums
FROM albums al
RIGHT JOIN artists ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId
ORDER BY Albums ASC;
```

### 4. FULL OUTER JOIN - keep everything

Returns all rows from both tables; unmatched columns on either side become `NULL`.

```sql
SELECT ar.Name AS Artist, al.Title AS Album
FROM artists ar
FULL OUTER JOIN albums al ON al.ArtistId = ar.ArtistId;
```

### 5. CROSS JOIN - every combination

Produces the **Cartesian product**: every left row paired with every right row. No
`ON` clause. Rows returned = `rows_left × rows_right`.

```sql
SELECT m.Name AS Media, g.Name AS Genre
FROM media_types m
CROSS JOIN genres g;
```

### 6. SELF JOIN - a table joined to itself

Join a table to another copy of itself using aliases. In Chinook, employees report
to other employees via `ReportsTo`.

```sql
SELECT e.FirstName || ' ' || e.LastName AS Employee,
       m.FirstName || ' ' || m.LastName AS Manager
FROM employees e
LEFT JOIN employees m ON m.EmployeeId = e.ReportsTo;
```

## Multi-table joins

Joins chain. To connect a **sale** to its **artist**, walk four tables:

```sql
SELECT ii.InvoiceLineId, t.Name AS Track, al.Title AS Album, ar.Name AS Artist
FROM invoice_items ii
JOIN tracks  t  ON t.TrackId   = ii.TrackId
JOIN albums  al ON al.AlbumId  = t.AlbumId
JOIN artists ar ON ar.ArtistId = al.ArtistId;
```

## Notes

- Prefer explicit `JOIN ... ON` over the old comma-join (`FROM a, b WHERE ...`);
  it's clearer and separates join logic from filtering.
- Always qualify columns with table aliases (`t.Name`, `al.Title`) once more than
  one table is involved, to avoid ambiguity.
- A `LEFT JOIN` with `WHERE right.key IS NULL` is the standard trick to find
  "rows with no match" (orphans).
- Forgetting the `ON` condition turns a join into an accidental `CROSS JOIN`.

## References

- SQLite Join (overview): <https://www.sqlitetutorial.net/sqlite-join/>
- Inner Join: <https://www.sqlitetutorial.net/sqlite-inner-join/>
- Left Join: <https://www.sqlitetutorial.net/sqlite-left-join/>
- Right Join: <https://www.sqlitetutorial.net/sqlite-right-join/>
- Full Outer Join: <https://www.sqlitetutorial.net/sqlite-full-outer-join/>
- Cross Join: <https://www.sqlitetutorial.net/sqlite-cross-join/>
- Self-Join: <https://www.sqlitetutorial.net/sqlite-self-join/>
