


World Cup Database
This is one of the required projects to earn your certification. For this project, you will create a Bash script that enters information from World Cup games into PostgreSQL, then query the database for useful statistics.
Instructions
Follow the instructions and get all the user stories below to pass to finish the project.
You start with several files, one of them is games.csv. It contains a comma-separated list of all games of the final three rounds of the World Cup tournament since 2014; the titles are at the top. It includes the year of each game, the round of the game, the winner, their opponent, and the number of goals each team scored. You need to do three things for this project:
Part 1: Create the database
Log into the psql interactive terminal with psql --username=freecodecamp --dbname=postgres and create your database structure according to the user stories below.
Don't forget to connect to the database after you create it.
CREATE DATABASE worldcup;
\c world cup;
Part 2: Insert the data
Complete the insert_data.sh script to correctly insert all the data from games.csv into the database. The file is started for you. Do not modify any of the code you start with. Using the PSQL variable defined, you can make database queries like this: $($PSQL "<query_here>"). The tests have a 20 second limit, so try to make your script efficient. The less you have to query the database, the faster it will be. You can empty the rows in the tables of your database with TRUNCATE TABLE games, teams;
You should connect to your worldcup database and then create teams and games tables
CREATE TABLE teams();
CREATE TABLE games();
Your teams table should have a team_id column that is a type of SERIAL and is the primary key, and a name column that has to be UNIQUE
 ALTER TABLE teams ADD COLUMN team_id SERIAL PRIMARY KEY;
ALTER TABLE teams ADD COLUMN name VARCHAR(50) UNIQUE;
Your games table should have winner_id and opponent_id foreign key columns that each reference team_id from the teams table
ALTER TABLE games ADD COLUMN game_id SERIAL PRIMARY KEY;
 ALTER TABLE games ADD COLUMN year INT;
ALTER TABLE games ADD COLUMN round VARCHAR(50);

Your games table should have winner_id and opponent_id foreign key columns that each reference team_id from the teams table
ALTER TABLE games ADD COLUMN winner_id INT NOT NULL;
ALTER TABLE games ADD COLUMN opponent_id INT NOT NUll;


ALTER TABLE games ADD COLUMN winner_goals INT NOT NULL;
ALTER TABLE games ADD COLUMN opponent_goals INT NOT NULL;



All of your columns should have the NOT NULL constraint
​
Your games table should have winner_id and opponent_id foreign key columns that each reference team_id from the teams table
if column needs to be dropped
ALTER TABLE game DROP winner_id;

ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams(team_id); 
ALTER TABLE games ADD FOREIGN KEY (opponent_id) REFERENCES teams(team_id); 
​
Your two script (.sh) files should have executable permissions. Other tests involving these two files will fail until permissions are correct. When these permissions are enabled, the tests will take significantly longer to run
chmod +x insert_data.sh
chmod +x queries.sh
Part 3: Query the database
Try Notion AI
Find pages, get instant answers with Q&A
Table
