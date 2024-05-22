SELECT date, ROUND((low + high) / 2.0, 1) AS average
  FROM temperatures
 LIMIT 7
OFFSET 1;

-- OR

SELECT date, ((high + low) / 2.0)::decimal(3, 1) AS average
  FROM temperatures
 WHERE date BETWEEN '2016-03-02' AND '2016-03-08';