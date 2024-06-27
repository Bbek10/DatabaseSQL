SQL, or Structured Query Language, is the language for communicating with a relational database.

In this 140-lesson course, you will create a Bash script that uses SQL to enter information about your computer science students into PostgreSQL.

- [Build a Student Database: Part 1](https://www.freecodecamp.org/learn/relational-database/learn-sql-by-building-a-student-database-part-1/build-a-student-database-part-1)

psql --username=freecodecamp --dbname=postgres

\c database;

 CREATE TABLE students();

\d → display shortcut

\l → list 

# Table creation

 CREATE TABLE students();

 CREATE TABLE majors();

 CREATE TABLE majors_courses();

 CREATE TABLE courses();

# student → table_1

ALTER TABLE students ADD COLUMN student_id SERIAL PRIMARY KEY;

ALTER TABLE students ADD COLUMN first_name VARCHAR(50) NOT NULL;

ALTER TABLE students ADD COLUMN last_name VARCHAR(50) NOT NULL;

ALTER TABLE students ADD COLUMN major_id INT;

ALTER TABLE students ADD COLUMN gpa NUMERIC(2,1);

\d students;

INSERT INTO students(first_name, last_name, major_id, gpa) VALUES('Rhea','Kellems',1,2.5);

# majors → table_2

ALTER TABLE majors ADD COLUMN major_id SERIAL PRIMARY KEY;

ALTER TABLE majors ADD COLUMN major VARCHAR(50) NOT NULL;

INSERT INTO  majors(major) VALUES('Database Administration');

# courses→ table_3

ALTER TABLE courses ADD COLUMN course_id SERIAL PRIMARY KEY;

ALTER TABLE courses ADD COLUMN course VARCHAR(100) NOT NULL;

INSERT INTO courses(course) VALUES('Data Structures and Algorithms');

# majors_courses→ table_3

ALTER TABLE majors_courses ADD COLUMN major_id INT;

ALTER TABLE majors_courses ADD COLUMN course_id INT;

INSERT INTO majors_courses(major_id, course_id)  VALUES(1,1);

# FOREIGN KEY assigns

 ALTER table students ADD FOREIGN KEY (major_id) REFERENCES majors(major_id);

ALTER TABLE majors_courses ADD FOREIGN KEY (major_id) REFERENCES majors(major_id);

# COMPOSITE PRIMARY KEY

You can create a composite primary key that uses more than one column as a unique pair like this: `ALTER TABLE <table_name> ADD PRIMARY KEY(<column_name>, <column_name>);` Add a composite primary key to the table using the two columns.

ALTER TABLE majors_courses ADD PRIMARY KEY (major_id, course_id);

# BASH to handle the CSVs

Okay, you added a row into each table. It might be wise to review the data and the database structure. Adding the rest of the info one at a time would be tedious. You are going to make a script to do it for you. I recommend "splitting" the terminal for this part. You can do that by clicking the "hamburger" menu at the top left of the window, going to the "Terminal" menu, and clicking "Split Terminal". Once you've done that, use the `touch` command to create a file named `insert_data.sh` in your `project` folder.

First, you should add all the info from the courses.csv file since you need the major_id for inserting the student info. cat is a terminal command for printing the contents of a file. Here's an example: cat <filename>. Below the comment you added, use it to print courses.csv.

cat courses.csv

It worked. Instead of printing the content, you can pipe that output into a while loop so you can go through the rows one at a time. It looks like this:

```bash
#!/bin/bash
#Script to insert data from courses.csv and students.csv into students database

cat courses.csv | while read MAJOR COURSE
do
  echo $MAJOR
done
```

Each new line will be read into the variables, `MAJOR` and `COURSE`. Add the above to your `cat` command. In the `STATEMENTS` area, use `echo` to print the `MAJOR` variable.

It's looping, but the MAJOR variable is only being set to the first word. There's a default IFS variable in bash. IFS stands for "Internal Field Separator". View it with declare -p IFS

This variable is used to determine word boundaries. It defaults to spaces, tabs, and new lines. This is why the `MAJOR` variable was set to only the first word on each line from the data. Between the `while` and `read` commands, set the `IFS` to a comma like this: `IFS=","`

```bash
cat courses.csv | while IFS="," read MAJOR COURSE
do
  echo $MAJOR $COURSE
done
```

Okay, your loop is working. You can use the `MAJOR` and `COURSE` variables to access the major or course when you need to insert data or query the database. Delete the echo line so you can figure out what to do next.

It helps to plan out what you want to happen. For each loop, you will want to add the major to the database if it isn't in there yet. Same for the course. Then add a row to the `majors_courses` table. Add these single line comments in your loop in this order: `get major_id`, `if not found`, `insert major`, `get new major_id`, `get course_id`, `if not found`, `insert course`, `get new course_id`, `insert into majors_courses`.

You used the `psql` command to log in and interact with the database. You can use it to just run a single command and exit. Above your loop, add a `PSQL` variable that looks like this: `PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"`. This will allow you to query your database from your script. The important parts are the `username`, `dbname`, and the `-c` flag that is for running a single command and exiting. The rest of the flags are for formatting.

`PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"`

Now, you can query your database using the PSQL variable like this: $($PSQL "<query_here>"). The code in the parenthesis will run in a subshell, which is a separate bash process. Below the get major_id comment in your loop, create a MAJOR_ID variable. Set it equal to the result of a query that gets the major_id of the current MAJOR in the loop. Make sure to put your MAJOR variable in single quotes.

1. Here's an example of how it looks: `MAJOR_ID=$($PSQL "<query_here>")`

2. For the query, you want to use the `SELECT`, `FROM`, and `WHERE` keywords

3. Here's an example of how the query part looks: `SELECT <column_name> FROM <table_name> WHERE <condition>`

4. The condition you want is `major='$MAJOR'`

5. Here's how the query should look: `SELECT major_id FROM majors WHERE major='$MAJOR'`

6. Here's how the whole line should look: `MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")`

```bash
#!/bin/bash
#Script to insert data from courses.csv and students.csv into students database
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

cat courses.csv | while IFS="," read MAJOR COURSE

do
  #get major_id
  MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
  #if not found
  #insert major
  #get new major_id
  #get course_id
  #if not found
  #insert course
  #get new course_id
  #insert into majors_courses

done

```

```bash
#!/bin/bash

# Script to insert data from courses.csv and students.csv into students database

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

cat courses.csv | while IFS="," read MAJOR COURSE
do
  # get major_id
  MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
  echo $MAJOR_ID

  # if not found
  if [[ -z $MAJOR_ID ]]
  then
    # insert major
    INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
    # get new major_id
  fi

  

  # get course_id

  # if not found

  # insert course

  # get new course_id

  # insert into majors_courses

done

```

You can use `TRUNCATE` to delete all data from a table. In the psql prompt, try to delete all the data in the majors table by entering `TRUNCATE majors;`

TRUNCATE table1, table2, table3;

pg_dump —help

pg_dump --clean --create --inserts --username=freecodecamp students > students.sql
