-- 2

CREATE table directors_films (
  id serial PRIMARY KEY,
  director_id int NOT NULL REFERENCES directors (id) ON DELETE CASCADE,
  film_id int NOT NULL REFERENCES films (id) ON DELETE CASCADE,
  UNIQUE (director_id, film_id)
);

-- 3

INSERT INTO directors_films (film_id, director_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 3),
       (8, 7),
       (9, 8),
       (10, 4);

-- 4

ALTER TABLE films
 DROP COLUMN director_id;

-- 5

SELECT title, name
  FROM films
  JOIN directors_films ON films.id = directors_films.film_id
  JOIN directors ON directors.id = directors_films.director_id
 ORDER BY title;

-- 6

INSERT INTO films (title, year, genre, duration)
VALUES ('Fargo', 1996, 'comedy', 98),
       ('No Country for Old Men', 2007, 'western', 122),
       ('Sin City', 2005, 'crime', 124),
       ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name)
VALUES ('Joel Coen'),
       ('Ethan Coen'),
       ('Frank Miller'),
       ('Robert Rodriguez');

INSERT INTO directors_films (film_id, director_id)
VALUES (11, 9),
       (12, 9),
       (12, 10),
       (13, 11),
       (13, 12),
       (14, 12);

-- 7

SELECT name, COUNT(directors_films.film_id) AS films
  FROM directors
  JOIN directors_films ON directors.id = directors_films.director_id
 GROUP BY name
 ORDER BY films DESC, name;
