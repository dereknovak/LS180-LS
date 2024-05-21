SELECT state, count(state)
  FROM people
 GROUP BY state
 ORDER BY count DESC
 LIMIT 10;