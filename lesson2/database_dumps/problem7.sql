SELECT title, extract("year" from current_date) - "year" AS age
  FROM films
 ORDER BY age;