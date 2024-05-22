The `\d` meta command allows a user to view the argument table's structure. We can view the structure of `weather` as such:

```
database=# \d weather

       Table "public.weather"
  Column  |     Type     | Modifiers
----------+--------------+-----------
 date     | date         | not null
 low      | integer      | not null
 high     | integer      | not null
 rainfall | numeric(6,3) | default 0
```