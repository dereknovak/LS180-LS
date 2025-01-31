-- 1

CREATE TABLE people (
       id serial PRIMARY KEY,
       name varchar(25) NOT NULL,
       age int CHECK (age > 0),
       occupation varchar(25)
);

-- 2

INSERT INTO people
VALUES (DEFAULT, 'Abby', 34, 'biologist'),
       (DEFAULT, 'Mu''nisah', 26, NULL),
       (DEFAULT, 'Mirabelle', 40, 'contractor');

-- 3

SELECT * FROM people
 WHERE name = 'Mu''nisah';

SELECT * FROM people
 WHERE age < 30;

 SELECT * FROM people
  WHERE occupation IS NULL;

-- 4

CREATE TABLE birds (
       id serial PRIMARY KEY,
       name varchar(25) NOT NULL,
       length decimal(3,1) CHECK (length > 0),
       wingspan decimal(3,1) CHECK (wingspan > 0),
       family varchar(25) NOT NULL,
       extinct boolean
);

-- 5

INSERT INTO birds
VALUES (DEFAULT, 'Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
       (DEFAULT, 'American Robin', 25.5, 36.0, 'Turdidae', false),
       (DEFAULT, 'Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true),
       (DEFAULT, 'Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
       (DEFAULT, 'Common Kestrel', 35.5, 73.5, 'Falconidae', false);

-- 6

SELECT name, family
  FROM birds
 WHERE extinct = false
 ORDER BY length DESC;

-- 7

SELECT round(avg(wingspan), 1),
       min(wingspan),
       max(wingspan)
  FROM birds;

-- 8

CREATE TABLE menu_items (
       id serial PRIMARY KEY,
       item varchar(25) NOT NULL,
       prep_time int CHECK (prep_time > 0),
       ingredient_cost numeric(4, 2),
       sales int,
       menu_price numeric(4, 2)
);

-- 9

INSERT INTO menu_items
VALUES (DEFAULT, 'omelette', 10, 1.50, 182, 7.99),
       (DEFAULT, 'tacos', 5, 2.00, 254, 8.99),
       (DEFAULT, 'oatmeal', 1, 0.50, 79, 5.99);

-- 10

SELECT item, (menu_price - ingredient_cost) AS profit
  FROM menu_items
 ORDER BY profit DESC
 LIMIT 1;

-- 11

/* Amount of time it takes to prepare
Paid $13/hr
Descending
prep_time is in mins and ing_cost/menu_price in dollars/cents

- Divide menu price by prep time
- item/menu_price/ingred_cost/labor/profit
*/

SELECT item,
       menu_price,
       ingredient_cost,
       round((13.00 / 60) * prep_time, 2) AS labor,
       menu_price - (ingredient_cost + round((13.0 / 60) * prep_time, 2)) AS profit
  FROM menu_items
 ORDER BY profit DESC;
