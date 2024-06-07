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