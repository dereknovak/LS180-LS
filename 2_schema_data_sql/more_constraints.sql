-- 1

DROP TABLE IF EXISTS public.films;

CREATE TABLE films (title varchar(255), year integer, genre varchar(100), director varchar(255), duration integer);

INSERT INTO films(title, year, genre, director, duration) VALUES ('Die Hard', 1988, 'action', 'John McTiernan', 132);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('Casablanca', 1942, 'drama', 'Michael Curtiz', 102);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('The Conversation', 1974, 'thriller', 'Francis Ford Coppola', 113);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

-- 2

ALTER TABLE films ALTER title SET NOT NULL;
ALTER TABLE films ALTER year SET NOT NULL;
ALTER TABLE films ALTER genre SET NOT NULL;
ALTER TABLE films ALTER director SET NOT NULL;
ALTER TABLE films ALTER duration SET NOT NULL;

-- 3

/*
NOT NULL will set `Nullable` to `not null` for each respective column.
*/

-- 4

ALTER TABLE films
  ADD CONSTRAINT unique_title UNIQUE (title);

-- 5

/*
The constraint is added as part of the `Indexes`, which will check whether data
inputted has a unique `title` value.
*/

-- 6

ALTER TABLE films
 DROP CONSTRAINT unique_title;

-- 7

ALTER TABLE films
  ADD CONSTRAINT title_not_empty CHECK (length(title) > 0);

-- 8

/*
A `check constraint` error will be thrown.

ERROR:  new row for relation "films" violates check constraint "title_not_empty"
DETAIL:  Failing row contains (, 2010, science fiction, Christopher Nolan, 148).
*/

INSERT INTO films
VALUES ('', 2010, 'science fiction', 'Christopher Nolan', 148);

-- 9

/*
It is displayed as part of `Check constraints`.

Check constraints:
    "title_not_empty" CHECK (length(title::text) > 0)
*/

-- 10

ALTER TABLE films
 DROP CONSTRAINT title_not_empty;

-- 11

ALTER TABLE films
  ADD CONSTRAINT modern_film
      CHECK (year BETWEEN 1900 AND 2100);

-- 12

/*
It is displayed as part of `Check constraints`.

Check constraints:
    "modern_film" CHECK (year >= 1900 AND year <= 2100)
*/

-- 13

ALTER TABLE films
  ADD CONSTRAINT valid_director
      CHECK (
            length(director) >= 3
            AND director LIKE '% %'
      );

-- 14

/*
It is displayed as part of `Check constraints`.

Check constraints:
    "modern_film" CHECK (year >= 1900 AND year <= 2100)
    "valid_director" CHECK (length(director::text) >= 3 AND director::text ~~ '% %'::text)
*/

-- 15

UPDATE films
   SET director = 'Johnny'
 WHERE title = 'Die Hard';

/*
ERROR:  new row for relation "films" violates check constraint "valid_director"
DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).
*/

-- 16

/*
1. NOT NULL constraint
2. Check constraint
3. Data type
*/

-- 17

/*
While it is possible to define a default value that violates a constraint, if
that default value is utilized when inputting data, an error will be thrown.
*/

CREATE TABLE default_test (
       name varchar(25),
       age int DEFAULT 0
);

ALTER TABLE default_test
  ADD CONSTRAINT non_zero
      CHECK (age >= 1);

INSERT INTO default_test (name)
VALUES ('Bob');  -- error

-- 18

/*
You can view all constraints on a table using `\d table_name`.
*/