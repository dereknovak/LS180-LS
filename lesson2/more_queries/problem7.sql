UPDATE people
   SET given_name = upper(given_name)
 WHERE email LIKE '%teleworm.us';
