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

