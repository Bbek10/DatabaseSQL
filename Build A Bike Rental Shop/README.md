# **PostgresSQL Build a Bike Rental Shop**

In this 210-lesson course, you will build an interactive Bash program that stores rental information for your bike rental shop using PostgreSQL.

`pg_dump --clean --create --inserts --username=freecodecamp bikes >  bikes.sql`

Your database isn't here. You can use the `.sql` file you created  to rebuild it. I recommend "splitting" the terminal. You can do that by clicking the "hamburger" menu at the top left of the window, going to the "Terminal" menu, and clicking "Split Terminal". Once you've done that, enter `psql -U postgres < bikes.sql` in it to rebuild the database.