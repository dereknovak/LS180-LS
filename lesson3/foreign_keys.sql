-- 2

ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey
FOREIGN KEY (product_id)
  REFERENCES products (id);

-- 3

INSERT INTO products
VALUES (DEFAULT, 'small bolt'),
       (DEFAULT, 'large bolt');

INSERT INTO orders
VALUES (DEFAULT, 1, 10),
       (DEFAULT, 1, 25),
       (DEFAULT, 2, 15);

-- 4

SELECT quantity, products.name
  FROM orders
  JOIN products
    ON orders.product_id = products.id;

-- 5

/*
Yes. While `product_id` is a foregin key, this does not automatically set
`NOT NULL`.
*/

INSERT INTO orders (quantity)
VALUES (25);

-- 6

/*
An error will be thrown because the `null` value from the previous problem still
exists within the table.
*/

ALTER TABLE orders
ALTER COLUMN product_id
  SET NOT NULL;

-- 7

/*
Delete the most recent row, then execute previous command.
*/

DELETE FROM orders
 WHERE id = 4;

ALTER TABLE orders
ALTER COLUMN product_id
SET NOT NULL;

-- 8

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  body text NOT NULL,
  product_id int REFERENCES products (id)
);

-- 9

INSERT INTO reviews
VALUES (DEFAULT, 1, 'a little small'),
       (DEFAULT, 1, 'very round!'),
       (DEFAULT, 2, 'could have been smaller');

-- 10

/*
False.
As seen in problem 5, a foreign key constraint does automatically *not* set
`NOT NULL`.
*/