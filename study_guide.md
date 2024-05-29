# LS180 'Database Foundations' Study Guide

## Relational Database
https://launchschool.com/books/sql/read/introduction
https://launchschool.com/lessons/5ae760fa/assignments/074f64a8

- "A relational database is a database organized according to the relational model of data. In simple terms, the relational model defines a set of relations (which we can think of as analogous to tables) and describes the relationships, or connections, between them in order to determine how the data stored in them can interact."

- "A **relation** is *usually* another way to say "table"."

## RDBMS

- "A relational database management system, or RDBMS, is essentially a software application, or system, for managing relational databases. An RDBMS allows a user, or another application, to interact with a database by issuing commands using syntax that conforms to a certain set of conventions or standards."

- SQLite
- MS SQL
- PostgreSQL
- MySQL

## SQL
https://launchschool.com/lessons/a1779fd2/assignments/7673d9a9

- "SQL, which stands for Structured Query Language, is the programming language used to communicate with a relational database."
- "SQL is a **declarative** language; when you write a SQL statement you describe what needs to be done, but not exactly how to do it"
- "SQL is a language used to manipulate the structure and values of datasets stored in a relational database."
- "It is described as a **special purpose language** because it is typically used only for a very specific purpose: interacting with relational databases."



## SQL Sub-languages
https://launchschool.com/books/sql/read/preparations

- DDL: Data Definition Language: "Used to define the structure of a database and the tables and columns within it."
    - `CREATE`, `DROP`, `ALTER`
- DML: Data Manipulation Language: "Used to retrieve or modify data stored in a database. `SELECT` queries are part of DML."
    - `SELECT`, `INSERT`, `UPDATE`, `DELETE`
- DCL: Data Control Language: "Used to determine what various users are allowed to do when interacting with a database."
    - `GRANT`, `REVOKE`

# Statements

- SQL is made up of **statements**, which is terminated by a semicolon.

- "**Expressions** in SQL can make use of operators and functions."

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

# Insert Data into a Table

## INSERT INTO

```sql
INSERT INTO table_name
    (column_1, column_2 ...)
  VALUES
    ('value 1', 'value 2' ...);
```

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

### Entity Relationship Diagram (ERD)

- "An ERD is a graphical representation of entities and their relationships to each other, and is a commonly used tool within database design."

## Keys

### Primary Keys

- "A Primary Key is a unique identifier for a row of data."

```sql
ALTER TABLE table_name
ADD PRIMARY KEY (column);
```

- It's good practice to use `id` as the Primary Key.

### Foreign Keys
https://launchschool.com/lessons/5ae760fa/assignments/bb4f3ba2

- "A Foreign Key allows us to associate a row in one table to a row in another table."

- Add while creating table:

```sql
CREATE TABLE table_name (
  id serial PRIMARY KEY,
  other_table_id int REFERENCES other_table (id)
);
```

- Add after creating table:

```sql
ALTER TABLE table_name
ADD CONSTRAINT table_column_id_fkey
FOREIGN KEY (fk_column_name)
REFERENCES target_table_name (pk_column_name);
```

- Used to create connections between 2 tables

### Referential Integrity

- "Referential integrity is the assurance that a column value within a record must reference an existing value; if it doesn't then an error is thrown."

### Natural Key
https://launchschool.com/lessons/a1779fd2/assignments/00e428da

- "A natural key is an existing value in a dataset that can be used to uniquely identify each row of data in that dataset."

- The value, while 'unique', maybe change hands, such as a phone number or email address.

### Surrogate Keys

- "A surrogate key is a value that is created solely for the purpose of identifying a row of data in a database table."

### Sequence

- "A sequence is a special kind of relation that generates a series of numbers."

```sql
CREATE SEQUENCE name_seq

-- PRIMARY KEY
CREATE SEQUENCE example_id_seq
CREATE TABLE example
       id integer NOT NULL DEFAULT nextval('example_id_seq'),
       name varchar(25)
```

## Relationships

### One-to-One

- "A one-to-one relationship between two entities exists when a particular entity instance exists in one table, and it can have only one associated entity instance in another table."

- A user can *only* have one address, and that address can belong to *only* one address.

- `ON DELETE` will perform some kind of action when the row being referenced is deleted.
    - `ON DELETE CASCADE` will also delete the specific row.

### One-to-Many

- "A one-to-many relationship exists between two entities if an entity instance in one of the tables can be associated with multiple records (entity instances) in the other table. The opposite relationship does not exist; that is, each entity instance in the second table can only be associated with one entity instance in the first table."

- A review belongs to only one book, but a book can have many reviews.

- An **update anomoly** would occur if one piece of data, such as a customer's phone number, would need to be changed for *every* entry for that customer in a table.

- An  **insertion anomoly** would occur if a piece of data, such as a customer's phone number, could not be added unless an order has been placed for them.

- A **deletion anomoly** would occur if all pieces of data, such as a customer's phone number, is lost because orders from them were deleted.

### Many-to-Many

- "A many-to-many relationship exists between two entities if for one entity instance there may be multiple records in the other table, and vice versa."

- A user can check out many books, and a book can be checked out by many users.

# SQL Joins
https://launchschool.com/books/sql/read/joins

- "`JOIN`s are clauses in SQL statements that link two tables together, usually based on the keys that define the relationship between those two tables."

## Syntax

```sql
SELECT table_nameN.column_name, ...
    FROM table_name1
    join_type JOIN table_name2
        ON join_condition;
```

Necessary info:

- The name of the table to join
- The type of join to use
- The name of the second table to join
- The join condition

## Types of Joins

### INNER JOIN

- "An INNER JOIN returns a result set that contains the common elements of the tables, i.e the intersection where they match on the joined condition."

### LEFT JOIN (Outer)

- "A LEFT JOIN or a LEFT OUTER JOIN takes all the rows from one table, defined as the LEFT table, and joins it with a second table."

### RIGHT JOIN

- "A RIGHT JOIN is similar to a LEFT JOIN except that the roles between the two tables are reversed, and all the rows on the second table are included along with any matching rows from the first table."

### FULL JOIN

- "A FULL JOIN or FULL OUTER JOIN is essentially a combination of LEFT JOIN and RIGHT JOIN. This type of join contains all of the rows from both of the tables."

### CROSS JOIN

- "A CROSS JOIN, also known as a Cartesian JOIN, returns all rows from one table crossed with every row from the second table."

- This essentially displayed a *cross product* of a set. (PEMDAS)

## Multiple Joins

- Each JOIN creates a *transient table* that is a collection of all the tables columns. If there are multiple joins, a new transient table is created from the previous table

```sql
SELECT table1.column, table2.column, table3.column
      FROM table1
      INNER JOIN table2
          ON table1.id = table2.t1_id   -- Transient Table is created (table1 + table2)
      INNER JOIN table3
          ON table3.id = table2.t2_id  -- Transient Table is created (Transient + table3)
```

## Aliasing

- "Aliasing allows us to specify another name for a column or table and then use that name in later parts of a query to allow for more concise syntax."

```sql
SELECT u.full_name, b.title, c.checkout_date
      FROM users AS u            -- users => u
      INNER JOIN checkouts AS c  -- checkout => c
          ON u.id = c.user_id
      INNER JOIN books AS b      -- books => b
          ON b.id = c.book_id;
```

- Can also be used to provided context about a query.

```sql
SELECT count(id) AS "Number of Books Checked Out"
      FROM checkouts

/*
Number of Books Checked Out
----------------------------
                         4
(1 row)
*/
```

## Subqueries

- "Imagine executing a SELECT query, and then using the results of that SELECT query as a condition in another SELECT query. This is called nesting, and the query that is nested is referred to as a subquery."

# Levels of Schema (Abstraction)

## Conceptual

- "High-level design focused on identifying entities and their relationships"

- Concerned mostly with bigger objects and higher level concepts
- Cellphone
    - Contact
        - Multiple phone numbers?
    - Phone calls

- Entity-relationship model

## Logical

- Combination between the 2
- SQL standards
- Not as common to work with

## Physical

- "Low-level database-specific design focused on implementation."

- Concerned mostly with database specific implementation of the conceptual model
- Datatypes, rules on how things relate to each other

# Cardinality & Modality
https://launchschool.com/lessons/5ae760fa/assignments/46053e3b

### Cardinality

- "The number of objects on each side of the relationship."

- Uses *Crow's Foot* notation.

### Modality

- "If the relationship is required (1) or optional (0)."

### one - optional

--|-O-----

### one - required

--|-|-----

### many - optional

3---O-----

### many - required

3---|-----




# Notes to Organize:

- `varchar()` is used when a string limitation is set. `char()` is used when the strings are all the same length
- You can escape a `'` using a second `'`. `'O'Leary'` would become `'O''Leary'`.
- `||` is used to concatenate strings
- When dealing with `NULL`, always use `IS NULL` or `IS NOT NULL`


```sql
SELECT trunc((4 * pi() * power(26.3,2)))
```

# Functions to Learn

- string_agg()
- avg
- round



# Study Guide

STUDY GUIDE

## **SQL**

- Identify the different types of `JOIN`s and explain their differences.
    
- Name and define the three sublanguages of SQL and be able to classify different statements by sublanguage.

    
- Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.
            
- Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.
- Understand how to create and remove constraints, including `CHECK` constraints
- Be familiar with using subqueries
    
    

## **PostgreSQL**

- Describe what a sequence is and what they are used for.
    
- Create an auto-incrementing column.
- Define a default value for a column.
    
    
- Be able to describe what primary, foreign, natural, and surrogate keys are.


## **Database Diagrams**

- Talk about the different levels of schema.
- Define cardinality and modality.
    
- Be able to draw database diagrams using crow's foot notation.
*/

SPOT with Amy

- Assessment straight forward

https://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins

https://code.likeagirl.io/sqls-order-of-execution-f64d639ce4ec

https://medium.com/@iandaustin/grokking-group-by-bd0bfd7082ea

