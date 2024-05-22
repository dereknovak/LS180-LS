ALTER TABLE temperatures
ALTER COLUMN rainfall TYPE decimal(5, 3);

UPDATE temperatures
   SET rainfall = rainfall / 25.4;

