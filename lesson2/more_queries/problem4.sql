SELECT substring(email from (position('@' in email) + 1)) AS domain,
       count(id)
  FROM people
 GROUP BY domain
 ORDER BY count DESC;