# Database Keys

A **key** is one or more columns whose values are used to identify rows and to
link tables together. Keys are what make a relational database "relational" - they
enforce uniqueness and **referential integrity**.

## Types of keys

| Key | What it is |
|-----|------------|
| **Super key** | Any set of columns that uniquely identifies a row - even if it includes extra, unnecessary columns. |
| **Candidate key** | A *minimal* super key: unique with no redundant column. A table can have several. |
| **Primary key (PK)** | The one candidate key chosen as the table's main identifier. Must be **unique** and **NOT NULL**. |
| **Alternate key** | A candidate key that was *not* chosen as the primary key (a.k.a. secondary key). |
| **Unique key** | A column/set constrained to be unique. Unlike a PK it may allow a single `NULL`. |
| **Composite (compound) key** | A key made of **two or more columns** combined to be unique. |
| **Foreign key (FK)** | A column that references the primary key of another table, creating the relationship between them. May be `NULL` and may repeat. |
| **Natural key** | A key from real-world data that already has business meaning (e.g. an email or ISBN). |
| **Surrogate key** | An artificial, system-generated identifier (usually an auto-increment integer) with no business meaning. |

Relationship between the "unique-identifier" keys: **every candidate key is a super
key, but not every super key is a candidate key**, and the **primary key is the
candidate key you pick** - the rest become alternate keys.

## Keys found in the Chinook database

Chinook is a textbook example of using **surrogate primary keys**: nearly every
table has an auto-incrementing integer `...Id` column as its PK.

### Primary keys (all surrogate integers)

| Table | Primary key |
|-------|-------------|
| `artists` | `ArtistId` |
| `albums` | `AlbumId` |
| `tracks` | `TrackId` |
| `genres` | `GenreId` |
| `media_types` | `MediaTypeId` |
| `playlists` | `PlaylistId` |
| `invoices` | `InvoiceId` |
| `invoice_items` | `InvoiceLineId` |
| `customers` | `CustomerId` |
| `employees` | `EmployeeId` |

Each is declared like:

```sql
[AlbumId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
```

`INTEGER PRIMARY KEY AUTOINCREMENT` = a **surrogate key** the database generates
automatically.

### Composite primary key

The bridge table `playlist_track` has **no surrogate id**. Its primary key is the
**combination** of both columns:

```sql
CONSTRAINT [PK_PlaylistTrack] PRIMARY KEY ([PlaylistId], [TrackId])
```

This is a **composite key**: one `PlaylistId` can appear many times and one
`TrackId` can appear many times, but the *pair* is unique — which is exactly how a
many-to-many relationship is modeled.

### Foreign keys

Foreign keys wire the tables together. The main ones:

| Table.Column | References |
|--------------|------------|
| `albums.ArtistId` | `artists.ArtistId` |
| `tracks.AlbumId` | `albums.AlbumId` |
| `tracks.GenreId` | `genres.GenreId` |
| `tracks.MediaTypeId` | `media_types.MediaTypeId` |
| `invoices.CustomerId` | `customers.CustomerId` |
| `invoice_items.InvoiceId` | `invoices.InvoiceId` |
| `invoice_items.TrackId` | `tracks.TrackId` |
| `playlist_track.PlaylistId` | `playlists.PlaylistId` |
| `playlist_track.TrackId` | `tracks.TrackId` |
| `customers.SupportRepId` | `employees.EmployeeId` |
| `employees.ReportsTo` | `employees.EmployeeId` *(self-referencing)* |

`employees.ReportsTo` is a **self-referencing foreign key** — it points back to the
same table's primary key to model the "who reports to whom" hierarchy.

### Candidate / alternate / natural keys in Chinook

Chinook does **not declare** extra `UNIQUE` constraints, but conceptually some
columns are **natural candidate keys** that could serve as alternate keys, e.g.
`customers.Email` and `employees.Email` (real-world unique identifiers). The
designers chose surrogate integer PKs instead, which is the usual best practice
because surrogate keys never change even if the underlying business data does.

## Why surrogate keys here?

- Stable: a `CustomerId` never changes even if the customer's email or name does.
- Simple joins: FKs are single small integers instead of long composite natural keys.
- Consistent pattern across all tables (`TableId`).

## References

- Database Star — *Database Keys: The Complete Guide*: <https://www.databasestar.com/database-keys/>
- SQLite Primary Key: <https://www.sqlitetutorial.net/sqlite-primary-key/>
- SQLite Foreign Key: <https://www.sqlitetutorial.net/sqlite-foreign-key/>
