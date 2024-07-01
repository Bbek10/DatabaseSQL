psql --username=freecodecamp --dbname=postgres

Your database isn't here. You can use the `.sql` file you created at the end of Part 1 to rebuild it. I recommend "splitting" the terminal. You can do that by clicking the "hamburger" menu at the top left of the window, going to the "Terminal" menu, and clicking "Split Terminal". Once you've done that, enter `psql -U postgres < students.sql` in it to rebuild the database.

psql -U postgres < students.sql

## WHERE CLAUSE

students=> SELECT first_name, last_name, gpa FROM students WHERE gpa < 2.5;

The `<` only return rows where the `gpa` column was less than `2.5`. Some other operators are: `<`, `>`, `<=`, `>=`. View the same columns, but only rows for students with a `gpa` greater than or equal to `3.8`.

 SELECT first_name, last_name, gpa FROM students where gpa >= 3.8;

That only returned students with a GPA of 3.8 or better. There's equal (`=`) and not equal (`!=`) operators as well. View the same columns for students that don't have a 4.0 gpa.

 SELECT *  FROM majors where major != 'Game Design';

 SELECT *  FROM majors where major > 'Game Design';

 SELECT *  FROM majors where major  ≥ 'Game Design';

 SELECT *  FROM majors where major  < 'G';

SELECT * FROM students WHERE last_name < 'M';

### AND OR with WHERE

SELECT * FROM students WHERE last_name < 'M' OR gpa = 3.9;

SELECT * FROM students WHERE last_name < 'M' AND gpa = 3.9;

SELECT * FROM students WHERE last_name < 'M' AND gpa = 3.9 OR gpa < 2.3;

This showed all students whose GPA is less than 2.3 because the final `OR` condition was true for them. It didn't matter what their last name started with. You can group conditions together with parenthesis like this: `WHERE <condition_1> AND (<condition_2> OR <condition_2>)`. This would only return rows where `<condition_1>` is true and one of the others is true. View students whose last name is before `M` that have a GPA of 3.9 or less than 2.3.

SELECT * FROM students WHERE last_name < 'M' AND  (gpa = 3.9 OR gpa < 2.3);

### PATTERN FINDING  LIKE

There's a few that contain the word Algorithms. You can use LIKE to find patterns in text like this: WHERE <column> LIKE '<pattern>'. An underscore (_) in a pattern will return rows that have any character in that spot. View the rows in this table with a course name that matches the pattern '_lgorithms'.

### _

SELECT * FROM courses where course LIKE '_lgorithms';

%

SELECT * FROM courses where course LIKE '%lgorithms';

Combine the two pattern matching characters to show courses that have a second letter of e.

 SELECT * FROM courses where course LIKE '_e%';

Nice job! Try viewing the courses with a space in their names

 SELECT * FROM courses where course LIKE '% %';

 SELECT * FROM courses where course NOT LIKE '% %';

### ILIKE

`ILIKE` will ignore the case of the letters when matching. Use it to see the courses with an `A` or `a`.

Get A Hint

SELECT * FROM courses where course ILIKE '%A%';

SELECT * FROM courses where course NOT ILIKE '%A%';

You combine these like any other conditions. View the courses that don't have a capital or lowercase

SELECT * FROM courses where course NOT ILIKE '%A%' AND course LIKE '% %';

### IS NULL

SELECT * FROM students WHERE gpa IS NULL;

SELECT * FROM students WHERE gpa IS NOT NULL;

SELECT * FROM students WHERE major_id IS NULL AND gpa IS NOT NULL;

### ORDER BY

SELECT * FROM students ORDER BY gpa;

That put the lowest GPA's at the top. When using `ORDER BY`, it will be in ascending (`ASC`) order by default. Add `DESC` (descending) at the end of the last query to put the highest ones at the top.