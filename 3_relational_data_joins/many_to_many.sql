-- 1

ALTER TABLE books_categories
ALTER COLUMN book_id SET NOT NULL,
ALTER COLUMN category_id SET NOT NULL,
 DROP CONSTRAINT books_categories_book_id_fkey,
 DROP CONSTRAINT books_categories_category_id_fkey,
  ADD FOREIGN KEY (book_id)
      REFERENCES books (id) ON DELETE CASCADE,
  ADD FOREIGN KEY (category_id)
      REFERENCES categories (id) ON DELETE CASCADE;

-- 2

SELECT books.id,
       author,
       string_agg(categories.name, ', ') AS categories
  FROM books
  JOIN books_categories ON books.id = books_categories.book_id
  JOIN categories ON categories.id = books_categories.category_id
 GROUP BY books.id
 ORDER BY books.id;

-- 3

ALTER TABLE books
ALTER COLUMN author TYPE varchar(50),
ALTER COLUMN title TYPE varchar(50);

INSERT INTO books (title, author)
VALUES ('Sally Ride: America''s First Woman in Space', 'Lynn Sherr'),
       ('Jane Eyre', 'Charlotte Brontë'),
       ('Vij''s Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala and Vikram Vij');

INSERT INTO categories (name)
VALUES ('Space Exploration'),
       ('Cookbook'),
       ('South Asia');

INSERT INTO books_categories
VALUES (4, 5),
       (4, 1),
       (4, 7),
       (5, 2),
       (5, 4),
       (6, 8),
       (6, 1),
       (6, 9);

-- 4

ALTER TABLE books_categories
  ADD UNIQUE (book_id, category_id);

-- 5

SELECT name,
       COUNT(books.id) AS book_count,
       string_agg(title, ', ') AS book_titles
  FROM books
  JOIN books_categories ON books.id = books_categories.book_id
  JOIN categories ON categories.id = books_categories.category_id
 GROUP BY name
 ORDER BY name;