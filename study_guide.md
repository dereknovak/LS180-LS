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

### SELECT

- "This is a keyword that identifies the type of statement being issued."

### *

- "This is a wild card character that acts as an identifier for all of the columns in a given table."

### FROM

- "It is used as a clause within a `SELECT` statement to identify the table from which to retrieve the data.

### WHERE

- Logical operators `OR` `AND` `NOT`

- For operators, all are the same for Ruby *except* `=`, which is used as `equal to?`

- Cannot use `= NULL`, must use `IS NULL` or `IS NOT NULL`

- LIKE is used to match against a part of a string. `ILIKE` is similar to `/regex/i`

    - `SIMILAR TO` actually matches against regex


### ORDER BY

- ASC/DESC

# Notes to Organize:

- `varchar()` is used when a string limitation is set. `char()` is used when the strings are all the same length

- You can escape a `'` using a second `'`. `'O'Leary'` would become `'O''Leary'`.
