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

SELECT * FROM students ORDER BY gpa DESC;

Now, the highest GPA's are at the top. You can add more columns to the order by separating them with a comma like this: `ORDER BY <column_1>, <column_2>`. Any matching values in the first ordered column will then be ordered by the next. View all the student info with the highest GPA's at the top, and in alphabetical order by `first_name` if the GPA's match.

SELECT * FROM students ORDER BY gpa DESC, first_name;

Many times, you only want to return a certain number of rows. You can add `LIMIT <number>` at the end of the query to only get the amount you want. View the students in the same order as the last command, but only return the first 10 rows.

SELECT * FROM students ORDER BY gpa DESC, first_name LIMIT 10;

The order of the keywords in your query matters. You cannot put `LIMIT` before `ORDER BY`, or either of them before `WHERE`. View the same number of students, in the same order, but don't get the ones who don't have a GPA.

SELECT * FROM students WHERE gpa IS NOT NULL ORDER BY gpa DESC, first_name LIMIT 10;

There's a number of mathematic functions to use with numerical columns. One of them is `MIN`, you can use it when selecting a column like this: `SELECT MIN(<column>) FROM <table>`. It will find the lowest value in the column. In the psql prompt, view the lowest value in the `gpa` column of the `students` table.

 SELECT MIN(gpa) FROM students;

 SELECT MAX(gpa) FROM students;

SELECT SUM(major_id) FROM students;

SELECT AVG(major_id) FROM students;

You can round decimals up or down to the nearest whole number with `CEIL` and `FLOOR`, respectively. Use `CEIL` to round the average `major_id` up to the nearest whole number. Here's an example: `CEIL(<number_to_round>)`.

SELECT CEIL(AVG(major_id)) FROM students;

SELECT ROUND(AVG(major_id)) FROM students;

You can round to a specific number of decimal places by adding a comma and number to `ROUND`, like this: `ROUND(<number_to_round>, <decimals_places>)`. Round the average of the `major_id` to five decimal places.
SELECT ROUND(AVG(major_id), 5) FROM students;

Another function is COUNT. You can use it like this: COUNT(<column>). It will tell you how many entries are in a table for the column. Try it out in the psql prompt by using COUNT(*) to see how many majors there are.

SELECT COUNT(*) FROM majors;

### DISTINCT

There's six unique major_id values in the students table. You can get the same results with GROUP BY. Here's an example of how to use it: SELECT <column> FROM <table> GROUP BY <column>. Use this method to view the unique major_id values in the students table again.

 SELECT DISTINCT(major_id) FROM students;

### GROUP BY

There's six unique `major_id` values in the `students` table. You can get the same results with `GROUP BY`. Here's an example of how to use it: `SELECT <column> FROM <table> GROUP BY <column>`. Use this method to view the unique `major_id` values in the `students` table again.
 SELECT major_id FROM students GROUP BY major_id;

The output was the same as `DISTINCT`, but with `GROUP BY` you can add any of the aggregate functions (`MIN`, `MAX`, `COUNT`, etc) to it to find more information. For instance, if you wanted to see how many students were in each major you could use `SELECT COUNT(*) FROM students GROUP BY major_id`. View the `major_id` column **and** number of students in each `major_id`.

SELECT major_id, COUNT(*) FROM students GROUP BY major_id;

When using `GROUP BY`, any columns in the `SELECT` area must be included in the `GROUP BY` area. Other columns must be used with any of the aggregate functions (`MAX`, `AVG`, `COUNT`, etc). View the unique `major_id` values with `GROUP BY` again, but see what the lowest GPA is in each of them.

SELECT major_id, MIN(GPA) FROM students GROUP BY major_id;

 SELECT major_id, MIN(GPA), MAX(GPA) FROM students GROUP BY major_id;

Another option with `GROUP BY` is `HAVING`. You can add it at the end like this: `SELECT <column> FROM <table> GROUP BY <column> HAVING <condition>`. The condition must be an aggregate function with a test. An example to might be to use `HAVING COUNT(*) > 0` to only show what whatever column is grouped that have at least one row. Use `HAVING` to only show rows from the last query that have a maximum GPA of 4.0.

SELECT major_id, MIN(GPA), MAX(GPA) FROM students GROUP BY major_id HAVING MAX(gpa)=4.0;

Two of your majors have at least one student with a 4.0 GPA. Looking at the results, the column is named `min`. You can rename a column with `AS` like this: `SELECT <column> AS <new_column_name>` Enter the same command, but rename the `min` column to `min_gpa`.

SELECT major_id, MIN(GPA) AS min_gpa, MAX(GPA) FROM students GROUP BY major_id HAVING MAX(gpa)=4.0;

That's more descriptive. View the `major_id` and number of students in each `major_id` in a column named `number_of_students`.

SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id;

Use HAVING with the last query to only show the rows with less than eight students in the major.

SELECT major_id, COUNT(*) AS number_of_students FROM students GROUP BY major_id HAVING COUNT(*) < 8;

### JOIN\

The majors and students table are linked with the `major_id` foreign key. If you want to see the name of a major that a student is taking, you need to `JOIN` the two tables into one. Here's an example of how to do that: `SELECT * FROM <table_1> FULL JOIN <table_2> ON <table_1>.<foreign_key_column> = <table_2>.<foreign_key_column>;`

SELECT * FROM students FULL JOIN majors ON students.major_id = majors.major_id;

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/8e7634cf-de4b-4499-9cbe-e74aaf30c3d3/9326e144-05b7-4d53-a45f-924472e477de/Untitled.png)

It's showing all the columns from both tables, the two `major_id` columns are the same in each row for the ones that have it. You can see that there are some students without a major, and some majors without any students. The `FULL JOIN` you used will include **all** rows from both tables, whether or not they have a row using that foreign key in the other. From there, you could use any of the previous methods to narrow down, group, order, etc. 

Use a `LEFT JOIN` to join the same two tables in the same way.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/8e7634cf-de4b-4499-9cbe-e74aaf30c3d3/3af9ba9d-102f-433e-b12b-a787b47dd04c/Untitled.png)

There's a few less rows than the last query. In the `LEFT JOIN` you used, the `students` table was the left table since it was on the left side of the JOIN. majors was the right table. 

A `LEFT JOIN` gets all rows from the left table, but only rows from the right table that are linked to from the left one. Looking at the data, you can see that every student was returned, but the majors without any students were not.

 Join the same two tables with a `RIGHT JOIN` this time.

The right join showed all the rows from the right table (`majors`), but only rows from the left table (`students`) if they have a major. 

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/8e7634cf-de4b-4499-9cbe-e74aaf30c3d3/7b086621-6ac8-49f4-81b3-9c7fdbaef51e/Untitled.png)

Left Join retrieves all the records and the data from the left table and all matching records from the right table. Right Join retrieves all the records and the data from the right table and all matching records from the left table. 

There's one more type you should know about. Join the two tables with an `INNER JOIN`.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/8e7634cf-de4b-4499-9cbe-e74aaf30c3d3/fc228af1-2f15-4cd5-bcdd-89992e83d1b7/Untitled.png)

The `INNER JOIN` only returned students if they have a major and majors that have a student. In other words, it only returned rows if they have a value in the foreign key column (`major_id`) of the opposite table. You should know a little about the four main types of joins now. Try using a `LEFT JOIN` to show **all the majors** but only students that have a major.

SELECT * FROM majors LEFT JOIN students ON majors.major_id = students.major_id;

Excellent. All the majors are there. Next, use the appropriate join to show only students that are enrolled in a major, and only majors that have a student enrolled in it.

SELECT * FROM majors INNER JOIN students ON majors.major_id = students.major_id;

That showed all the students since it was the right table of the `RIGHT JOIN`. Use the appropriate join with the same two table to show all rows in both tables whether they have a value in the foreign key column or not.

SELECT * FROM majors FULL JOIN students ON majors.major_id = students.major_id;

Lets do some more experiments with joins. Say you wanted to find a list of majors that students are taking. Use the most efficient `JOIN` to join the two tables you need. Only join the tables for now, don't use any other conditions.

SELECT * FROM students INNER JOIN majors ON students.major_id = majors.major_id;

Good. To get the list, you don't need all the columns, though. Enter the same command, but just get the column you need.

students=> SELECT major FROM students INNER JOIN majors ON students.major_id = majors.major_id;

+-------------------------+
|          major          |
+-------------------------+
| Database Administration |
| Web Development         |
| Database Administration |
| Game Design             |
| Game Design             |
| Game Design             |
| Game Design             |
| Web Development         |
| Database Administration |
| Data Science            |
| Web Development         |
| Game Design             |
| Web Development         |
| Database Administration |
| Data Science            |
| Game Design             |
| Database Administration |
| Data Science            |
| Web Development         |
| Database Administration |
| Web Development         |
| System Administration   |
| Data Science            |
+-------------------------+
(23 rows)

students=> SELECT DISTINCT(major) FROM students INNER JOIN majors ON students.major_id = majors.major_id;
students=>

+-------------------------+
|          major          |
+-------------------------+
| Database Administration |
| Game Design             |
| Data Science            |
| System Administration   |
| Web Development         |
+-------------------------+

There's your list of majors that students are taking 😄 Next, say you wanted a list of majors that students aren't taking. Use the most efficient `JOIN` to join the two tables you need. Only join the tables for now, don't use any other conditions.

SELECT * FROM students RIGHT JOIN majors ON students.major_id = majors.major_id;

That got you all the majors, you can see the ones that don't have any students. Add a `WHERE` condition to only see the majors without students, use `student_id` in it's condition.

SELECT * FROM students RIGHT JOIN majors ON students.major_id = majors.major_id WHERE student_id IS NULL;

SELECT first_name, last_name, major, gpa FROM students LEFT JOIN majors ON students.major_id = majors.major_id WHERE major='Data Science' OR gpa >= 3.8;

From there, you could put them in a specific order if you wanted or limit the results to a certain number among other things. Lastly, use the most efficient 'JOIN' to join the tables you would need if you were asked to get the first name and major for students whose `first_name`, or the `major`, contains `ri`. Only join the tables for now, don't use any other conditions.

////////////////////////////////////////////////////////////////////////////////////////

If you look at the column names, it shows two `major_id` columns. One from the `students` table and one from the `majors` table. If you were to try and query it using `major_id`, you would get an error. You would need to specify what table you want the column from like this: `<table>.<column>`. Enter the same join but only get the `major_id` column from the `students` table.

SELECT students.major_id FROM students FULL JOIN majors ON students.major_id = majors.major_id;

Earlier, you used `AS` to rename columns. You can use it to rename tables, or give them aliases, as well. Here's an example: `SELECT * FROM <table> AS <new_name>;`. Enter the same query you just entered, but rename the `majors` table to `m`. Anywhere the `majors` table is referenced, you will need to use `m` instead of `majors`

SELECT students.major_id FROM students FULL JOIN majors AS m ON students.major_id = m.major_id;

This doesn't affect the output. It can just make some queries easier to read. Enter the same query, but rename the `students` table to `s` as well.
SELECT s.major_id FROM students AS s FULL JOIN majors AS m ON s.major_id = m.major_id;

There's a shortcut keyword, `USING` to join tables if the foreign key column has the same name in both tables. Here's an example: `SELECT * FROM <table_1> FULL JOIN <table_2> USING(<column>);`. Use this method to see **all** the columns in the `students` and `majors` table. Don't use any aliases.

SELECT * FROM students FULL JOIN majors USING(major_id);

Note that the two `major_id` columns were turned into one with `USING`. In order to find out what courses a student is taking, you will need to join all the tables together. You can add a third table to a join like this: `SELECT * FROM <table_1> FULL JOIN <table_2> USING(<column>) FULL JOIN <table_3> USING(<column>)`. This example will join the first two tables into one, turning it into the left table for the second join. Use this method to join the two tables from the previous query with the `majors_courses` table.

SELECT * FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id);

Note that the two `major_id` columns were turned into one with `USING`. In order to find out what courses a student is taking, you will need to join all the tables together. You can add a third table to a join like this: `SELECT * FROM <table_1> FULL JOIN <table_2> USING(<column>) FULL JOIN <table_3> USING(<column>)`. This example will join the first two tables into one, turning it into the left table for the second join. Use this method to join the two tables from the previous query with the `majors_courses` table.

SELECT * FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id);

You may need to adjust the terminal size to align the output. What you're seeing is every unique combination of rows in the database. Students with a major are listed multiple times, one for each course included in the major. The majors without any students are there along with the courses for them. The students without a major are included, they have no courses and are only listed once. You can join as many tables together as you want. Join the last table to the previous command to get the names of the courses with all this info.

SELECT * FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id) FULL JOIN courses USING(course_id);

Same amount of rows, but you get the course names now. In your script, add the command to print the suggested info..

```bash
#!/bin/bash

# Info about my computer science students from students database

echo -e "\n~~ My Computer Science Students ~~\n"

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE gpa = 4.0")"

echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo "$($PSQL "SELECT course FROM courses WHERE course < 'D'")"

echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE last_name >= 'R' AND (gpa > 3.8 OR gpa < 2.0)")"

echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"
echo "$($PSQL "SELECT last_name FROM students WHERE last_name ILIKE '%sa%' OR last_name ILIKE '%r_'")"

echo -e "\nFirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' or they have a GPA greater than 3.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE major_id IS NULL AND (first_name LIKE 'D%' OR gpa > 3.0)")"

echo -e "\nCourse name of the first five courses, in reverse alphabetical order, that have an 'e' as the second letter or end with an 's':"
echo "$($PSQL "SELECT course FROM courses WHERE course LIKE '_e%' OR course LIKE '%s' ORDER BY course DESC LIMIT 5")"

echo -e "\nAverage GPA of all students rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(gpa), 2) FROM students")"

echo -e "\nMajor ID, total number of students in a column named 'number_of_students', and average GPA rounded to two decimal places in a column name 'average_gpa', for each major ID in the students table having a student count greater than 1:"
echo "$($PSQL "SELECT major_id, COUNT(*) AS number_of_students, ROUND(AVG(gpa), 2) AS average_gpa FROM students GROUP BY major_id HAVING COUNT(*) > 1")"
//REVISE
echo -e "\nList of majors, in alphabetical order, that either no student is taking or has a student whose first name contains a case insensitive 'ma':"
echo "$($PSQL "SELECT major FROM students FULL JOIN majors ON students.major_id = majors.major_id WHERE major IS NOT NULL AND (student_id IS NULL OR first_name ILIKE '%ma%') ORDER BY major")"

echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo "$($PSQL "SELECT DISTINCT(course) FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id) FULL JOIN courses USING(course_id) WHERE student_id IS NULL OR (first_name = 'Obie' AND last_name = 'Hilpert') ORDER BY course DESC")"

echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
echo "$($PSQL "SELECT course FROM students INNER JOIN majors_courses USING(major_id) INNER JOIN courses USING(course_id) GROUP BY course HAVING COUNT(student_id) = 1 ORDER BY course")"

```
