# chinookdb-exploration

The Chinook database models a **digital media store** (like an iTunes-era music
shop): artists release albums, albums contain tracks, customers buy tracks on
invoices, and employees act as sales-support reps. It has **11 tables** and is a
great playground for practicing SQL.

- Sample database source: <https://www.sqlitetutorial.net/sqlite-sample-database/>
- ER diagram (color): <https://www.sqlitetutorial.net/wp-content/uploads/2015/11/sqlite-sample-database-color.jpg>

## Repository contents

| File | What's inside |
|------|----------------|
| [`schema-and-relationships.md`](schema-and-relationships.md) | The 11 tables and how they connect (1-to-many, many-to-many, self-referencing) |
| [`database-keys.md`](database-keys.md) | Types of database keys and the keys used in Chinook |
| [`filtering.md`](filtering.md) / [`filtering.sql`](filtering.sql) | `WHERE`, comparisons, `AND`/`OR`, `IN`, `BETWEEN`, `LIKE`, `IS NULL` |
| [`ordering.md`](ordering.md) / [`ordering.sql`](ordering.sql) | `ORDER BY`, `ASC`/`DESC`, multiple columns, expressions, `NULLS LAST` |
| [`limiting.md`](limiting.md) / [`limiting.sql`](limiting.sql) | `LIMIT`, `LIMIT ... OFFSET`, top-N and pagination |
| [`grouping.md`](grouping.md) / [`grouping.sql`](grouping.sql) | `GROUP BY`, aggregates (`COUNT`/`SUM`/`AVG`/`MIN`/`MAX`), `HAVING` |
| [`sql-joins.md`](sql-joins.md) / [`sql-joins.sql`](sql-joins.sql) | `INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `CROSS`, and self joins |
| `chinook.db` | The SQLite database file (11 tables) |

## The database

```bash
sqlite3 chinook.db
sqlite> .tables
albums          employees       invoices        playlists
artists         genres          media_types     tracks
customers       invoice_items   playlist_track
sqlite> .quit
```

## Running the query files

```bash
# run all queries in a concept file
sqlite3 chinook.db < filtering.sql

# or interactively
sqlite3 chinook.db
sqlite> .read grouping.sql
```


## Row counts (quick sanity check)

| Table | Rows | | Table | Rows |
|-------|-----:|-|-------|-----:|
| artists | 275 | | invoices | 412 |
| albums | 347 | | invoice_items | 2,240 |
| tracks | 3,503 | | customers | 59 |
| genres | 25 | | employees | 8 |
| media_types | 5 | | playlists | 18 |
| | | | playlist_track | 8,715 |
