# Ordering Data (`ORDER BY`)

`ORDER BY` sorts the result set. By default it sorts **ascending** (`ASC`); use
`DESC` for descending. It runs near the end of a query - after `WHERE` and
`GROUP BY`, before `LIMIT`. 

## Syntax

```sql
SELECT columns
FROM table
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
```

## Examples

**1. Ascending (default) - track names A→Z**
```sql
SELECT Name
FROM tracks
ORDER BY Name ASC;
```

**2. Descending - longest tracks first**
```sql
SELECT Name, Milliseconds
FROM tracks
ORDER BY Milliseconds DESC;
```
Top result: "Occupation / Precipice" (5,286,953 ms - a ~88 minute audiobook-style
track).

**3. Multiple columns - country, then city**
```sql
SELECT FirstName, LastName, Country, City
FROM customers
ORDER BY Country ASC, City ASC;
```
Rows are sorted by `Country`; ties are broken by `City`.

**4. Order by an expression / alias - by seconds**
```sql
SELECT Name, Milliseconds / 1000 AS Seconds
FROM tracks
ORDER BY Seconds DESC;
```

**5. Order by column position** (2 = the second selected column, `LastName`)
```sql
SELECT FirstName, LastName
FROM customers
ORDER BY 2 ASC;
```

**6. Control NULL placement - `NULLS LAST`**
```sql
SELECT Name, Composer
FROM tracks
ORDER BY Composer NULLS LAST;
```
By default SQLite sorts `NULL`s **first** in ascending order; `NULLS LAST`
pushes the 977 composer-less tracks to the end.

## Notes

- `ORDER BY` is the **only** reliable way to guarantee row order - without it,
  the order a database returns rows is not guaranteed.
- You can mix directions per column: `ORDER BY Country ASC, Total DESC`.
- Sorting text is case- and collation-sensitive; SQLite's default `BINARY`
  collation sorts uppercase letters before lowercase.

## References

- SQLite `ORDER BY`: <https://www.sqlitetutorial.net/sqlite-order-by/>
- SQLite `SELECT`: <https://www.sqlitetutorial.net/sqlite-select/>
