-- 1

INSERT INTO calls ("when", duration, contact_id)
VALUES ('2016-01-18 14:47:00', 632, 6);

-- 2

SELECT "when", duration, first_name
  FROM calls
  JOIN contacts ON calls.contact_id = contacts.id
 WHERE contacts.id <> 6;

-- 3

INSERT INTO contacts
VALUES (DEFAULT, 'Merve', 'Elk', 6343511126),
       (DEFAULT, 'Sawa', 'Fyodorov', 6125594874);

INSERT INTO calls
VALUES (DEFAULT, '2016-01-17 11:52:00', 175, 26),
       (DEFAULT, '2016-01-18 21:22:00', 79, 27);

-- 4

ALTER TABLE contacts
ADD CONSTRAINT unique_number UNIQUE (number);

-- 5

INSERT INTO contacts
VALUES (DEFAULT, 'Bob', 'Johnson', 7204890809);

/*
ERROR: duplicate key value violates unique constraint "unique_number"
*/

-- 6

/*
`"when"` requires double-quotation because it is a reserved word in SQL. To
disambiguate `when` being used as a column name, a user can wrap the text in
double-quotes, which tells the RDBM to treat it as such.
*/