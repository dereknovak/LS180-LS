-- 2

INSERT INTO films
VALUES (DEFAULT, 'Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
       (DEFAULT, 'Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);

-- 3

SELECT DISTINCT genre FROM films;

-- 4

SELECT genre AS "All genres"
  FROM films
 GROUP BY genre;

-- 5

SELECT ROUND(AVG(duration)) AS "Average duration" FROM films;

-- 6

SELECT genre, ROUND(AVG(duration)) AS average_duration
  FROM films
 GROUP BY genre;

-- 7

SELECT year / 10 * 10 AS decade, ROUND(AVG(duration)) AS average_duration
  FROM films
 GROUP BY decade
 ORDER BY decade ASC;

-- 8

SELECT * FROM films
 WHERE director LIKE 'John%';

-- 9

SELECT genre, count(id)
  FROM films
 GROUP BY genre
 ORDER BY count DESC;

-- 10

SELECT year / 10 * 10 AS decade, genre, string_agg(title, ', ') AS "films"
  FROM films
 GROUP BY decade, genre
 ORDER BY decade, genre;

-- 11

SELECT genre, sum(duration) AS total_duration
  FROM films
 GROUP BY genre
 ORDER BY total_duration, genre;