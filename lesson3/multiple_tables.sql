-- 2

SELECT COUNT(*) FROM tickets;

-- 3

SELECT COUNT(DISTINCT customer_id) FROM tickets;

-- 4

SELECT ROUND(COUNT(DISTINCT tickets.customer_id)
            / COUNT(DISTINCT customers.id)::decimal * 100, 2)
       AS percent
  FROM customers
  LEFT JOIN tickets
    ON customers.id = tickets.customer_id;

-- 5

SELECT events.name, COUNT(tickets.id) AS popularity
  FROM events
  LEFT OUTER JOIN tickets
    ON events.id = tickets.event_id
 GROUP BY events.name
 ORDER BY popularity DESC;

-- 6

SELECT customers.id, email, COUNT(DISTINCT tickets.event_id)
  FROM customers
  JOIN tickets
    ON customers.id = tickets.customer_id
 GROUP BY customers.id
HAVING COUNT(DISTINCT tickets.event_id) = 3;

-- 7

SELECT events.name, starts_at, sections.name, row, seats.number
  FROM events
  JOIN tickets
    ON events.id = tickets.event_id
  JOIN seats
    ON tickets.seat_id = seats.id
  JOIN sections
    ON seats.section_id = sections.id
  JOIN customers
    ON tickets.customer_id = customers.id
 WHERE email = 'gennaro.rath@mcdermott.co';