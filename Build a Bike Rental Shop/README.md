PostgresSQL Build a Bike Rental Shop

In this 210-lesson course, you will build an interactive Bash program that stores rental information for your bike rental shop using PostgreSQL.

`pg_dump --clean --create --inserts --username=freecodecamp bikes >  bikes.sql`

Your database isn't here. You can use the `.sql` file you created  to rebuild it. I recommend "splitting" the terminal. You can do that by clicking the "hamburger" menu at the top left of the window, going to the "Terminal" menu, and clicking "Split Terminal". Once you've done that, enter `psql -U postgres < bikes.sql` in it to rebuild the database.

ADDING PSQL variable to SCRIPT SHELL

PSQL="psql -X --username=freecodecamp --dbname=bikes --tuples-only -c”

FOREIGN KEY

ALTER TABLE rentals ADD FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

INSERTING 

INSERT INTO bikes(type,size) VALUES('Road', 27);

INSERTING multiple

INSERT INTO bikes(type, size) VALUES('Road', 28), ('Road', 29);

CASE STATEMENTS in BASH

Instead of directly printing the list, `pipe` the output into a `while` loop that reads each line. Here's how that looks:

```
 case $MAIN_MENU_SELECTION in
    1) RENT_MENU ;;
    2) RETURN_MENU ;;
    3) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
```

`SELECT * FROM bikes INNER JOIN rentals USING(bike_id) INNER JOIN customers USING(customer_id);`

`SELECT bike_id, type, size FROM bikes INNER JOIN rentals USING(bike_id) INNER JOIN customers USING(customer_id) WHERE phone = '555-5555' AND date_returned IS NULL;`

`SELECT bike_id, type, size FROM bikes INNER JOIN rentals USING(bike_id) INNER JOIN customers USING(customer_id) WHERE phone = '555-5555' AND date_returned IS NULL ORDER BY bike_id;`

Now you can be certain there's a space at the end. Within the subshell of the last command, use a pipe and the `sed` command to replace the first space with no space. Here's the `sed` replacement pattern you want: `'s/ //'`.

1. The previous command was `echo "$(echo ' M e ')."`

2. Here's an example of how the subshell should look: `$(echo ' M e ' | sed <pattern>)`

3. This is the exact subshell: `$(echo ' M e ' | sed <pattern>)`