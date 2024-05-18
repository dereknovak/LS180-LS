## Relational Database
https://launchschool.com/books/sql/read/introduction

- "A relational database is a database organized according to the relational model of data. In simple terms, the relational model defines a set of relations (which we can think of as analogous to tables) and describes the relationships, or connections, between them in order to determine how the data stored in them can interact."

## RDBMS

- "A relational database management system, or RDBMS, is essentially a software application, or system, for managing relational databases. An RDBMS allows a user, or another application, to interact with a database by issuing commands using syntax that conforms to a certain set of conventions or standards."

- SQLite
- MS SQL
- PostgreSQL
- MySQL

## SQL

- "SQL, which stands for Structured Query Language, is the programming language used to communicate with a relational database."

- "SQL is a **declarative** language; when you write a SQL statement you describe what needs to be done, but not exactly how to do it"

## SQL Sub-languages
https://launchschool.com/books/sql/read/preparations

- DDL: Data Definition Language: "Used to define the structure of a database and the tables and columns within it."
- DML: Data Manipulation Language: "Used to retrieve or modify data stored in a database. `SELECT` queries are part of DML."
- DCL: Data Control Language: "Used to determine what various users are allowed to do when interacting with a database."

# Query Commands

## SELECT

- "This is a keyword that identifies the type of statement being issued."

- Functions (string, data/time, aggregate)

### *

- "This is a wild card character that acts as an identifier for all of the columns in a given table."

## FROM

- "It is used as a clause within a `SELECT` statement to identify the table from which to retrieve the data.

## WHERE

- Logical operators `OR` `AND` `NOT`

- For operators, all are the same for Ruby *except* `=`, which is used as `equal to?`

- Cannot use `= NULL`, must use `IS NULL` or `IS NOT NULL`

- LIKE is used to match against a part of a string. `ILIKE` is similar to `/regex/i`

    - `SIMILAR TO` actually matches against regex


## ORDER BY

- ASC/DESC

## GROUP BY

- "excelent article" https://medium.com/@iandaustin/grokking-group-by-bd0bfd7082ea
- Displays all results relevant to what is being grouped

# Updating and Delete Data
https://launchschool.com/books/sql/read/update_and_delete_data

- Updates cannot be undone, so it's important to ensure you are updating/deleting the correct information.

- It's good practice to use `SELECT` first to verify you are targetting the correct information.

## UPDATE

```sql
UPDATE table_name
SET column = 'value'
WHERE condition;
```

- Can be used to 'delete' a single value within a row, as `DELETE` can only remove the entire row.
    - This is achieved using `NULL`, and you can set the `column = NULL`, unlike the `WHERE` clause.

## DELETE FROM

```sql
DELETE FROM table_name
WHERE condition;
```

# Table Relationships
https://launchschool.com/books/sql/read/table_relationships

### Normalization:

- "The reason for normalization is to reduce data redundancy and improve data integrity"
- "The mechanism for carrying out normalization is arranging data in multiple tables and defining relationships between them"

# Notes to Organize:

- `varchar()` is used when a string limitation is set. `char()` is used when the strings are all the same length

- You can escape a `'` using a second `'`. `'O'Leary'` would become `'O''Leary'`.
