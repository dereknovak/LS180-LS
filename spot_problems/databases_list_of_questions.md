# 1

Consider the last line of the following code. Will the code result in an error if we attempt to insert NULL value to a student_id column? Why or why not?

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name text
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	student_id int FOREIGN KEY REFERENCES students (id)
);

INSERT INTO students (name) VALUES ('Johny'), ('Edd');
INSERT INTO classes (name, student_id) 
	VALUES ('Math', 1), ('Art', NULL), ('Geography', 1);
```

An error will not be thrown when attempting to insert `NULL` into the `student_id` column. Although `student_id` is a foreign key, this does not automatically apply a `NOT NULL` constraint. This is different from primary keys, which never allow `NULL` input.

# 2

Consider the code below. How are relations, tuples, attributes, and entities represented in the example below?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);

INSERT INTO teachers (name) VALUES ('Marry Bee');
INSERT INTO classes (name, teacher_id) VALUES ('Math', 1);
```

In this example, both the `teachers` and `classes` tables are considered relations that contain tuples, or rows, of data. An example of a tuple would be the teacher `'Marry Bee'` or the class `'Math'` with a `teacher_id` of `1`. The attributes for these relations are the columns that represent each value; a teacher's attributes would be their `name` and `id`, while a class's attributes would include the `name`, `id`, and `teacher_id`. This represents a physical level of schema.

Pulling back a bit, both `teachers` and `classes` represent entities that are connected at a conceptual level of schema.

# 3

Consider the code below. How is a relation represented on the code below? How is a relationship represented? 

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);
```

A relation is another name for a table, so both `teachers` and `classes` would represent the provided relations for this database. The relationship between the two relations is represented by the `teacher_id` foreign key, which creates a *one-to-many* relationship between them.

# 4

Considering the following code explain how do defining keys and constraints ensure data integrity?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teachers (id) 
		ON DELETE CASCADE
);
```

By defining constraints, only specific values can be added to the respective relation. In the case for both relations, neither `name` nor the `teacher_id` attributes have constraints that prevent poor data input. With `name`, the `text` data type allows for any length of character input and for `teacher_id`, the `int` data type allows for all integers, including negatives. Most importantly, all allow for `NULL`, which can create data integrity issues as the database grows.

In terms of keys, both primary keys on respective `id` attributes both prevent `NULL` values and enforces uniqueness, which will prevent incorrect data from being altered or removed in the future.

# 5

Explain how this SELECT query will be executed?

```sql
SELECT teachers.name, 
	FROM teachers
		JOIN classes
			ON teachers.id = classes.teacher_id
				GROUP BY teachers.name
					ORDER BY COUNT(classes.id);
```

The `SELECT` statement retrieves data from the provided table.

First, the `teachers` and `classes` relations will be joined to form a *transient table* between two relations that includes only the rows where a definite match is made between the two columns used in the `ON` conditional statement. The results from the new table are then grouped by `teachers.name`, which groups each class count by the name of the teacher. Lastly, by using the `COUNT` aggregate function, these results are ordered by the number of classes taught, listing from least to most.

# 6

Consider the code below: What are the different data types in this example. Describe each of them and describe the differences between them.

```sql
CREATE TABLE example (
	id serial PRIMARY KEY,
	title varchar(200) NOT NULL UNIQUE,
	name char(100), 
	age numeric NOT NULL
);
```

There are 4 types of data in this example:

1. `varchar(200)`, or Varying Character, allows for character input up to 200 characters in length.
2. `char(100)`, or Character, requires that all character input is 100 characters in length.
3. `numeric`, or Decimal, allows for any size, sign, or precision of a number.
4. `serial` is an integer value that uses a sequence to increment the value by 1 for each new entry.

# 7

Consider the code below: Will this code raise an error? Why or why not?

```sql
CREATE TABLE example(
	some_num numeric(10,2)
);

INSERT INTO example (some_num) VALUES (1);
```

This will *not* throw an error. Although `numeric(10,2)` represents a decimal number with a maximum of `10` digits and `2` decimal numbers, if an integer is inserted into the table, it will just be converted into the correct format. As such, `1` becomes `1.00`.

# 8

Consider the code below: Will this code raise an error? Why or why not?

```sql
CREATE TABLE example(
	some_num int,
	some_text text CHECK (some_text > 0)
);

INSERT INTO example (some_num)
	VALUES (11);
```

This example will throw an error, as the operator `>` does not exist for `text` data types.

A good question to ponder, what if line 3 was changed to:

```sql
  some_text text CHECK (LENGTH(some_text) > 0)
```

This, however, would not throw an error. Not including a value for `some_text` results in `NULL`, which is allowed despite the `CHECK` constraint verifying that its value has a length greater than `0`.

# 9

What will the following code return and why?

```sql
SELECT NULL IS NOT NULL;
```

This will return `false`. While you cannot evaluate an expression with `NULL` using standard conditional techniques -- `=`, `>`, etc -- you can check if a value is `NULL` by using `IS NULL` or `IS NOT NULL`. Here, `NULL` is, in fact, `NULL`, therefore the boolean `false` is returned.

# 10

Consider the code below. Will this code raise an error? Why or why not?

```sql
CREATE TABLE some_table (
	some_num decimal(10,4) DEFAULT 'some text'
	some_t_or_f boolean DEFAULT true
);
```

Aside from the missing `,` at the end of line 2, this example will throw an error due to the invalid data type of `'some text'` being used as a default value for `decimal(10, 4)`, which requires a number.

# 11

Consider the code below: What values will be inserted into the table?

```sql
CREATE TABLE some_table(
	some_num decimal(10,4),
	some_t_or_f boolean DEFAULT true
);

INSERT INTO some_table (some_num, some_t_or_f)
	VALUES (11, NULL);
```

The values `11.0000` and `true` will be inserted into the table. The first is because of the `decimal(10,4)` data type, which will round all inputted numbers to 4 decimal places. Secondly, although `some_t_or_f` has a default value of `true`, a `NOT NULL` constraint is not enforced; therefore, `NULL` can be directly inserted into the table.

# 12

Consider the following code. What does ON DELETE CASCADE do in this example?

```sql
CREATE TABLE teachers (
	id serial PRIMARY KEY,
	name text,
);

CREATE TABLE classes (
	id serial PRIMARY KEY,
	name text,
	teacher_id int REFERENCES teaachers (id) 
		ON DELETE CASCADE
);
```

The `ON DELETE CASCADE` statement provides instructions to delete delete all entries of the `teacher_id` if that specific teacher's `id` is deleted. In other words, in this foreign key relationship, if a row from the parent table is deleted, all related rows in the child table containing the foreign key should also be deleted.

# 13

Consider the following error message: When would PostgreSQL throw this error and why? Explain the information that this error message gives us.

```
ERROR:  duplicate key value violates unique constraint "unique_id"
DETAIL:  Key (id)=(1) already exists.
```

For this example, a `unique_id` constraint is in place that prevents duplicate values to exist within the `id` attribute of a relation. There seems to be data attempted to be inserted with an `id` value of `1`, which already exists within the relation.

# 14

Create a table teachers with a column called set_up_date and set it to text. Change the data type in that column to a date data type.

```sql
CREATE TABLE teachers (
  set_up_date text
);

ALTER TABLE teachers
ALTER COLUMN set_up_date
 TYPE date;
```

This example does not actually work, as an error is thrown:

```
ERROR: column "set_up_date" cannot be cast automatically to type date
```

It seems that a new column with the correct data type would need to be created, then all values get casted to it. This example shows the importance of establishing the correct data type from the beginning.

# 15 ********

Consider the table below: What indexes does this table have and what type of algorithms has been used for the indexing? Explain how they have been created:

```
my_books=# CREATE TABLE authors (
my_books(#   id serial PRIMARY KEY,
my_books(#   name varchar(100) NOT NULL
my_books(# );
CREATE TABLE
my_books=# CREATE TABLE books (
my_books(#   id serial PRIMARY KEY,
my_books(#   title varchar(100) NOT NULL,
my_books(#   isbn char(13) UNIQUE NOT NULL,
my_books(#   author_id int REFERENCES authors(id)
my_books(# );

CREATE TABLE
my_books=# \d books
Table "public.books"
Column     |          Type          |                     Modifiers
- ---------------+------------------------+----------------------------------------------------
id             | integer                | not null default nextval('books_id_seq'::regclass)
title          | character varying(100) | not null
isbn           | character(13)          | not null
author_id      | integer                |
Indexes:
"books_pkey" PRIMARY KEY, btree (id)
"books_isbn_key" UNIQUE CONSTRAINT, btree (isbn)
"books_author_id_idx" btree (author_id)
Foreign-key constraints:
"books_author_id_fkey" FOREIGN KEY (author_id) REFERENCES authors(id)
```

# 16

If we create a table with an id column and specify it as serial, and we look at the schema of that table, what will be shown as a Type of id? Why? 

By setting a data type to `serial`, you're effectively setting a unique integer data type. `serial` creates a new sequence, starting at integer `1`, that increments by `1` each time a new row is created.

# 17

Consider the following code: What type of statement is this code presenting? Explain all components of this statement.

```sql
SELECT age, full_name FROM students
WHERE id < 2;
```

This is a `SELECT` query, which utilizes the **Data Management Language** SQL sublanguage, that is retrieving the `age` and `full_name` from the `students` relation where the row's `id` is less than `2`.

Broken apart, `SELECT` indicates which attributes will be returned, `FROM` describes which relation the data is getting pulled from, and `WHERE` instructs which rows will be included in the returned table based upon a conditional statement.

# 18

Consider the code below: Will this result in an error? Why or why not? If not what will be the output of that code?

```sql
SELECT full_name FROM students WHERE full_name ILIKE '%Johanson';
```

This example will not throw an error. The query is retrieving the `full_name` values from the `students` relation where the value of `full_name` ends with `'johanson'`, case in-sensitive. There is nothing syntactically incorrect with the code, the results would simply depends on what exists within the `students` relation.

# 19

Consider the code below: Will this result in an error? Why or why not? If not what will be the output of that code?

```sql
SELECT name, age FROM students WHERE age = NULL;
```

This would not throw an error, however the results would most likely be unexpected. `NULL` should not be used in a conditional statement, as it's technically not a value. The returned table will most likely have 0 rows returned. Instead, `age IS NULL` should be used, which will return the rows where `age` has no value.

# 20

Consider the code below: Which of the following names would be returned and why?

- Johanson
- 'Johanson Branson'
- 'Eva B. Johanson'
- 'johanson'

```sql
SELECT full_name FROM students WHERE full_name ILIKE '%Johanson';
```

This query will return the value of `full_name` from 3 rows: that containing `'Johanson'`, `'Eva B. Johanson'`, and `'johanson'`.

The `ILIKE` statement compares the argumented value with the column value in a case-insensitive manner. The syntax of `'%Johanson'` essentially means that 0 or more characters can come before `'Johanson'`, but nothing can come after, which is why `'Johanson Branson'` is not returned.

# 21

Consider the students table below: Write a query that retrieves all the names of kids for whom the value of participated column is not true.

```
name   |   age   |   participated
---------------------------------
'Ann'  |   13    |   t
'Ben'  |   12    |   
'Emma' |   15    |   f
'Kat'  |   12    |   f
```

```sql
SELECT name FROM kids
 WHERE participated != true
    OR participated IS NULL;
```

An important thing to note here is that `IS NULL` has to be specified, as any null values will return a null value, which is not a truthy evaluation; because of that, those results would *not* be included in the returned table.

# 22

Consider the error message below: What does this error message tell us? Write a statement that could cause an error like that and describe ways to resolve this error.

```
ERROR:  column "users.full_name" must appear in the GROUP BY clause or be used in an aggregate function
```

The above error is thrown when attempting to create a new table with multiple for a  column existing within a single row, without any instructions on how to display them.

To demonstrate, imagine there is a table `artists` with columns `name` and `favorite_color`. Say we wanted to display a new table with all potential colors and the amount of artists who chose them. You might start with this query:

```sql
SELECT favorite_color, name
  FROM artists
 GROUP BY favorite_color;
```

This will, however, throw the above error. Although we are grouping the data by `favorite_color`, this will retrieve multiple results for `name`, and the database won't know what to do with such data. This is where an aggregate function comes in handy, as it performs an action on the data from this column. To see how many artists chose that color, we could `COUNT` the number of names that appear.

```sql
SELECT favorite_color, COUNT(name)
  FROM artists
 GROUP BY favorite_color;
```

Now, there is but one piece of data per group, so the database has no issues displaying it.

# 23

Consider a `students` table below:

```
id |    name    |    year_of_birth    |    grade
-------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A
2  |  'Maggie'  |   1975-04-11        |   B+
3  |  'Elenore' |   1995-03-13        |   A-
```

1. Write a query that returns names of students who were born in April
2. Write a query that returns names of students who were born on 11th of April
3. Write a query that returns  all students who were born in 1986
4. Write a query that returns the oldest person

## 1

```sql
SELECT name FROM students
 WHERE date_part('month', year_of_birth) = 4;
```

## 2

```sql
SELECT name FROM students
 WHERE date_part('month', year_of_birth) = 4
   AND date_part('day', year_of_birth) = 11;
```

## 3

```sql
SELECT * FROM students
 WHERE date_part('year', year_of_birth) = 1986;
```

## 4

```sql
SELECT name AS oldest_person
  FROM students
 ORDER BY year_of_birth 
 LIMIT 1;
```

# 24

What syntax would you use to remove all rows from an imaginative `students` table? Present a code that illustrates that.

```sql
DELETE FROM students;
```

# 25

Why do we need to create multiple tables instead of just keeping all the data in one table?

Separating data into multiple tables helps to *normalize* the data, which is the process of abstracting schema to prevent repetitive data entries, improve data integrity, and minimize data management anomalies. As an example, say we want to change a customer's email address in a single table that houses all customer purchases at a store. Because only one table is utilized, an **update anomaly** occurs, meaning that the email has to be updated for *every entry* of the customer. This would be a simpler a process if the customer's information existed in its own, separate table, that way the email can be updated and any relation that is linked to this `customers` table will see the update.

# 26

Consider the following `students` table: 

```
id |    name    |    year_of_birth    |    grade |  class
-----------------------------------------------------------
1  |  'Eddie'   |   1986-01-01        |   A      |  Math
2  |  'Maggie'  |   1975-04-11        |   B+     |  History
3  |  'Elenore' |   1995-03-13        |   A-     |  French
```

1. We no longer want to have classes at the same table as students. What are the steps you would take to create another table `classes` and create a relationship between `students` and `classes`.
2. Create `classes` table and the relationship between `classes` and `students`.

## 1 & 2

The first step would be to create a new `classes` table that contains each of the academic classes used within the `students` table.

```sql
CREATE TABLE classes (
  id serial PRIMARY KEY,
  subject varchar UNIQUE NOT NULL
);

INSERT INTO classes (subject)
VALUES ('Math'),
       ('History'),
       ('French');
```

Then, `students.class` should be dropped and replaced with `students.class_id`, referencing the `id` of the respective subject using a *foreign key*.

```sql
ALTER TABLE students
 DROP COLUMN class;

ALTER TABLE students
 ADD COLUMN class_id int REFERENCES classes (id);
```

Lastly, the `id` of the corresponding should be added to the new column for each entry.

```sql
UPDATE students SET class_id = 1 WHERE id = 1;
UPDATE students SET class_id = 2 WHERE id = 2;
UPDATE students SET class_id = 3 WHERE id = 3;
```

# 27

What benefits does presenting cardinality give us? How may the information that representing cardinality in our diagrams be useful for the database design?

Cardinality displays the number of objects on each side of a relationship, which can aid in understanding how the relations are linked together. For example, if we were running a bookstore, 2 tables might exist: `books` and `authors`. A book may have one single author, while that author may have written many books, creating a *one-to-many* relationship. Thus, `books` would have `1` cardinality while `authors` would have `many`, denoted by a single line and crow's foot notation, respectively. Seeing this cardinality makes it easier to understand how these relations are linked from a quick viewing.

# 28

Consider the ERD below. Describe the relationships between those entities:

The first example demonstrates a **one-to-many** relationship, as a Director can have many films, but a Film can only have one director.

The second example demonstrates a few relationships:

- A **one-to-many** relationship between a Student and a University.
- A **one-to-many** relationship between a University and a Scholarship.
- A **many-to-many** relationship between a Student and a Scholarship.

# 29

Consider the following diagram. Describe what is the cardinality between entities?

Same answer as 29, with one-to-many being represented by 1:M and many-to-many represented by M:M.

# 30

Consider the two tables below:

```
SELECT * FROM customers;
customer_id | name  
-------------+-------
           1 | Johny
           2 | Ben
           3 | Gary

SELECT * FROM orders;
order_id | customer_id | orders 
----------+-------------+--------
        1 |           1 | book
        2 |           2 | mug
        3 |           3 | chair

\d orders 

Column    |  Type   | Collation | Nullable |                 Default                  
-------------+---------+-----------+----------+------------------------------------------
 order_id    | integer |           | not null | nextval('orders_order_id_seq'::regclass)
 customer_id | integer |           |          | 
 orders      | text    |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
```

What will happen if we run the following statement? Why? 

```sql
DELETE FROM customers WHERE customer_id = 3;
```

When attempting to delete this row, an error will be thrown, stating that `customer_id` cannot be referenced using the foreign key as it does not exist. Put simply, because the row containing the unique value of `3` for `customers.customer_id` is getting deleted, the row from `orders` that references it (third row) will no longer have a valid row that it is referencing, so the error is thrown.

# 31

Consider the error below: Why is this error raised? What can be done to eliminate this error?

```
ERROR:  update or delete on table "customers" violates foreign key constraint "orders_customer_id_fkey" on table "orders"
DETAIL:  Key (customer_id)=(3) is still referenced from table "orders".
```

This is the error thrown from the previous example. In order to prevent this in the future, when creating the `orders.customer_id` foreign key row, `ON DELETE CASCADE` should be included. This will automatically delete any rows that have a link to the deleted row.

# 32

Consider the code below. What type of cardinality does this example present? Explain how did you deduce that.

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
		ON DELETE CASCADE
);
```

These sql queries suggest the creation of a one-to-one relationship, or a 1:1 cardinality. This is because a primary key is, by default, a unique value; therefore, when used to reference a specific student from the `students` table using the foreign key, only one relationship is able to be linked, creating a one-to-one relationship.

# 33

Consider two tables below: Why we can add a student without an address but can't add an address without a student?

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
		ON DELETE CASCADE
);
```

Adding an address without a student breaks the primary key constraint which requires a `student_id` to be present when adding data to the relation. Anything added to the `students` relation only requires a general `id`; however, the `student_id` column (which serves as the surrogate key) must exist and references a student in the `students` relation. Therefore, if the student does not already exist, the address cannot be added.

# 34

Consider two tables below: What will happen if we delete a row in a students table, that is referenced by a record in  addresses table? 

```sql
CREATE TABLE students (
	id serial PRIMARY KEY,
	name varchar(100) 
);   

CREATE TABLE addresses (
	student_id int, 
	address text,
	city text,
	PRIMARY KEY (student_id),
	FOREIGN KEY (student_id) REFERENCES students (id)
);
```

This action would throw an error, as the foreign key constraint created from `addresses.student_id` requires that a valid reference exists. If the referenced row is deleted, it will no longer exist and therefore no longer be valid, breaching the constraint rules and throwing an error.

# 35

Consider two tables below: 

```
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

id | name  | class_id 
----+-------+----------
  1 | Harry |        1
  2 | Ben   |        2
  3 | Marry |        3
  4 | Marry |        2
```

Describe what the following statement will do and what will be the result of the query:

```sql
SELECT students.name as "Student Name", classes.name as "Class name"
	FROM students 
	INNER JOIN classes 
	ON students.class_id = classes.id;
```

The above `SELECT` query will return a transient table that contains the `name` of both the student and their respective class, aliased by the names `Student Name` and `Class name`. Because some students have multiple classes, such as `'Marry'`, they will appear twice on within the table, as no `GROUP BY` statement is used.

The transient table should look something like this:

```
Student Name |  Class Name 
-------------+------------
       Harry | math
         Ben | german
       Marry | physics
       Marry | german
```

# 36 & 37

Same as 35

# 38

Consider the following tables:

```
table 'classes'
id |  name   
----+---------
  1 | math
  2 | german
  3 | physics

table 'students'

 id | name  | year_of_birth | class_id 
----+-------+---------------+---------
  1 | Harry |  1987-02-04   |      1
  2 | Ben   |  1976-11-13   |      2
  3 | Marry |  1995-03-21   |      3
  4 | Marry |  1995-03-21   |      2
```

Write a query:

1. Return a list of students names who are born in 90' and attend German classes
2. Return a list of students born in February along with a class they attend.

## 1

```sql
SELECT DISTINCT students.name
  FROM students
  JOIN classes ON class_id = classes.id
 WHERE date_part('year', year_of_birth) BETWEEN 1990 AND 1999
   AND class.name = 'german';
```

## 2

```sql
SELECT DISTINCT students.name AS "Student", classes.name AS "Class Attended"
  FROM students
  JOIN classes ON class_id = classes.id
 WHERE date_part('month', year_of_birth) = 2;
```

# 39

Consider the schema below:

```
Table "public.birds"
 Column  |         Type          | Collation | Nullable |              Default              
---------+-----------------------+-----------+----------+-----------------------------------
 id      | integer               |           | not null | nextval('birds_id_seq'::regclass)
 name    | character varying(25) |           |          | 
 age     | integer               |           |          | 
 species | character varying(15) |           |          | 
Indexes:
    "birds_pkey" PRIMARY KEY, btree (id)
```

Let's say we alter the table with the following command:

```sql
ALTER TABLE birds ADD CHECK (age > 0);
```

Explain what this command does and where will the information be added to the schema?

This command will add a `Check constraint` to the table which verifies that the whatever age inserted into the table is greater than `0`. If the input is not valid, a check constraint error will be thrown and the data will not be inserted into the table.

Within the schema, the new constraint will create a new section below the schema table called `Check constraints`, to which this constraint will be added and named `birds_age_check`.

# 40

Consider the following `students` table:

```
 id | name  | year_of_birth | phone_num     | class_id 
----+-------+---------------+---------------+---------
  1 | Harry |  1987-02-04   |  909432987    |  1
  2 | Ben   |  1976-11-13   |  099876567    |  2
  3 | Marry |  1995-03-21   |  098787654    |  3
  4 | Marry |  1995-03-21   |  908675356    |  2
```

Add the following constraints to the table:

- If there is no `name` given `anonymous` should be added
- `class_id` should always be greater than 0
- `phone_num` should not allow duplicates
- `year_of_birth` should be obligatory

```sql
ALTER TABLE students
      ALTER COLUMN name SET DEFAULT 'anonymous',
        ADD CHECK (class_id > 0),
        ADD UNIQUE (phone_num),
      ALTER COLUMN year_of_birth SET NOT NULL;
```

# 41

Consider the code below. Will the following code result in an error, why?

```sql
CREATE TABLE some_table(
  name varchar(50) CHECK(length(name)> 1)
  last_name varchar(100)
);

INSERT INTO some_table (last_name) VALUES ('Ericsson');
```

This will not result in an error. Although a null value is inputed for the `name` column, which contains a `Check constraint`, PostgreSQL permits the inclusion. This is due to the way that the RDBMS hanldes null values. There is no value to compare against the check constraint, so the check is skipped. To prevent this, a `NOT NULL` constraint should be added to the column to ensure that null values are not inputted.

# 42

Consider the code snippet below. What SQL sub-language does this code present?

```sql
ALTER TABLE elephants
	 DROP CONSTRAINT some_const;
```

This code snippet presents the **Data Defintiion Language** SQL sub-language, which is involved with altering the *structure* of a database or relation.

# 43

Consider the code snippet below. What SQL sub-language does this code present?

```sql
UPDATE elephants 
	SET num_legs = 4
	WHERE num_legs = 5;
```

This code snippet presents the **Data Management Language** SQL sub-language, which is involved with modifying the *data* stored within a database.

# 44

Consider the table below:

```sql
CREATE TABLE students (
  id serial PRIMARY KEY,
  name varchar(25),
  age int 
);

INSERT INTO students (name, age) 
  VALUES ('Mary', 11), ('John', 12), ('Valery', 12);
```

Will the following code result in an error? What is the code trying to do?

```sql
ALTER TABLE students
ALTER COLUMN name TYPE varchar(1);
```

How about this code?

```sql
ALTER TABLE students 
  ALTER COLUMN name TYPE varchar(100);
```

Yes, the first example will result in an error. Originally, the `name` column was set with a data type of `Varying Character` that can have up to `25` characters, all of which were in compliance. When changing the length down to `1`, `'Mary'` is now in breach, and therefore an error is thrown.

The second example, however, would not. The max length of characters allowed increased, which all values will still be in compliance with. Only when the values break the character rule is an error thrown.

# 45

Consider the `students` below:

```
id | name  |year_of_birth|phone_num    | average_points 
----+-------+---------------+---------------+---------
 1 | Harry | 1987-02-04 |  909432987   |  1
 2 | Ben   | 1976-11-13 |  099876567   |  6
 3 | Marry | 1995-03-21 |  098787654   |  7
 4 | Marry | 1995-03-21 |  908675356   |  0
```

The schema is as follows:

```
Table "public.students"
     Column     |  Type   | Collation | Nullable |               Default                
----------------+---------+-----------+----------+--------------------------------------
 id             | integer |           | not null | nextval('students_id_seq'::regclass)
 name           | text    |           | not null | 
 year_of_birth  | text    |           |          | 
 phone_num      | text    |           |          | 
 average_points | integer |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (id) 
```

- change `name` data type to take strings with max length of 50
- change `year_of_birth` data type to `DATE`
- change `phone_num` data type to be an integer
- change `average_points` to be able to take decimal point numbers that must be greater than 0 but less than 10
- add a new column called `highest_grade` that is obligatory and can take a string with max length of 1 character.
- now change the data type of `highest_grade` to only accept one of the following characters: ('A', 'B', 'C', 'D', 'F')

Remember that data is already inputted in the table.

```sql
ALTER TABLE students
      ALTER COLUMN name TYPE varchar(50),
      ALTER COLUMN year_of_birth TYPE date,
      ALTER COLUMN phone_num TYPE int,
      ALTER COLUMN average_points numeric,
      ADD CHECK average_points > 0
      ADD COLUMN highest_grade varchar(1) NOT NULL,
      ADD CHECK (highest_grade IN ('A', 'B', 'C', 'D', 'F'));
```



