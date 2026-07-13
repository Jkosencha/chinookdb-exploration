# Database Keys

**Plain idea:** a key is a column (or a few columns together) used to identify a
row and to link tables to each other. Keys are what make tables relate.

## The main types

| Key | What it is |
|-----|------------|
| **Primary key** | The column that uniquely identifies each row in a table. Must be unique and never blank. |
| **Foreign key** | A column that points to another table's primary key. This is what creates the link between two tables. |
| **Composite key** | A key made of two or more columns combined, unique only as a pair. |
| **Surrogate key** | An auto made ID number with no real world meaning (like an auto increment integer). |
| **Natural key** | A key that already exists in real life, like an email or a phone number. |
| **Candidate key** | Any column that could serve as the primary key. |
| **Alternate key** | A candidate key that was not chosen as the primary key. |

## Keys used in our database

**Primary keys (one per table):**
Each table has its own ID column as the primary key, for example `ArtistId`,
`AlbumId`, `TrackId`, `CustomerId`, `InvoiceId`, `EmployeeId`. These are surrogate
keys (auto made integers).

**Composite key:**
The `playlist_track` table has no single ID. Its primary key is the pair
`(PlaylistId, TrackId)` together, since one playlist holds many tracks and one
track can sit in many playlists.

**Foreign keys (the links):**

| Column | Points to |
|--------|-----------|
| `albums.ArtistId` | `artists.ArtistId` |
| `tracks.AlbumId` | `albums.AlbumId` |
| `tracks.GenreId` | `genres.GenreId` |
| `invoices.CustomerId` | `customers.CustomerId` |
| `invoice_items.InvoiceId` | `invoices.InvoiceId` |
| `invoice_items.TrackId` | `tracks.TrackId` |
| `customers.SupportRepId` | `employees.EmployeeId` |
| `employees.ReportsTo` | `employees.EmployeeId` (points to its own table) |

`employees.ReportsTo` is special: it points back to the same table to show who
reports to whom.

## simpler explanation

> A primary key names each row. A foreign key points to another table's primary
> key, and that pointer is the relationship.

## References

- Database Star, Database Keys Guide: https://www.databasestar.com/database-keys/
- SQLite Primary Key: https://www.sqlitetutorial.net/sqlite-primary-key/
- SQLite Foreign Key: https://www.sqlitetutorial.net/sqlite-foreign-key/