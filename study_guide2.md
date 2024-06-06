# LS180 'Database Foundations' Study Guide

## Navigation

- [General Terminology](#general-terminology)
    - [SQL](#sql-structured-query-language)
    - [Relational Database](#relational-database)
    - [RDBMS](#rdbms)
- [SQL Sub-Languages](#sql-sublanguages)
    - [DDL](#ddl-data-definition-language)
    - [DML](#dml-data-management-language)
    - [DCL](#dcl-data-control-language)
- [DDL Statements](#ddl-statements)
    - [CREATE](#create)
    - [ALTER](#alter)
    - [DROP](#drop)
- [DML Statements](#dml-statements)
    - [SELECT](#select)
    - [INSERT](#insert)
    - [UPDATE](#update)
    - [DELETE](#delete)
- [Additional Statements](#additional-statements)
    - [GROUP BY](#group-by)
    - [ORDER BY](#order-by)
    - [WHERE](#where)
    - [HAVING](#having)
- [Columns](#columns)
- [Constraints](#constraints)
    - [Adding](#adding-constraints)
    - [Removing](#removing-constraints)
- [JOIN Statements](#join-statements)
    - [INNER JOIN](#inner-join)
    - [LEFT JOIN](#left-outer-join)
    - [RIGHT JOIN](#right-outer-join)
    - [FULL JOIN](#full-outer-join)
    - [CROSS JOIN](#cross-join)
- [Subqueries]


# General Terminology

## SQL (Structured Query Language)
https://launchschool.com/lessons/a1779fd2/assignments/7673d9a9

- **SQL** (Structured Query Language) is a *declarative* programming language that is used to communicate with a relational database. This means that the statements written describe which actions need to be completed, as opposed to how those actions are performed. SQL can also be described as a *special purpose language*, as its role is typically only used to interact with a relational database.

## Relational Database
https://launchschool.com/books/sql/read/introduction
https://launchschool.com/lessons/5ae760fa/assignments/074f64a8

- A **relational database** is one that defines a series of relations (generally tables) and outlines the relationships between, allow the relations to interact.

## RDBMS ******

- An **RDBMS** (Relational Database Management System) is an application used for managing relational databases by using SQL statements and queries to access or change information and schema within a database. Examples of RDBMSs include MySQL, PostgreSQL, MS SQL, and SQLite.

# SQL Sublanguages

## DDL (Data Definition Language)

- The **DDL** (Data Defintion Language) is a SQL sublanguage used to define the *structure* of a database, including its tables, columns, and the database itself.

### Examples

- `CREATE`
- `ALTER`
- `DROP`

## DML (Data Management Language)

- The **DML** (Data Management Language) is a SQL sublanguage used to retrieve or modify the *data* that is stored within a database.

### Examples

- `SELECT`
- `INSERT`
- `UPDATE`
- `DELETE`

## DCL (Data Control Language)

- The **DCL** (Data Control Language) is a SQL sublanguage used to manage the *permissions* of a database, allowing or restricting functionality to users.

### Examples

- `GRANT`
- `REVOKE`

# DDL Statements

## CREATE

- The `CREATE` statement is used to create structures within a database, including various tables or the database itself.

```sql
CREATE DATABASE database_name;

CREATE TABLE (
  column_name type [constraints],
  column2_name type [constraints],
  --...
);
```

## ALTER

- The `ALTER` statement is used to alter various aspects of a relation's schema.

```sql
ALTER TABLE table_name
RENAME TABLE table_name TO new_table_name;

ALTER TABLE table_name
ALTER COLUMN column_name
  SET NOT NULL;

ALTER TABLE table_name
  ADD CONSTRAINT constraint_name
      CHECK (condition);
```

## DROP

- The `DROP` statement is used to permanently remove a structure from a database, including the database itself.

```sql
DROP DATABASE database_name;

DROP TABLE table_name;

ALTER TABLE table_name
 DROP COLUMN column_name;
```


# DML Statements

## SELECT

- The `SELECT` statement is used to retrieve data from a database.
- The `DISTINCT` statement can append it to prevent repetitive returns.
- The `SELECT` statement can be used in conjuction with `FROM` to retrieve information from a specific relation, or be left alone to return independent data.

```sql
SELECT column_name FROM table_name;

SELECT DISTINCT column_name FROM table_name;

SELECT 3 * 4;
```

## INSERT

- The `INSERT` statement is used to insert data into a relation.
- When used without specified column names, all columns will be used. Because of this, any default values must be dicated with `DEFAULT`.

```sql
INSERT INTO table_name (column1_name, column2_name, ...)
VALUES ('value1', 'value2'),
       ('value3', 'value4');

INSERT INTO table_name
VALUES (DEFAULT, 'value1', 'value2'),
       (DEFAULT, 'value3', 'value4');
```

## UPDATE
https://launchschool.com/books/sql/read/update_and_delete_data

- The `UPDATE` statement is used to permanently alter data that exists within a relation.
- Generally, it's good practice to run a query with `SELECT` before updating the data, as this change is permanent.

```sql
UPDATE table_name
   SET column_name = 'value'
 WHERE condition;
```

## DELETE

- The `DELETE` statement is used to permanently remove rows that exist within a relation.
- Generally, it's good practice to run a query with `SELECT` before deleting the data, as this change is permanent.

```sql
DELETE FROM table_name
 WHERE condition;
```

# Additional Statements

## GROUP BY
https://launchschool.com/books/sql/read/more_on_select#groupby
https://medium.com/@iandaustin/grokking-group-by-bd0bfd7082ea

- The `GROUP BY` statement is used to group data in conjuction with an aggregate function.

```sql
SELECT column_name, function(column2_name)
  FROM table_name
 GROUP BY column_name;
```

## ORDER BY

- The `ORDER BY` statement provides instructions on how data within the returned table should be ordered. The statement defaults to an ascending order, but can be modified by including `DESC`.
- If multiple rows share the same value, a second column name can be included to further organize the returned table, initially organizing by the first column, then by the second.

```sql
SELECT column_name FROM table_name
ORDER BY id DESC;

SELECT column_name FROM table_name
ORDER BY id DESC, column_name;
```

## WHERE

- The `WHERE` statement uses a conditional statement to identify which data of a relation should be modified.

```sql
SELECT column_name FROM table_name
 WHERE column_name = 'value';

UPDATE table_name
   SET column_name = 'value1'
 WHERE id = 1;
```

## HAVING

- **********************

# Columns

## New Column

```sql
ALTER TABLE
  ADD COLUMN column_name type [constraints...];
```

## Change Data Type

```sql
ALTER TABLE table_name
ALTER COLUMN column_name
 TYPE new_type;
```

# Constraints

## Adding Constraints

### `UNIQUE` / `NOT NULL` / `DEFAULT`

```sql
ALTER TABLE table_name
ALTER COLUMN column_name
  SET NOT NULL;
```

### Others

- `CONSTRAINT` and `constraint_name` are optional; if not included, the RDBMS will create a name for it, typically consisting of the table and column names involved.

```sql
ALTER TABLE table_name
  ADD CONSTRAINT constraint_name
CHECK (condition);
```

## Removing Constraints

```sql
ALTER TABLE table_name
ALTER COLUMN column_name
 DROP DEFAULT;

ALTER TABLE table_name
 DROP CONSTRAINT constraint_name;
```

# JOIN Statements
https://launchschool.com/books/sql/read/joins

- A `JOIN` statement creates a *transient table* by combining two separate relations connected through a foreign key.

## INNER JOIN

- An `INNER JOIN` statement creates a transient table between two relations that includes only the rows where a definite match is made between the two columns used in the `ON` conditional statement.

- Because the `INNER JOIN` is the most common method of joining relations, it can be aliased by simply using `JOIN`.

```sql
SELECT books.title, authors.name
  FROM books
 INNER JOIN authors
         ON books.author_id = authors.id;

/*
       title        |     name      
--------------------+---------------
 Harry Potter       | J.K. Rowling
 Project: Hail Mary | Andy Weir
 The Martian        | Andy Weir
 Dune               | Frank Herbert
(4 rows)
*/
```

## LEFT OUTER JOIN

- A `LEFT OUTER JOIN`, or `LEFT JOIN`, statement creates a transient table between two relations that includes *all* rows from the left -- first included -- relation, and all matching data from the right -- second included -- relation. If no relationship has been established to the right relation, `NULL` will be used to represent the missing value.

```sql
SELECT books.title, authors.name
  FROM books
  LEFT OUTER JOIN authors
          ON books.author_id = authors.id;

/*
       title        |     name      
--------------------+---------------
 Harry Potter       | J.K. Rowling
 Project: Hail Mary | Andy Weir
 The Martian        | Andy Weir
 Dune               | Frank Herbert
 Bible              | 
(5 rows)
*/
```

## RIGHT OUTER JOIN

- A `RIGHT OUTER JOIN`, or `RIGHT JOIN`, statement creates a transient table between two relations that includes *all* rows from the right -- second included -- relation, and all matching data from the left -- first included -- relation. If no relationship has been established to the left relation, `NULL` will be used to represent the missing value.

```sql
SELECT books.title, authors.name
  FROM books
 RIGHT OUTER JOIN authors
          ON books.author_id = authors.id;

/*
       title        |     name      
--------------------+---------------
 Harry Potter       | J.K. Rowling
 Project: Hail Mary | Andy Weir
 The Martian        | Andy Weir
 Dune               | Frank Herbert
                    | Stephen King
(5 rows)
*/
```

## FULL OUTER JOIN

- A `FULL OUTER JOIN`, or `FULL JOIN`, statement creates a transient table between two relations that includes *all* rows from *both* relations, matching data based upon the columns used in the `ON` conditional statement. If no relationship has been established to either relation, `NULL` will be used to represent the missing value.

```sql
SELECT books.title, authors.name
  FROM books
  FULL OUTER JOIN authors
          ON books.author_id = authors.id;

/*
       title        |     name      
--------------------+---------------
 Harry Potter       | J.K. Rowling
 Project: Hail Mary | Andy Weir
 The Martian        | Andy Weir
 Dune               | Frank Herbert
 Bible              | 
                    | Stephen King
(6 rows)
*/
```

## CROSS JOIN

- A `CROSS JOIN` statement creates a transient table between two relations that includes *all possible relationships* between them. While uncommon, `CROSS JOIN`s are most useful when trying to discover every possible combinationof data, so anything that requires any kind of mixing will be relevant. This can include ingredients for a recipe or clothes for an outfit.

```sql
SELECT books.title, authors.name
  FROM books
 CROSS JOIN authors;

/*
       title        |     name      
--------------------+---------------
 Harry Potter       | J.K. Rowling
 Project: Hail Mary | J.K. Rowling
 The Martian        | J.K. Rowling
 Dune               | J.K. Rowling
 Bible              | J.K. Rowling
 Harry Potter       | Andy Weir
 Project: Hail Mary | Andy Weir
 ...
(20 rows)
*/
```

# Subqueries










